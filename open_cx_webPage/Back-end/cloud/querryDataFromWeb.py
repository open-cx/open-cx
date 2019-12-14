import requests as rq 
import configparser
from cloud.PresentationObject import *

class cloud ():
    '''
    Classe to querry data froma given Url ant return it as Json
    '''
    def get_url_to_querry(self):
        configParser = configparser.RawConfigParser()   
        configFilePath = r'url.cfg'
        configParser.read(configFilePath)
        return configParser.get('Conference_url', 'conference_data_as_json_url')

    def process_data(self, mydata):
       return mydata['Items']    
    

    def get_presentation_data(self, url):
        return rq.get(url)

    def get_list_from_json(self, myjson):
        myPresentationObjectList = [PresentationObject(i) for i in myjson]
        return myPresentationObjectList
        

        
    def get_data(self):
        url = self.get_url_to_querry()
        data_from_web = self.get_presentation_data(url)
        myJsondata = self.process_data(data_from_web.json()) 
        PresentationObjectList = self.get_list_from_json(myJsondata)
        return PresentationObjectList   

