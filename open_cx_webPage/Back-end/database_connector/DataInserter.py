import mysql.connector as SQLC
import configparser
from database_connector.DatabaseCreator import *


class DataInserter ():
    mydatabase = None
    def __init__ (self):
        try:
            provisory_db = DatabaseCreator()
            provisory_db.getDatabaseCredentials()
            self.mydatabase = SQLC.connect(
                host   = provisory_db.host,
                user   = provisory_db.user,
                passwd = provisory_db.password)    
        except Exception as exc:
            print(exc.args)


    def InsertSpeaker (self):
        try :
            mycursor = self.mydatabase.cursor()
            mycursor.execute('USE MYDB')
            mystring = 'insert into MYDB.ROOM (TOTAL_NUMBER_SEATS, SEATS_OCCUPIED, MAP_POSE, ID_CODE ) values ( "30", "2","2.1,4.3","B045")'
            mycursor.execute(mystring)
            mycursor.execute(mystring)
            mycursor.execute(mystring)
            mycursor.execute(mystring)
            mycursor.execute('SELECT * FROM MYDB.room;')
            if (mycursor != None):
                for i in mycursor:
                    print (i)

                    
        except Exception as exc:
            print (exc.args)



    def InserPresentation ():
        try :
            print ('meme')
        except Exception as exc:
            print (exc.args)

    def insertRoom ( ):
        try :
            print ('meme')
        except Exception as exc:
            print (exc.args)