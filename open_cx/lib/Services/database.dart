import '../program/Model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  introduceUserData(String uid, String email, String name) async {
    CollectionReference usersCollenction = Firestore.instance.collection('Users');
    await usersCollenction.document(uid).setData({
      'email' : email,
      'name' : name,
      'uid' : uid,
      'name_search' : name.toLowerCase(),
      'description' : '',
      'status' : 'Attendee',
      'interests' : [],
    });
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid: snapshot.documentID,
      name: snapshot.data['name']
    );
  }

  Future<User> getUser(String uid) async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('Users').document(uid).get();
    return _userDataFromSnapshot(snapshot);
  }

  Future<bool> userExists(String uid) async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('Users').document(uid).get();
    return snapshot.exists;
  }
}