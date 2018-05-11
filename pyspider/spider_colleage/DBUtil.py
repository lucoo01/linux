# -*- coding: utf-8 -*-
#mysql 驱动连接
import pymysql

class DBUtil(object):
    def __init__(self, db):
        self.host = '127.0.0.1'
        self.port = 3306
        self.user = 'root'
        self.password = ''
        self.db = db


    def connect(self):
        try:

            self.connect = pymysql.connect(host=self.host, port=self.port, user=self.user, passwd=self.password, db=self.db, charset='utf8')

            print('获取connect')
            self.cursor = self.connect.cursor() # 获取游标
        except:
            print("error in connect to mysql")

    def save_to_index(self, content, url):
        sql = "INSERT INTO `colleageindex`(name,path) VALUES('%s', '%s')" % (content, url)
        print(sql)

        try:
            self.cursor.execute(sql)
            print('插入当前数据%s成功' % content)
            self.connect.commit()
        except Exception:
            print("insert failed." + Exception)
