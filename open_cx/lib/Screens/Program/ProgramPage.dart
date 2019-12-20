import 'package:flutter/material.dart';

import '../../Components/AccountButton.dart';
import '../../Model/Talk.dart';
import '../../Model/ThemeTalk.dart';
import '../../Model/User.dart';
import 'SchedulePage/SchedulePage.dart';
import 'TalkListPage/TalkListPage.dart';
import 'formQuestions.dart';

class ProgramPage extends StatefulWidget {
  final List<Talk> talkList;
  final List<ThemeTalk> allThemes;
  final User user;

  ProgramPage(this.talkList, this.user, this.allThemes);

  @override
  State<StatefulWidget> createState() {
    return ProgramPageState(talkList: this.talkList, user: this.user);
  }
}

class ProgramPageState extends State<ProgramPage> {
  final List<Talk> talkList;
  final User user;


  bool showingSchedule = false;
  String appBarText = "All talks";
  TalkListPage talksPage;
  SchedulePage schedulePage;

  ProgramPageState({Key key, this.talkList, this.user}):
        talksPage = TalkListPage(talkList),
        schedulePage = SchedulePage(talkList);

  void changePage(TalkListPage talksPage, String appbarText) {
    this.setState(() {
      this.talksPage = talksPage;
      this.schedulePage = talksPage.getSchedulePage();
      this.appBarText = appbarText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.appBarText,
          style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xFF28316C),
        actions: <Widget>[ AccountButton(talkList, user, widget.allThemes) ],
      ),
      body: showingSchedule ? this.schedulePage : this.talksPage,
      drawer: Drawer(
          child: ListView(
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(image: DecorationImage(
                      image: AssetImage("assets/images/porto.png"),
                      fit: BoxFit.cover,
                    )),
                    child: Center(child: Text("<Programming> 2020", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white))),
                ),
                ListTile(
                  leading: Icon(Icons.list),
                  title: Text('All talks'),
                  onTap: () { Navigator.pop(context); changePage(TalkListPage(talkList), "All talks"); }
                ),
                ListTile(
                  leading: Icon(Icons.thumb_up),
                  title: Text('Recommended talks'),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return FirstQuestion();
                    }))
                ),
                ListTile(
                  leading: Icon(Icons.check_box),
                  title: Text('Favorite talks'),
                  onTap: () { Navigator.pop(context); changePage(UserTalksPage(talkList), "Favorite talks"); }
                ),
              ]
          )
      ),
      floatingActionButton: FloatingActionButton(
          mini: false,
          backgroundColor: Color(0xFF28316C),
          child: showingSchedule ? Icon(Icons.format_list_bulleted) : Icon(Icons.calendar_today),
          onPressed: () {
            setState(() {
              this.showingSchedule = !this.showingSchedule;
            });
          }
      ),
    );

  }
}