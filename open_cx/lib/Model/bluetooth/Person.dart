class Person {
  String key;
  String name;
  String affiliation;
  String bio;
  String url;
  String imageURL;
  
  Person({this.key, this.name, this.affiliation, this.bio, this.url, this.imageURL});

  Person.fromMap(Map<String, dynamic> map) {
    this.key = map['personKey'];
    this.name = map['name'];
    this.affiliation = map['affiliation'];
    this.bio = map['bio'];
    this.url = map['url'];
    this.imageURL = map['imageURL'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'personKey': this.key,
      'name': this.name,
      'affiliation': this.affiliation,
      'bio': this.bio,
      'url': this.url,
      'imageURL': this.imageURL
    };
    return map;
  }
}