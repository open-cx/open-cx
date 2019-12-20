import 'package:flutter/material.dart';

import '../../Model/ThemeTalk.dart';
import '../../Model/User.dart';

class PreferencesScreen extends StatefulWidget {
  final List<ThemeTalk> themesList;
  final User user;

  const PreferencesScreen({Key key, this.themesList, this.user}) : super(key: key);

  @override
  MyPreferencesScreen createState() => MyPreferencesScreen();
}
class MyPreferencesScreen extends State<PreferencesScreen>   {

  bool containsTheme(ThemeTalk theme) {
    for(int i = 0 ; i < widget.user.preferredThemes.length; i++)
      if(widget.user.preferredThemes[i].name == theme.name)
        return true;
    return false;
  }

  Widget displayThemeTalk(ThemeTalk theme) {
    Color themeColor;
    if(containsTheme(theme)){
      themeColor = theme.color;
    }
    else{
      themeColor = Color(0x50000000);
    }
    
    return GestureDetector(
      onTap: () {
        if(containsTheme(theme))
          setState(() {
            widget.user.preferredThemes.remove(theme);});
        else
          setState(() {
            widget.user.preferredThemes.add(theme);});
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: themeColor),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Color(0x20000000), blurRadius: 5, offset: Offset(0, 3))
            ]
          ),
        child: Text(
          theme.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: themeColor,
          )
        ),
      ),
    );
  }

  Widget displayThemes(List<ThemeTalk> themes){
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(17, 0, 17, 0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          for(int i = 0; i < themes.length; i++)
            displayThemeTalk(themes[i])
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Preferences",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xFF28316C),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(33, 36, 33, 32),
              child: Text(
                "Tell us what you're interested in!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          displayThemes(widget.themesList),
          ],
        ),
      ),
    );
  }
}