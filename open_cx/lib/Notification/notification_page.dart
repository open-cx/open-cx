import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../Model/Talk.dart';
import 'notification_data.dart';
import 'notification_plugin.dart';
class NotificationPage extends StatefulWidget {

  final List<Talk> talkList;

  const NotificationPage({Key key, this.talkList}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();

}

class _NotificationPageState extends State<NotificationPage> {

  final NotificationPlugin _notificationPlugin = NotificationPlugin();
  Future<List<PendingNotificationRequest>> notificationFuture;

  NotificationPlugin getNotificationPlugin(){
    return this._notificationPlugin;
  }

  @override
  void initState(){
    super.initState();
    notificationFuture = _notificationPlugin.getScheduleNotifications();

    updateNotifications();
    refreshNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Manage Notifications',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xFF28316C),
      ),
      body: Center(
      child: Column(
        children: <Widget>[
          FutureBuilder<List<PendingNotificationRequest>>(
            future: notificationFuture,
            initialData: [],
            builder: (context, snapshot) {
              final notifications = snapshot.data;
              return Expanded(
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return NotificationTile(
                      notification: notification,
                      deleteNotification: dismissNotification,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      ),
    );
  }

  //erase notification for update
  Future<void> deleteNotification(int id)async{
    await _notificationPlugin.cancelNotifications(id);
    refreshNotification();
  }

  //erase it and turn the flag off
  Future<void> dismissNotification(int id)async{
    await _notificationPlugin.cancelNotifications(id);
    widget.talkList.forEach((element)=>{
      if(element.id == id){
        element.notify=false
      }
    });
    refreshNotification();
  }

  //reactivate notification
  Future<void> activateNotification(int id)async{
    Talk talk;
    widget.talkList.forEach((element)=>{
      if(element.id == id){
        element.notify=true,
        talk = element
      }
    });
    createTalkNotification(talk);
    refreshNotification();
  }
  //refresh notification list
  void refreshNotification(){
    setState(() {
      notificationFuture = _notificationPlugin.getScheduleNotifications();
    });
  }

  //create a notification
  Future<void> createTalkNotification(Talk talk) async{

    final title = talk.name;
    final description = weakToString(talk.dateInitial.weekday.toString()) + " " +
        talk.dateInitial.day.toString() + " " + monthToString(talk.dateInitial.month.toString()) + " - " +
        hourToString(talk.dateInitial.hour.toString())+ "h" + minToString(talk.dateFinal.minute.toString());
    final oldTime= talk.dateInitial;
    final newTime= talk.dateInitial.subtract(new Duration(minutes: 15));
    final time = Time(newTime.hour,newTime.minute);
    final day= Day(talk.dateInitial.day);

    final notificationData = new NotificationData(title, description,time,day); //todo change to weekly

    //reset time bc idk if the element is passed by reference
    talk.dateInitial = oldTime;

    if(notificationData != null) {
      final notificationList = await _notificationPlugin.getScheduleNotifications();
      int id = talk.id;
      bool exists = _notificationPlugin.checkIfIdExists(notificationList, id);
      if (exists) {
        return "cant create noptification";
      }
    }
    await _notificationPlugin.showWeeklyAtDayTime(
        notificationData.time,
        notificationData.day,
        talk.id,
        notificationData.title,
        notificationData.description
    );
    refreshNotification();
  }

  void updateNotifications() async{
    //delete old notifications
    final notificationList = await _notificationPlugin.getScheduleNotifications();
    notificationList.forEach((notification) =>({
      deleteNotification(notification.id)
    }));
    //create new notifications
    widget.talkList.forEach((element) =>({
        if(element.selected && element.notify){
          createTalkNotification(element)
        }
      }
    ));
  }

  //generate all talk notifications
  void generateAllNotifications() {
    widget.talkList.forEach((element) =>({
      if(element.selected && element.notify){
        createTalkNotification(element)
      }
    }
    ));
  }
}

class NotificationTile extends StatelessWidget{

  const NotificationTile({
    Key key,
    @required this.notification,
    @required this.deleteNotification
}): super(key: key);

  final PendingNotificationRequest notification;
  final Function(int id) deleteNotification;

  @override
  Widget build(BuildContext context){
    return Card(
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: ListTile(
        title: Text(notification.title),
        subtitle: Text(notification.body),
        trailing: IconButton(
          onPressed: () => deleteNotification(notification.id),
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}

//utils
String hourToString(String hourNum){
  if(hourNum.length == 1)
    return '0'+ hourNum;
  return hourNum;

}

String minToString(String minNum){
  if(minNum.length == 1 )
    return '0'+minNum;
  return minNum;
}

String weakToString(String weakNum){
  switch(weakNum){
    case "1":
      return "Sun";
      break;
    case "2":
      return "Mon";
      break;
    case "3":
      return "Tue";
      break;
    case "4":
      return "Wed";
      break;
    case "5":
      return "Thu";
      break;
    case "6":
      return "Fri";
      break;
    case "7":
      return "Sat";
      break;
  }
  return null;
}

String monthToString(String monthNum){
  switch(monthNum){
    case "1":
      return "Jan";
      break;
    case "2":
      return "Fev";
      break;
    case "3":
      return "Mar";
      break;
    case "4":
      return "Apr";
      break;
    case "5":
      return "May";
      break;
    case "6":
      return "Jun";
      break;
    case "7":
      return "Jul";
      break;
    case "8":
      return "Aug";
      break;
    case "9":
      return "Sep";
      break;
    case "10":
      return "Oct";
      break;
    case "11":
      return "Nov";
      break;
    case "12":
      return "Dec";
      break;
  }
  return null;
}
