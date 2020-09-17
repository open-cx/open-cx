import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import '../../program/Screens/MenuOpen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DetailChat extends StatefulWidget {
  final DocumentSnapshot chat;

  DetailChat(this.chat);

  @override
  DetailChatState createState() {
    return new DetailChatState(chat);
  }
}

class DetailChatState extends State<DetailChat> {
  DocumentSnapshot chat;

  DetailChatState(this.chat);

  final ScrollController listScrollController = new ScrollController();

  final TextEditingController _textEditingController =
      new TextEditingController();

  var listMessages;

  @override
  Widget build(BuildContext context) {
    String chatName = chat['name'];
    if (chat['chatName'] != null && chat['chatName'][MenuPage.firebaseUser.uid] != null && chat['chatName'][MenuPage.firebaseUser.uid] != "")
      chatName = chat['chatName'][MenuPage.firebaseUser.uid];
    return Scaffold(
        appBar: AppBar(
          title: Text(chatName),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // List of messages
                buildListMessage(),

                // Input content
                _buildTextComposer(),
              ],
            ),

            // Loading
          ],
        ));
  }

  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('Chats')
            .document(chat.documentID)
            .collection('messages')
            .orderBy('time', descending: true)
            .limit(20)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator());
          } else {
            listMessages = snapshot.data.documents;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) =>
                  buildMessage(index, snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
              reverse: true,
              controller: listScrollController,
            );
          }
        },
      ),
    );
  }

  Widget buildMessage(int index, DocumentSnapshot message) {
    bool sentByMe = message["sender"] == MenuPage.firebaseUser.uid;

    String dateString =
        message["time"].toDate().hour.toString().padLeft(2, '0') +
            ":" +
            message["time"].toDate().minute.toString().padLeft(2, '0');
    var bg = sentByMe ? Colors.greenAccent.shade100 : Colors.white;
    var align = sentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    var radius = !sentByMe
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          );

    if (sentByMe) {
      return Column(crossAxisAlignment: align, children: <Widget>[
        Container(
            margin: isLastMessageRight(index)
                ? EdgeInsets.fromLTRB(100, 3, 16, 8)
                : EdgeInsets.fromLTRB(100, 3, 16, 3),
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: .5,
                    spreadRadius: 1.0,
                    color: Colors.black.withOpacity(.12))
              ],
              color: bg,
              borderRadius: radius,
            ),
            child: Stack(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 0.0),
                child: Text(message["text"]),
              )
            ])),
      ]);
    } else {

      return Container(
          margin:
              EdgeInsets.fromLTRB(0, 0, 0, isLastMessageLeft(index) ? 5 : 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              isLastMessageLeft(index)
                  ? Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                      child: _profileImage(message["sender"]))
                  : Container(
                      width: 30,
                    ),
              Expanded(
                  child: Column(crossAxisAlignment: align, children: <Widget>[
                  isFirstMessageLeft(index)
                    ? Container(
                        child: Text(
                          message["sender_name"] == null || message["sender_name"] == "" ?
                          "Name" : message["sender_name"],
                          style: TextStyle(fontSize: 12),
                        ),
                        margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                      )
                    : Container(),
                Container(
                    margin: EdgeInsets.fromLTRB(8, 3, 90, 3),
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: .5,
                            spreadRadius: 1.0,
                            color: Colors.black.withOpacity(.12))
                      ],
                      color: bg,
                      borderRadius: radius,
                    ),
                    child: Stack(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 0.0),
                        child: Text(message["text"], style: TextStyle(fontStyle: FontStyle.normal)),
                      )
                    ]))
              ]))
            ],
          ));
    }
  }

  bool isFirstMessageLeft(int index) {
    if (listMessages != null &&
        ((index < listMessages.length - 1 &&
                listMessages[index + 1]['sender'] !=
                    listMessages[index]['sender']) ||
            index == listMessages.length - 1)) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessages != null &&
            listMessages[index - 1]['sender'] !=
                listMessages[index]['sender']) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessages != null &&
            listMessages[index - 1]['sender'] != MenuPage.firebaseUser.uid) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                height: 30,
                width: 30,
              ),
              new Flexible(
                child: new TextField(
                  controller: _textEditingController,
                  onSubmitted: _textMessageSubmitted,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
        icon: new Icon(Icons.send),
        onPressed: () => _textMessageSubmitted(_textEditingController.text));
  }

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();

    _sendMessage(text);
  }

  void _sendMessage(String messageText) {
    if (messageText.trim() != '') {
      var documentReference = Firestore.instance
          .collection('Chats')
          .document(chat.documentID)
          .collection('messages')
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      var chatReference = Firestore.instance
          .collection('Chats')
          .document(chat.documentID);

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'sender': MenuPage.firebaseUser.uid,
            'sender_name': MenuPage.firebaseUser.name,
            'time': Timestamp.now(),
            'text': messageText
          },
        );

        await transaction.update(
          chatReference,
          {
            'lastMessage': Timestamp.now(),
            'lastText': messageText
          },
        );

        print("Done writing message");
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }
}

class _profileImage extends StatefulWidget {
  String _profileUid;

  _profileImage(String uid) {
    this._profileUid = uid;
  }

  @override
  _profileImageState createState() => _profileImageState();
}

class _profileImageState extends State<_profileImage> {
  String imageFile;

  getImagePath() async {
    StorageReference photo =
        FirebaseStorage(storageBucket: 'gs://conferly-8779b.appspot.com/')
            .ref()
            .child('images/${widget._profileUid}.png');
    photo.getDownloadURL().then((data) {
      setState(() {
        imageFile = data;
      });
    }).catchError((error) {});
  }

  @override
  void initState() {
    super.initState();
    getImagePath();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 30.0,
      height: 30.0,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: (imageFile != null)
                ? new NetworkImage(imageFile)
                : (AssetImage('assets/images/profile.png')),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            color: Colors.green,
            width: 1.0,
          )),
    ));
  }
}
