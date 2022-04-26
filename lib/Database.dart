import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils.dart';
import 'data.dart';
import 'message.dart';
import 'user.dart';

class FirebaseApi {
  static Stream<List<User>> getUsers(){
    FirebaseFirestore.instance.collection('users').get().then((value){
      value.docs.forEach((element1) async{
        getMessages(element1.id, myId).forEach((element) async {if(element.isNotEmpty){
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
      .orderBy(UserField.lastMessageTime, descending: true)
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
      idUser: myId,
      urlAvatar: myUrlAvatar,
      username: myUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages1.add(newMessage.toJson());
    await refMessages2.add(newMessage.toJson());
  }
  static Future uploadSaveMessage(String myidUser, String message) async {
    final refMessages2 =FirebaseFirestore.instance.collection('chats/$myidUser/Savemessages');
    final newMessage = Message(
      idUser: myId,
      urlAvatar: myUrlAvatar,
      username: myUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages2.add(newMessage.toJson());
  }
  static Stream<List<Message>> getMessages(String idUser, String myidUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messagesFrom$myidUser')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));
  static Stream<List<Message>> getSaveMessages(String myidUser) =>
      FirebaseFirestore.instance
          .collection('chats/$myidUser/Savemessages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots()
          .transform(Utils.transformer(Message.fromJson));

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
  }}