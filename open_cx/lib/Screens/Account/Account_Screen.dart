import 'package:flutter/material.dart';
import '../../Components/displayAllThemes.dart';
import '../../Model/Talk.dart';
import '../../Model/ThemeTalk.dart';
import '../../Model/User.dart';
import '../../Notification/notification_page.dart';
import '../Login/login.dart';
import '../MenuOpen.dart';
import 'Preferences_Screen.dart';

class AccountPage extends StatefulWidget {
  final List<Talk> talkList;
  final List<ThemeTalk> themesList;
  final User user;

  const AccountPage({Key key, this.talkList, this.themesList, this.user}) : super(key: key);

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {

  @override
  void initState() {
    super.initState();
    // print(widget.talkList);
    // print(widget.themesList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Account",
          style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xFF28316C),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              color: Colors.grey[100],
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.grey[100],
              // child: Icon(
              //   Icons.account_circle,
              //   size: 100.0,
              //   color: Colors.grey[600],
              // ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.user.photo),
                radius: 60,
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.grey[100],
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.grey[100],
              child: Text(
                widget.user.name,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.grey[100],
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.grey[100],
              child: Text(
                widget.user.email,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.grey[100],
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.grey[200],
              height: 2,
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Preferences',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new PreferencesScreen(themesList: widget.themesList, user: user);
                }));
              },
                child: Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ),
            ]),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: displayAllThemes(widget.user.preferredThemes),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Account Settings',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return NotificationPage(talkList: widget.talkList);
                }));
              },
              child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.notifications,
                      size: 20.0,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'Manage Notifications',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new LoginPage();
                }));
              },
              child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.exit_to_app,
                      size: 20.0,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}