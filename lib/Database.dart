import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils.dart';
import 'data.dart';
import 'message.dart';
import 'user.dart';

class FirebaseApi {
  static Stream<List<User>> getUsers() => FirebaseFirestore.instance
      .collection('users')
      .orderBy(UserField.lastMessageTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(User.fromJson));
  
  static Stream<List<User>> searchUsers(String searchName) => FirebaseFirestore.instance
      .collection('users')
      .where("name",isEqualTo: searchName)
      .snapshots()
      .transform(Utils.transformer(User.fromJson));

  static Future uploadMessage(String idUser,String myidUser, String message) async {
    final refMessages1 =
    FirebaseFirestore.instance.collection('chats/$idUser/messagesto$myidUser');
    final refMessages2 =FirebaseFirestore.instance.collection('chats/$myidUser/messagesto$idUser');
    final newMessage = Message(
      idUser: myId,
      urlAvatar: myUrlAvatar,
      username: myUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessages1.add(newMessage.toJson());
    await refMessages2.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers
        .doc(idUser)
        .update({UserField.lastMessageTime: DateTime.now(),UserField.LastMess: message});
    await refUsers
        .doc(myidUser)
        .update({UserField.lastMessageTime: DateTime.now(),UserField.LastMess: message});
    Map<String,dynamic> Data= {
      "LastMess": message,
    };
  }

  static Stream<List<Message>> getMessages(String idUser, String myidUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messagesto$myidUser')
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
        Map<String,dynamic> Data={
          "From": user.idUser,
          "Mess":'',
        };
        //final refUsersLast = FirebaseFirestore.instance.collection('users').doc('${newUser.idUser}').collection(collectionPath);
      }
    }
  }
  static Future<QuerySnapshot<Map<String, dynamic>>> getLastMessage(String idUser)async{
    return await FirebaseFirestore.instance
        .collection('chats/$idUser/messages')
        .orderBy(MessageField.createdAt, descending: true)
        .get();
  }
}