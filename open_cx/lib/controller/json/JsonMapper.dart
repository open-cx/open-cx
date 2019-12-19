import 'package:open_cx/Model/bluetooth/Item.dart';
import 'package:open_cx/Model/bluetooth/Person.dart';
import 'package:open_cx/Model/bluetooth/Session.dart';

class JsonMapper {
  static List<String> stringList(Map<String, dynamic> json, String key) {
    List<dynamic> dynamicList = json[key];
    if (dynamicList == null) return null;
    
    List<String> strings = new List<String>();

    dynamicList.forEach((f) {
      strings.add(f);
    });

    return strings;
  }

  static Person person(Map<String, dynamic> json) {
    return Person(
      name:  json['Name'] as String,
      key: json['Key'] as String,
      affiliation: json['Affiliation'] as String,
      bio: json['Bio'] as String,
      url: json['URL'] as String,
      imageURL: json['URLphoto'] as String
    );
  }

  static List<Person> getPeople(Map<String, dynamic> json) {
    List<dynamic> dynamicList = json['People'];
    List<Person> people = List<Person>();

    dynamicList.forEach((f) {
      Person p = JsonMapper.person(f);
      people.add(p);
    });

    return people;
  }

  static Session session(Map<String, dynamic> json) {

    return Session(
      title: json['Title'] as String,
      key: json['Key'] as String,
      description: json['Abstract'] as String,
      type: json['Type'] as String,
      chairs: JsonMapper.stringList(json, "Chairs"),
      chairsString: json['ChairsString'] as String,
      items: JsonMapper.stringList(json, "Items"),
      location: json['Location'] as String,
      startTime: DateTime.parse(json['Day'] + ' ' + json['Time'].substring(0, 5) + ':00'),
      timeString: json['Time'] as String,
      day: json['Day'] as String,
      isCustom: 0,

    );
  }

  static List<Session> getSessions(Map<String, dynamic> json) {
    List<dynamic> dynamicList = json['Sessions'];
    List<Session> sessions = List<Session>();

    dynamicList.forEach((f) {
      Session s = JsonMapper.session(f);
      sessions.add(s);
    });

    return sessions;
  }

  static Item item(Map<String, dynamic> json) {
    return Item(
      title: json['Title'] as String,
      key: json['Key'],
      description: json['Abstract'],
      type: json['Type'],
      authors: JsonMapper.stringList(json, "Authors"),
      peopleString: json['PersonsString'] as String,
      url: json['URL'] as String,
      affiliationString: json['AffiliationsString']
    );
  }

  static List<Item> getItems(Map<String, dynamic> json) {
    List<dynamic> dynamicList = json['Items'];
    List<Item> items = List<Item>();

    dynamicList.forEach((f) {
      Item i = JsonMapper.item(f);
      items.add(i);
    });

    return items;
  }
}