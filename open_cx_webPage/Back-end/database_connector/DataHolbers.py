

class Room ():
    '''
        Hold's data from Room 
    '''
    total_number_seats = None
    Seats_occupied = None
    Map_Pose = None
    ID_CODE = None

    def __init__(self, total_number_seats, Seats_occupied,Map_Pose, ID_CODE):
        self.ID_CODE = ID_CODE
        self.total_number_seats = total_number_seats
        self.Map_Pose = Map_Pose
        self.Seats_occupied = Seats_occupied



class Presentation ():
    '''
        Hold's data from presentation 
        speakers must be a vector with names separated by ";"
    '''
    ID_speaker1 = None
    ID_speaker2 = None
    ID_speaker3 = None
    ID_room = None
    title = None
    summary = None
    start_Time = None
    End_Time = None
    Hashtags = None
    def __init (self, speakers,id_room, title, summary,start_time, end_time, Hashtags ):
        num_speakers = len(speakers.split(';'))
        if (num_speakers == 1):
            self.ID_speaker1 = speakers
        elif (num_speakers == 2):
            self.ID_speaker1 = speakers[0]
            self.ID_speaker2 = speakers[1]
        elif (num_speakers >=3 ):
            self.ID_speaker1 = speakers[0]
            self.ID_speaker2 = speakers[1]
            self.ID_speaker2 = speakers[2]
        self.ID_room = id_room
        self.title = title
        self.summary = summary
        self.start_Time = start_time
        self.end_time = end_time
        self.Hashtags = Hashtags




class Speaker ():
    '''
        Hold's data from Speaker 
    '''

    first_name = None
    surname = None
    research_area = None
    photo_location = None
    job_details = None
    def __init__(self, fn, sn, ra, phl, jd):
        self.first_name = fn
        self.surname = sn
        self.research_area = ra
        self.photo_location = phl
        self.job_details = jd
    
