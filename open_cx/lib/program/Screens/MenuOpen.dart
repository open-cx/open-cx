import 'package:flutter/material.dart';

import '../../navigation/main.dart';
import '../Model/Talk.dart';
import '../Model/ThemeTalk.dart';
import '../Model/User.dart';

import 'Help/HelpPage.dart';
import 'Navigation/VenuePage.dart';
import 'People/PeoplePage.dart';
import 'Program/ProgramPage.dart';

int talkId = 0;


final List<ThemeTalk> allThemes = [
  new ThemeTalk("Auto/Tech", Color(0xFF1E90FF)),
  new ThemeTalk("Sports", Color(0xFFFF0000)),
  new ThemeTalk("Deep Tech", Color(0xFF00CA00)),
  new ThemeTalk("Pitch!", Color(0xFFFFA000)),
];

final List<ThemeTalk> userThemes = [];

final List<String> speakers = [
  "Alexander Zosel",
  "Michael Kratsios",
  "Pedro Miranda",
  "Laurie Segall",
  "Marcelo Rebelo de Sousa"
];

final List<ThemeTalk> interests = [allThemes[1], allThemes[2], allThemes[3]];



final user = new User("Tiago Miller", "tigasmiller@gmail.com", userThemes, "https://yt3.ggpht.com/a/AGF-l791z2rgw2RhBFQ2vnnI3wuxwMdZSNXI3U1LgQ=s176-c-k-c0x00ffffff-no-rj-mo");

final List<Talk> talkList = [
  new Talk(talkId++,new DateTime(2019, 12, 8, 8, 0), new DateTime(2019, 12, 8, 9, 30), "Drones and food delivery: A marriage made in Heaven", "There are so many food delivery unicorns, but could getting your food delivery be bad for the planet?", "Room 101", false, false, [speakers[0], speakers[3]], [allThemes[0]]),
  new Talk(talkId++,new DateTime(2019, 12, 8, 12, 0), new DateTime(2019, 12, 8, 13, 0),
      "Breakout startups",
      "Are these the companies everyone will be talking about in 2020? Dozens of the world’s leading investors think so. Each morning and lunchtime on Centre Stage you’ll get an introduction to some of the world’s most exciting early and growth stage startups. Each of the startups have been hand-selected by some of the world’s most successful investors. You’re in for a treat.",
      "Room 102", true, true, [speakers[1]], [allThemes[1], allThemes[2], allThemes[3]]),
  new Talk(talkId++,new DateTime(2019, 12, 8, 14, 0), new DateTime(2019, 12, 8, 15, 0),
      "Building the next great ad empire",
      "One of the most prominent names in the advertising industry outlines his big vision for the industry.",
      "Room 103", false,false, [speakers[3], speakers[3]], allThemes),
  new Talk(talkId++,new DateTime(2019, 12, 8, 16, 0), new DateTime(2019, 12, 8, 17, 0),
      "Welcome to the future of mobile robots",
      "A pioneering company at the cutting edge of robotics showcases its vision for the future of robotic technology that interacts with the world.",
      "Room 104", false,false, [speakers[2]], [allThemes[2]]),
  new Talk(talkId++,new DateTime(2019, 12, 10, 9, 0), new DateTime(2019, 12, 10, 10, 0),
      "Predicting the future of brand design",
      "Despite cultural, political and technological change, one thing remains constant: Companies will keep trying to sell you stuff, and they’ll keep coming up with new ways to do it. Let's hear what the experts think of where the industry is going.",
      "Room 105", false,false,[speakers[3]], [allThemes[3]]),
  new Talk(talkId++,new DateTime(2019, 12, 10, 16, 0), new DateTime(2019, 12, 10, 17, 30),
      "Learn to win",
      "DJI presents a ground-breaking educational robot that helps to understand science, programming and more through captivating gameplay modes and intelligent features.",
      "Room 106", true,true, [speakers[0]], [allThemes[3]]),
];


class MenuPage extends StatefulWidget {
  MenuPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MenuPageState createState() => _MenuPageState();
}


class _MenuPageState extends State<MenuPage> {
  int _selectedPageIndex = 0;

  final List<Widget> _children = [
    ProgramPage(talkList, user, allThemes),
    GuideasyApp(),
    PeoplePage(talkList, user, allThemes),
    HelpPage(talkList, user, allThemes),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_children[_selectedPageIndex],
      resizeToAvoidBottomInset : false,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text(
              'Program',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            title: Text(
              'Venue',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text(
              'People',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            title: Text(
              'Help',
            ),
          ),
        ],
        currentIndex: _selectedPageIndex,
        unselectedItemColor: Color(0xFF28316C),
        selectedItemColor: Color(0xFF28316C),
        selectedIconTheme: IconThemeData(size: 38, color: Color(0xFF28316C)),
        unselectedIconTheme: IconThemeData(size: 25, color: Color(0x9F28316C)),
        onTap: (index) => setState( () {_selectedPageIndex = index; } )
      ),
    );
  }
}