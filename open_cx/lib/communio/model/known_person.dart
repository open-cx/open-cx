import 'package:open_cx/communio/model/social_block.dart';

class KnownPerson {
  final String uuid;
  final String name;
  final String photo;
  final String location;
  final String description;
  List<SocialBlock> socials;
  List<dynamic> interests;
  List<dynamic> programmingLanguages;
  List<dynamic> skills;

  KnownPerson(
      {this.uuid,
      this.name,
      this.photo,
      this.location,
      this.socials,
      this.interests,
      this.description,
      this.programmingLanguages,
      this.skills});

  Map<String, dynamic> get map {
    return {
      "uuid": uuid,
      "name": name,
      "photo": photo,
      "location": location,
      "socials": socials,
      "interests": interests,
      "programming_languages": programmingLanguages,
      "skills": skills
    };
  }

  factory KnownPerson.fromJson(Map<String, dynamic> json) {
    return new KnownPerson(
        uuid: json['_id'],
        name: json['fullname'],
        photo: json['photo'],
        location: json['location'],
        socials: KnownPerson._createSocial(json['socials']),
        interests: json['tags'],
        description: json['description'],
        programmingLanguages: json['programming_languages'],
        skills: json['skills'] 
    );
  }

  static List<SocialBlock> _createSocial(Map<String, dynamic> response) {
    final List<SocialBlock> socials = new List<SocialBlock>();
    response.forEach((k, v) => socials.add(new SocialBlock(k, v)));
    return socials;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KnownPerson &&
          runtimeType == other.runtimeType &&
          uuid == other.uuid;

  @override
  int get hashCode => (uuid.hashCode);

  @override
  String toString() {
    return '\nFriend{\n'
        'uuid: $uuid,\n'
        'name: $name,\n'
        'location: $location,\n'
        'socials: $socials,\n'
        'interests: $interests\n'
        'programming languages: $programmingLanguages\n'
        'skills: $skills\n'
        '}';
  }
}
