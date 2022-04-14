import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseMethods{
  Future<List<QueryDocumentSnapshot>> getUserName(String userName) async {
    FirebaseFirestore firestore=FirebaseFirestore.instance;
    List<QueryDocumentSnapshot<Map<String,dynamic>>> data;
    await firestore.collection('User').where("Name",isEqualTo: userName).get().then((value){
        data=value.docs;
    });
     return data;
  }
  upLoadInfor( UserMap){
    FirebaseFirestore.instance.collection("User").add(UserMap);
  }
  
}