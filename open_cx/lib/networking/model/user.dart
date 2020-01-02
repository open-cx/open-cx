class User {
  final int id;
  final String name;
  final String nationality;
  final String occupation;
  final String company;
  final List<String> contacts;
  final List<String> interests;

  User(
      {this.id,
      this.name,
      this.nationality,
      this.occupation,
      this.company,
      this.contacts,
      this.interests});

  Map<String, dynamic> getContacts() {
    return {'contacts': listToCSV(contacts)};
  }
  
  Map<String, dynamic> getInterests() {
    return {'interests': listToCSV(interests)};
  }

  Map<String, dynamic> getProfile() {
    return {
      'name': name,
      'nationality': nationality,
      'occupation': occupation,
      'company': company,
    };
  }

  // Convert a User into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap({bool noID = false}) {
    if (noID) {
      return {
        'name': name,
        'nationality': nationality,
        'occupation': occupation,
        'company': company,
        'contacts': listToCSV(contacts),
        'interests': listToCSV(interests)
      };
    } else {
      return {
        'id': id,
        'name': name,
        'nationality': nationality,
        'occupation': occupation,
        'company': company,
        'contacts': listToCSV(contacts),
        'interests': listToCSV(interests)
      };
    }
  }
}

String listToCSV(List<String> list) {
  String csv = '';
  if (list != null && list.isNotEmpty) {
    csv = list.elementAt(0);

    for (int i = 1; i < list.length; i++) {
      csv += ',' + list.elementAt(i);
    }
  }

  return csv;
}
