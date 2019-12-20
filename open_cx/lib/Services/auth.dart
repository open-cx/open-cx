import 'package:open_cx/Model/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:open_cx/Screens/MenuOpen.dart';
import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password).catchError((error) => print(error.code));

    if(result != null) {
      FirebaseUser firebaseUser = result.user;
      User user =  await DatabaseService().getUser(firebaseUser.uid);
      MenuPage.firebaseUser = user;
      return user;
    }

    return null;
  }

  // register with email and password
  Future<User> registerWithEmailAndPassword(String email, String password, String name) async {
    print("Before register");
    print('emai: ' + email);
    print('password: ' + password);
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password).catchError((error) => print(error.toString()));
    print("Doing register");
    if(result != null) {
      print("Good register");

      FirebaseUser firebaseUser = result.user;
      await DatabaseService().introduceUserData(firebaseUser.uid, email, name);
      User user =  await DatabaseService().getUser(firebaseUser.uid);
      MenuPage.firebaseUser = user;
      return user;
    }

    return null;
  }

  Future<User> currentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    User u = _userFromFirebaseUser(user);
    MenuPage.firebaseUser = u;
    return u;
  }

  // sign out
  void signOut() async {
    await _auth.signOut().catchError((error) => print(error.code));
  }
}