class Session extends Comparable<dynamic> {
  String key;
  String title;
  String chairsString; // name of the chair
  List<String> chairs; // chair key, so we can get the info about the chair in the json file
  List<String> items; // item keys, so we can get info about the these items in the json file
  String type;
  String day;
  DateTime startTime;
  String timeString;
  String location;
  String description;
  int isCustom;

  Session({this.key,
           this.title,
           this.chairsString,
           this.chairs,
           this.items,
           this.type,
           this.day,
           this.startTime,
           this.timeString,
           this.location,
           this.description,
           this.isCustom
           });

  @override
  bool operator==(other) {
    return this.key == other.key;
  }

  @override
  int get hashCode => this.key.hashCode;

  @override
  int compareTo(other) {
    if (this.key == other.key) 
      return 0;
    
    if (this.startTime.compareTo(other.startTime) == 0)
      return this.title.compareTo(other.title);
  
    return this.startTime.compareTo(other.startTime);
  }

  // passar um mapa Session, uma lista de mapas SessionItem e  uma lista de mapas SessionChair
  Session.fromMap(Map<String, dynamic> mainMap, List<Map<String, dynamic>> sessionItemMap, List<Map<String, dynamic>> sessionChairMap) {
    this.key = mainMap['sessionKey'];
    this.title = mainMap['title'];
    this.chairsString = mainMap['chairsString'];
    this.type = mainMap['type'];
    this.day = mainMap['day'];
    this.startTime = DateTime.fromMillisecondsSinceEpoch(mainMap['startTime']);
    this.timeString = mainMap['timeString'];
    this.location = mainMap['location'];
    this.description = mainMap['description'];
    this.isCustom = mainMap['isCustom'];
    this.chairs = [];
    this.items = [];
    for(int j = 0; j < sessionItemMap.length; j++) {
      this.items.add(sessionItemMap.elementAt(j)['itemKey']);
    }
    for(int i = 0; i < sessionChairMap.length; i++) {
      this.chairs.add(sessionChairMap.elementAt(i)['personKey']);
    }
  }

  // apenas retorna o map referente a Session em si
  Map<String, dynamic> toMapSession() {
    var sessionMap = <String, dynamic>{
      'sessionKey': this.key,
      'title': this.title,
      'chairsString': this.chairsString,
      'type': this.type,
      'day': this.day,
      'startTime': this.startTime.millisecondsSinceEpoch,
      'timeString': this.timeString,
      'location': this.location,
      'description': this.description,
      'isCustom': this.isCustom

    };
    return sessionMap;
  }

  // retorna maps com os chairs
  List<Map<String, dynamic>> toMapChairs() {
    List<Map<String, dynamic>> mapList = [];
    if(this.chairs == null)
      return mapList;
    for (int i = 0; i < this.chairs.length; i++) {
      var sessionChairMap = <String, dynamic>{
        'sessionKey': this.key,
        'personKey': this.chairs.elementAt(i)
      };
      mapList.add(sessionChairMap);
    }
    return mapList;
  }


  // retorna maps com os items
  List<Map<String, dynamic>> toMapItems() {
    List<Map<String, dynamic>> mapList = [];
    if(this.items == null)
      return mapList;
    for (int i = 0; i < this.items.length; i++) {
      var sessionItemMap = <String, dynamic>{
        'sessionKey': this.key,
        'itemKey': this.items.elementAt(i)
      };
      mapList.add(sessionItemMap);
    }
    return mapList;
  }
}


