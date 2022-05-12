
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils.dart';
import 'data.dart';
import 'message.dart';
import 'user.dart';

class FirebaseApi {
  static Stream<List<User>> getUsers(){
    FirebaseFirestore.instance.collection('users').get().then((value){
      value.docs.forEach((element1) async{
        getMessages(element1.id, account.idUser,1).forEach((element) async {if(element.isNotEmpty){
          await FirebaseFirestore.instance.collection('users').doc(element1.id)
              .update({UserField.lastMessageTime: element.first.createdAt,UserField.LastMess: element.first.message});
        }else{
          await FirebaseFirestore.instance.collection('users').doc(element1.id)
              .update({UserField.LastMess: 'Say hi...'});
        }
        });
      });
    });
    return FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserField.lastMessageTime, descending: true).limit(10)
      .snapshots()
      .transform(Utils.transformer(User.fromJson));}

  static Stream<List<User>> searchUsers(String searchName) => FirebaseFirestore.instance
      .collection('users')
      .where("name",isEqualTo: searchName)
      .snapshots()
      .transform(Utils.transformer(User.fromJson));

  static Future uploadMessage(String idUser,String myidUser, String message) async {
    final refMessages1 = FirebaseFirestore.instance.collection('chats/$idUser/messagesFrom$myidUser');
    final refMessages2 =FirebaseFirestore.instance.collection('chats/$myidUser/messagesFrom$idUser');
    final newMessage = Message(
      idUser: account.idUser,
      urlAvatar: account.urlAvatar,
      username: account.name,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages1.add(newMessage.toJson());
    await refMessages2.add(newMessage.toJson());
  }
  static Future uploadSaveMessage(String myidUser, String message) async {
    final refMessages2 =FirebaseFirestore.instance.collection('chats/$myidUser/Savemessages');
    final newMessage = Message(
      idUser: account.idUser,
      urlAvatar: account.urlAvatar,
      username: account.name,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages2.add(newMessage.toJson());
  }
  static Stream<List<Message>> getMessages(String idUser, String myidUser,int limit) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messagesFrom$myidUser')
          .orderBy(MessageField.createdAt, descending: true).limit(limit)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Stream<List<Message>> getMessagesLeng(String idUser, String myidUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messagesFrom$myidUser')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Stream<List<Message>> getSaveMessagesLeng(String myidUser) =>
      FirebaseFirestore.instance
          .collection('chats/$myidUser/Savemessages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static Stream<List<Message>> getSaveMessages(String myidUser,int limit) =>
      FirebaseFirestore.instance
          .collection('chats/$myidUser/Savemessages')
          .orderBy(MessageField.createdAt, descending: true).limit(limit)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

  static upDate(String myidUser,String value,int type){
    switch (type){
      case 0:
        return FirebaseFirestore.instance.collection('users').doc(myidUser).update({'name':value});
        break;
      case 1:
        return FirebaseFirestore.instance.collection('users').doc(myidUser).update({'bio':value});
        break;
      case 2:
        return FirebaseFirestore.instance.collection('users').doc(myidUser).update({'phone':value});
        break;
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getAcc(String phone)=>FirebaseFirestore.instance
      .collection('users')
      .where("phone",isEqualTo: phone).get();

  static Future<QuerySnapshot<Map<String, dynamic>>> upDateAcc(String id)=>FirebaseFirestore.instance
      .collection('users')
      .where("idUser",isEqualTo: id).get();

  static Future addUsers(List<User> users) async {
    final refUsers = FirebaseFirestore.instance.collection('users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(idUser: userDoc.id);

        await userDoc.set(newUser.toJson());
      }
    }
  }

  static Future addNewUsers(User user) async {
    final refUsers = FirebaseFirestore.instance.collection('users');
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(idUser: userDoc.id);
        await userDoc.set(newUser.toJson());
    }
}