import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Model/Talk.dart';
import '../TalkPage/TalkPage.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  final List<Talk> talkList;

  const SchedulePage(this.talkList);

  @override
  SchedulePageState createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage>    {

  int firstBlock = 0;
  int finalBlock = 0;
  int numBlocks = 0;
  double blockSize = 0.04;
  ScrollController _controller1;
  ScrollController _controller2;

  List<DateTime> daysList = [new DateTime(2019, 12, 8, 8, 0), new DateTime(2019, 12, 9, 8, 0),new DateTime(2019, 12, 10, 8, 0),new DateTime(2019, 12, 11, 8, 0),new DateTime(2019, 12, 12, 8, 0),new DateTime(2019, 12, 13, 8, 0)];
  List<ScrollController> controllers = new List<ScrollController>();

  List<String> timeInterval = new List<String>();

  List<String> createIntervals(int firstHour, int firstMinutes, int lastHour, int lastMinutes) {
    String firstTime = firstHour.toString().padLeft(2,'0')  + ":" + firstMinutes.toString().padLeft(2,'0') ;
    String lastTime = lastHour.toString().padLeft(2,'0')  + ":" + lastMinutes.toString().padLeft(2,'0') ;
    int differenceHours = lastHour-firstHour;
    int differenceBlocks = differenceHours * 2;
    List<String> finalList = new List();
    int currentHour = firstHour;
    int currentMinutes = firstMinutes;
    finalList.add(firstTime);

    if(firstMinutes != 0)
      differenceBlocks -= 1;

    if(lastMinutes != 0)
      differenceBlocks += 1;

    for(int i = 1; i < differenceBlocks; i ++) {
      currentMinutes += 30;
      if(currentMinutes == 60){
        currentHour ++;
        currentMinutes = 0;
      }

      finalList.add(currentHour.toString().padLeft(2,'0') + ":" + currentMinutes.toString().padRight(2,'0'));
    }
    finalList.add(lastTime);


    return finalList;
  }

  @override
  void initState() {

    super.initState();
    createControllers();
    _controller1 = ScrollController();
    _controller1.addListener(listener1);
    _controller2 = ScrollController();
    _controller2.addListener(listener2);
  }

  void listener1() {
    for(int i = 0; i < controllers.length; i++){
      controllers[i].jumpTo(_controller1.offset);
    }
  }

  void listener2() {
    _controller1.jumpTo(_controller2.offset);
  }

  void createControllers() {
    for(int i = 0; i < daysList.length; i++){
      controllers.add(new ScrollController());
      controllers[i].addListener(listener1);
    }
  }

// Usado para facilitar a colocaçao dos blocos na tabela
  void convertToBlocks(DateTime initTime, DateTime finalTime){
    firstBlock = ((initTime.hour-8)*2 + (initTime.minute)/30).round();
    finalBlock = ((finalTime.hour-8)*2 + (finalTime.minute)/30).round();
    numBlocks = finalBlock - firstBlock;
  }

  Widget individualTalkBlock(int i, int j, Color backColor, Color blockColor){
    int finalBlockBefore = finalBlock;
    convertToBlocks(widget.talkList[j].dateInitial, widget.talkList[j].dateFinal);
    return Container(
        child: Column(
          children: <Widget>[
            Container(
              color: backColor.withOpacity(0),
              height: MediaQuery.of(context).size.height * blockSize * (firstBlock-finalBlockBefore),
              width: MediaQuery.of(context).size.width,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)  => TalkPage(talk: widget.talkList[j])));
              },
              child: Container(
                color: widget.talkList[j].getColor().withOpacity(0.5),
                height: MediaQuery.of(context).size.height * blockSize * numBlocks,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      widget.talkList[j].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 12
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: numBlocks,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }

  Widget individualTimeBlock(int i){
    return Container(
      padding: EdgeInsets.only(left: 5.0),
      alignment: Alignment.topCenter,
      child: Text(
        timeInterval[i],
        style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 10
        ),
      ),
      color: Colors.white,
      height: MediaQuery.of(context).size.height * blockSize,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget dayHeaderContainer(int i, Color color) {
    return Container(
      child: Row (
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                DateFormat('EE').format(daysList[i]),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF444444),
                    fontSize: 20
                ),
              ),
              Text(
                DateFormat('dMMM').format(daysList[i]),
                style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 13
                ),
              ),
            ],
          ),
        ],
      ),
      color: color,
      height: MediaQuery.of(context).size.height * 2*blockSize,
    );
  }

  Widget blockContainer(int i, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
      color: color,
      child: ListView(
        scrollDirection: Axis.vertical,
        controller: controllers[i],
        children: <Widget>[
          for(int j = 0; j < widget.talkList.length; j++)
            if(daysList[i].day == widget.talkList[j].dateInitial.day)
              individualTalkBlock(i, j, color, Color.fromARGB(255,247,220,222)),
          Container(
            color: Colors.black.withOpacity(0),
            height:MediaQuery.of(context).size.height * blockSize * (21-finalBlock),
          ),
        ],
      ),
    );
  }

  Widget timeContainer() {
    return Container(
      child: ListView(
        children: <Widget> [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 2*blockSize,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            color: Colors.white,
            child: ListView(
              controller: _controller1,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                for(int i = 0; i < timeInterval.length; i++)
                  individualTimeBlock(i),
              ],
            ),
          ),
        ],
      ),
      alignment: Alignment.topLeft,
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.height,
    );
  }

  Widget daysContainer() {
    return Container(
      width: MediaQuery.of(context).size.width * (1- 0.15),
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              for(int i = 0 ; i < daysList.length ; i ++)
                dayContainer(i),
            ],
          ),
          Container(
            child: ListView(
              controller: _controller2,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  color: Colors.blue.withOpacity(0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * blockSize * 21,
                ),
              ],
            ),
            margin: EdgeInsets.fromLTRB(0, 55, 0, 0),
            color: Colors.black.withOpacity(0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ],
      ),
    );
  }

  Widget dayContainer(int i){
    Color color1;
    Color color2;

    if((i%2) != 0){
      color1= Color.fromARGB(255,240,240,240);
      color2= Color.fromARGB(255,250,250,250);
    }
    else{
      color2= Color.fromARGB(255,240,240,240);
      color1= Color.fromARGB(255,250,250,250);
    }
    finalBlock=0;

    return Container(
      child: ListView(
        children: <Widget>[
          dayHeaderContainer(i, color1),
          blockContainer(i, color2),
        ],
      ),
      alignment: Alignment.topLeft,
      color: color2,
      width: (MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.15)) * 0.3333,
    );
  }

  @override
  Widget build(BuildContext context) {
    timeInterval = createIntervals(8, 0, 18, 0);
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            timeContainer(),
            daysContainer(),
          ],
        )
    );
  }
}