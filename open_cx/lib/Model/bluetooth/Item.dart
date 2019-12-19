import 'dart:core';

class Item {
  Item({this.key,
        this.title,
        this.type,
        this.url,
        this.peopleString,
        this.authors,
        this.affiliationString,
        this.description});

  String key;
  String title;
  String type;
  String url;
  String peopleString;
  List<String> authors;
  String affiliationString;
  String description;


  // argumentos sao um map Item e uma lista de mapas ItemAuthor
  Item.fromMap(Map<String, dynamic> itemMap, List<Map<String, dynamic>> itemAuthorMap) {
    this.key = itemMap['itemKey'];
    this.title = itemMap['title'];
    this.type = itemMap['type'];
    this.url = itemMap['url'];
    this.peopleString = itemMap['peopleString'];
    this.affiliationString = itemMap['affiliations'];
    this.description = itemMap['description'];
    this.authors = [];
    for(int i = 0; i < itemAuthorMap.length; i++) {
      this.authors.add(itemAuthorMap.elementAt(i)['personKey']);
    }
  }

  // retorna uma lista de maps cujo primeiro elemento e o item em si e os seguintes sao entradas de ItemAuthor
  List<Map<String, dynamic>> toMap() {
    var itemMap = <String, dynamic>{
      'itemKey': this.key,
      'title': this.title,
      'type': this.type,
      'url': this.url,
      'peopleString': this.peopleString,
      'affiliations': this.affiliationString,
      'description': this.description
    };
    List<Map<String, dynamic>> mapList = [];
    mapList.add(itemMap);
    for(int i = 0; i < this.authors.length; i++) {
      var itemAuthorMap = <String, dynamic>{
        'itemKey': this.key,
        'personKey': this.authors.elementAt(i)
      };
      mapList.add(itemAuthorMap);
    }
    return mapList;
  }

}