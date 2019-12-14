class MySqlFileReader ():
    '''
        Read a sql object and return a list containing the commands

        commands must be separated by ";"

    '''
    name = ''

    def __init__(self, name):
        self.name = name

    def getCommands(self):
        myFile = open(self.name, 'r')
        textOnfile = myFile.read()
        commandList = textOnfile.split(';')
        commandsToReturn = [(i + ';') for i in commandList]
        del commandsToReturn[-1]
        return commandsToReturn
        