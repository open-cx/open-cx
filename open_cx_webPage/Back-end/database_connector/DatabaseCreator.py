import mysql.connector as SQLC
import configparser

class DatabaseCreator ():
    '''
        Class used to create a database for the project.
        Mysql database creator
    ''' 

    #Credentials to acess database
    host=''
    user=''
    password=''

    def __init__ (self):
        print ('Database initialized.')

    def getDatabaseCredentials (self):
        try:
            configParser = configparser.RawConfigParser() 
            configFilePath = r'database.cfg'
            configParser.read(configFilePath)
            self.host = configParser.get('database_config', 'host')
            self.user = configParser.get('database_config', 'user')
            self.password = configParser.get('database_config', 'password')
            return True
        except:
            print('Get credentials failed - check database.cfg file')
            return False    

    def testConnection (self):
        self.getDatabaseCredentials()
        try: 
            SQLC.connect(
            host=self.host,
            user=self.user,
            passwd=self.password
            )    
            return True
        except:
            print("MySql connection error. Check credentials on database.cfg file")
            return False

    def createDatabase (self, commandsLists):
        try:
            if (self.testConnection()):
                database_var = SQLC.connect(
                host=self.host,
                user=self.user,
                passwd=self.password
                ) 
                cursor = database_var.cursor()
                myvar = [cursor.execute(i) for i in commandsLists]
                return myvar
        except Exception as inst:
            print (inst.args)
            print('Error while running database command - Chech it manually')

            
    def getAllDatabases (self):
        database_var = SQLC.connect(
            host=self.host,
            user=self.user,
            passwd=self.password
            ) 
        mycursor = database_var.cursor()
        mycursor.execute('SHOW DATABASES')
        for i in mycursor:
            print(i)