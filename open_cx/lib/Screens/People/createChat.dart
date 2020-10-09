import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../program/Screens/MenuOpen.dart';
import 'package:open_cx/Services/chat.dart';

import 'detailChat.dart';

class CreateChat extends StatefulWidget {
  String profileUid;

  ProfileUid(String uid) {
    this.profileUid = uid;
  }

  @override
  CreateChatState createState() => CreateChatState();

}


class CreateChatState extends State<CreateChat> {
  TextEditingController textEditingController = new TextEditingController();
  String textQuery = "";

  bool alreadyClick = false;

  List<ChatInfo> selected = new List<ChatInfo>();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    textEditingController.addListener((){
      setState(() {
        textQuery = textEditingController.text.toLowerCase();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Chat'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.done, color: Colors.white,), onPressed: selected.length == 0 ? null : () async {
            ChatInfo myChatInfo = ChatInfo(MenuPage.firebaseUser.name, MenuPage.firebaseUser.uid);
            if (!selected.contains(myChatInfo))
              selected.add(myChatInfo);

            print("Creating " + MenuPage.firebaseUser.name);

            if (alreadyClick)
              return;

            alreadyClick = true;

            String uidChat =  await createChatWithMultipleUsers(selected);
            DocumentSnapshot chat = await Firestore.instance
                .collection('Chats')
                .document(uidChat)
                .get();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DetailChat(chat)),
            );
          })
        ],
      ),
      body: Column(
        children: <Widget>[
              Card(
              elevation: 2.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                height: 51.0,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: 3.0, left: 25.0, right: 25.0),
                      child: TextField(
                        autofocus: true,
                        controller: textEditingController,
                        style: TextStyle(
                            fontFamily: "WorkSansSemiBold",
                            fontSize: 16.0,
                            color: Colors.black),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 22.0,
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 17.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

          ),
//          TextField(
//            controller: textEditingController,
//            style: TextStyle(
//                fontFamily: "WorkSansSemiBold",
//                fontSize: 16.0,
//                color: Colors.black),
//            decoration: InputDecoration(
//              border: InputBorder.none,
//              icon: Icon(
//                FontAwesomeIcons.search,
//                color: Colors.black,
//                size: 22.0,
//              ),
//              hintText: "Search",
//              hintStyle: TextStyle(
//                  fontFamily: "WorkSansSemiBold",
//                  fontSize: 17.0),
//            ),
//          ),
          buildListUsers()
        ],
      ),
    );
  }

  Widget buildListUsers() {
    return Flexible(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('Users')
            .where('name_search', isLessThanOrEqualTo: textQuery + 'z' )
            .where('name_search', isGreaterThanOrEqualTo: textQuery)
            .limit(5)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => getProfileChat(context, snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
//              controller: listScrollController,
            );
          }
        },
      ),
    );
  }

  Widget getProfileChat(BuildContext context, DocumentSnapshot profile) {

    String imageFile;

    ChatInfo chatInfo = new ChatInfo(profile['name'], profile['uid']);

    if (profile['name'] == null || profile['name'] == "")
      return Container();

    return GestureDetector(
        onTap: () async {

          if (selected.contains(chatInfo))
            selected.remove(chatInfo);
          else
            selected.add(chatInfo);

          print(selected);

          setState(() {

          });

        },
        child: Container(
          color: selected.contains(chatInfo) ? Colors.green : Colors.transparent,
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _profileImage(profile['uid']),
              Container(width: 32,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    profile['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(profile['email']),
                ],
              ),
            ],
          ),
        ));
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

class _profileImageState extends State<_profileImage>{

  String imageFile;

  getImagePath() {
    StorageReference photo = FirebaseStorage(storageBucket: 'gs://conferly-8779b.appspot.com/').ref().child('images/${widget._profileUid}.png');
    photo.getDownloadURL().then((data){
      setState(() {
        imageFile = data;
      });
    }).catchError((error) {

    });
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
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: (imageFile != null) ? new NetworkImage(imageFile) : (AssetImage('assets/images/profile.png')),
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