import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';

class ConnectionException implements Exception {
  String error;
  ConnectionException(this.error);
}

class UserRegInfo {
  final String fullname;
  final String email;
  final String password;

  UserRegInfo({this.fullname, this.email, this.password});

  factory UserRegInfo.fromMap(Map<String, String> map) {
    return UserRegInfo(
      fullname: map['fullname'],
      email: map['email'],
      password: map['password'],
    );
  }

  Map toMap() {
    var map = new Map<String,String>();
    map['fullname'] = fullname;
    map['email'] = email;
    map['password'] = password;

    return map;
  }
}

class UserLoginInfo {
  final String email;
  final String password;

  UserLoginInfo({this.email, this.password});

  factory UserLoginInfo.fromMap(Map<String, String> map) {
    return UserLoginInfo(
      email: map['email'],
      password: map['password'],
    );
  }

  Map toMap() {
    var map = new Map<String,String>();
    map['email'] = email;
    map['password'] = password;

    return map;
  }
}

class UserAuth {
  final String email;
  final String authToken;

  UserAuth({this.email,this.authToken});
}

class User {
  final String userID;
  final String fullname;
  final String email;
  final String password;
  final List<dynamic> tags;
  final List<dynamic> matches;
  final List<dynamic> conferences;

  User({this.tags, this.matches, this.conferences, this.userID, this.fullname, this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['_id'] as String,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      tags: ["Networking","Web design","Security","Artifitial Inteligence","Algorthms"],
      matches: json['matches'] as List<dynamic>,
      conferences: json['conferences'] as List<dynamic>
    );
  }
}

class Match {
  final String name;
  final List<dynamic> tags;

  Match(this.name, this.tags);
}

class MatchList {
  final List<Match> matches;

  MatchList({this.matches});

  factory MatchList.fromJson(Map<String, dynamic> json) {
    return MatchList(
      matches: json['matches'] as List<dynamic>
    );
  }
}

class ApiConnection {
  static final String registerUrl = 'https://tranquil-springs-58074.herokuapp.com/users/register';
  static final String loginUrl = 'https://tranquil-springs-58074.herokuapp.com/users/login';
  static final String getInfoUrl = 'https://tranquil-springs-58074.herokuapp.com/users';
  static final String matchUrl = 'https://tranquil-springs-58074.herokuapp.com/';

  static void registerUser({Map userRegisterInfo}) async {
    // Send the request

    var headers = {
      "Content-Type" : "application/json"
    };

    http.Response res = await http.post(registerUrl ,headers: headers, body: json.encode( userRegisterInfo));

    //Verify statusCode
    final int statusCode = res.statusCode;

    if (statusCode < 200 || statusCode >= 400 || json == null) {
      throw new ConnectionException("Error resistering user: " + res.body);
    }
  }

  static Future<User> getUserInformation(UserAuth auth) async {
    String email = auth.email;
    String token = auth.authToken;

    String userGetUrl = getInfoUrl + '/' + email;

    var headers = {
      "Auth-Token" : token
    };

    //Send the request
    http.Response res = await http.get(userGetUrl, headers: headers);

    //Verify statusCode
    final int statusCode = res.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new ConnectionException(res.body);
    }

    User u = User.fromJson(json.decode(res.body));

    return u;
  }

  static Future<UserAuth> loginUser({Map userLoginInfo}) async {
    //Send the request
    http.Response res = await http.post(loginUrl, headers: {"Content-Type" : "application/json"},  body: json.encode(userLoginInfo));

    //Verify statusCode
    final int statusCode = res.statusCode;
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      throw new ConnectionException(res.body);
    }

    String authToken = res.headers['auth-token'];

    return new UserAuth(email: userLoginInfo['email'], authToken: authToken);
  }

  static Future<MatchList> getUserMatches(String userID) async {
    String url = ApiConnection.matchUrl + userID + '/matches';

    http.Response res = await http.post(matchUrl);

    /*
    //Verify statusCode
    final int statusCode = res.statusCode;
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      throw new ConnectionException(res.body);
    }
    Commented to not throw exception when server fails
     */

    //TODO remove mock
    Match match1 = new Match("Beatriz", ["Networks","Security"]);
    Match match2 = new Match("Joana", ["Artifitial inteligence", "Algorithms"]);
    Match match3 = new Match("Francisca", ["Web design", "Security"]);

    List<Match> mock = [match1,match2,match3];

    return new MatchList(matches: mock);
  }
}
