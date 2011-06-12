#!/usr/bin/python

import MySQLdb,json,datetime,logging,hashlib,random,sys,time,os,re
log = logging.getLogger(__name__)
log.addHandler(logging.StreamHandler(sys.stdout))
log.setLevel(logging.INFO) ;

letters = 'abcdefghijklmopqrstuvwxyz'
testfields={}



def get_test_item(uid,nofields=False):
    global letters,testfields
        #print uid
    hd = hashlib.md5()
    hd.update(str(uid))
    iid = hd.hexdigest()
    rt= {
                'indexed_id': iid,
		'id':uid
    }
    if nofields: return rt
    #we try to come up with a sort-of random item
    for i in range(10):
        if i not in testfields:
            nstr=''
            strlen = (i+1)*4
            for si in range(strlen):
                nstr+=random.choice(letters)
            testfields[i]=nstr
        else:
            deltr = testfields[i][0]
            testfields[i] = ''.join(list(testfields[i])[1:])
            if ord(deltr)<ord('z'): nltr=chr(ord(deltr)+1)
            else: nltr='a'
            testfields[i]+=nltr # random.choice(letters)
            nstr = testfields[i]

        rt['field_%s'%((i+1)*4)]=nstr
    return rt
inserts=[]

def insappend(ins,nowrite=False):
    global inserts
    colname = 'ndb_test'
    ins['stamp'] = datetime.datetime.now().strftime('%s')
    fname = 'static/%s.data.js'%colname
    log.info(ins)
    if nowrite: 
        log.info('not writing')
        return None

    inserts.append(ins)
    if os.path.exists(fname):
        fp = open(fname,'r')
        dt = fp.read()
        fp.close()
    else:
        dt = 'var data = [];'
    objres = re.compile('var data = (.*);').search(dt)
    if objres:
        objstr = objres.group(1)
    else:
        objstr = '[]';
    obj = json.loads(objstr)
    obj.append(ins)
    fp = open(fname,'w')
    fp.write('var data = %s;'%json.dumps(obj))
    fp.close()

db=MySQLdb.connect(user='root',port=5000,host='127.0.0.1',db="clusterdb")

def insert(amt=100000,selnum=1000,byid=False,nowrite=False):
    global db
    c  = db.cursor()
    c.execute("select count(*) from ndb_test")
    initialamt = curitems = c.fetchone()[0]
    log.info("%s curitems"% curitems)
    #insert
    start_ins = time.time()
    ops=0
    insdone=False
    while curitems<(initialamt+amt):
        ti = get_test_item(curitems+1)
        fns = ti.keys()
        qrystr = "insert into ndb_test (%s) values (%s)"%(', '.join([k for k in fns]),', '.join(['%s' for k in fns]))
        c = db.cursor()
        ret = c.execute(qrystr,[ti[fn] for fn in fns])
        assert ret
        
        curitems+=1
        if curitems % 10000 ==0 : 
            log.info('%s curitems'%curitems)
        ops+=1
        if ops>=15000:
            db.commit()
            log.info('committing after %s ops'%ops)
            ops=0
        insdone=True
    db.commit()
    ins_delta = time.time() - start_ins
    if insdone:
        ins = {'time':ins_delta,'curitems':curitems,'action':'insert'}
        insappend(ins,nowrite)
    #select
    start_sel = time.time()
    for i in range(selnum):
        uid = random.randrange(curitems)
        c = db.cursor()
        indexed_id = get_test_item(uid,True)['indexed_id']
        if byid:
            ret = c.execute("select id,indexed_id from ndb_test where id=%s",uid)
        else:
            ret = c.execute("select id,indexed_id from ndb_test where indexed_id=%s",indexed_id)
        assert ret,"could not locate id %s, indexed_id %s"%(uid,indexed_id)
        fo = c.fetchone() ; 
        assert fo and uid==fo[0] and indexed_id==fo[1],"could not fetch match result for id %s, indexed_id %s"%(uid,indexed_id)
    ins = {'curitems':curitems,'time':time.time()-start_sel,'action':'select%s'%selnum}
    insappend(ins,nowrite)

while True:
    insert(selnum=1000,byid=True,nowrite=False)
