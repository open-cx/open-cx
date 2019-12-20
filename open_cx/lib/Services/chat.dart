import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> createChatWithTwoUsers(String uid1, String uid2, String name1, String name2){

  String chatName = uid1.compareTo(uid2) < 0 ? uid1 + uid2 : uid2 + uid1;

  var documentReference = Firestore.instance
      .collection('Chats')
      .document(chatName);

  return Firestore.instance.runTransaction((transaction) async {
    await transaction.set(
      documentReference,
      {
        'lastMessage': Timestamp.now(),
        'name': "Test",
        'participants': [uid1, uid2],
        'chatName': {
          uid1: name2,
          uid2: name1
        },
        'chatImage': {
          uid1: uid2,
          uid2: uid1
        }
      },
    );
    print("Done creating chat");
  }).then( (value) {
    return chatName;
  });
}

Future<String> createChatWithMultipleUsers(List<ChatInfo> chatInfos){

  String chatName;

  if (chatInfos.length == 2){
    String uid1 = chatInfos[0].getUid; String uid2 = chatInfos[1].getUid;
    chatName = chatInfos[0].getUid.compareTo(uid2) < 0 ? uid1 + uid2 : uid2 + uid1;
  } else {
    chatName = Timestamp.now().millisecondsSinceEpoch.toString();
  }



  var documentReference = Firestore.instance
      .collection('Chats')
      .document(chatName);

  if (chatInfos.length == 2) {
    String uid1 = chatInfos[0].getUid; String uid2 = chatInfos[1].getUid;
    String name1 = chatInfos[0].getName; String name2 = chatInfos[1].getName;
    return Firestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        {
          'lastMessage': Timestamp.now(),
          'name': "Test",
          'participants': [uid1, uid2],
          'chatName': {
            uid1: name2,
            uid2: name1
          },
          'chatImage': {
            uid1: uid2,
            uid2: uid1
          }
        },
      );
      print("Done creating chat");
    }).then((value) {
      return chatName;
    });
  } else {
    Map<String, String> chatNames = Map();
    Map<String, String> chatImages = Map();
    List<String> chatParticipants = List();
    StringBuffer nameCHAT = new StringBuffer();


    for (int i = 0; i < chatInfos.length; i++){
      nameCHAT.write(chatInfos[i].getName);
      if (i != chatInfos.length-1)
        nameCHAT.write(", ");
    }

    for (int i = 0; i < chatInfos.length; i++){
      chatParticipants.add(chatInfos[i].getUid);
      chatNames.putIfAbsent(chatInfos[i].getUid, () => nameCHAT.toString());
      chatImages.putIfAbsent(chatInfos[i].getUid, () => chatInfos[i].getUid);
    }
    return Firestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        {
          'lastMessage': Timestamp.now(),
          'name': "Test",
          'participants': chatParticipants,
          'chatName': chatNames,
          'chatImage': chatImages
        },
      );
      print("Done creating chat");
    }).then((value) {
      return chatName;
    });
  }
}

class ChatInfo {

  final String name;
  final String uid;

  ChatInfo(this.name, this.uid);

  @override
  bool operator ==(other) {
    return (this.name == other.name && this.uid == other.uid);
  }

  String get getName {
    return name;
  }

  String get getUid {
    return uid;
  }

}