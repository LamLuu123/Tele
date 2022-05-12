// Obama
import 'package:meta/meta.dart';
import '../utils.dart';
import 'Database.dart';

accData account ;

class accData{
  String idUser;
  String name;
  String urlAvatar;
  String Bio;
  String Phone;

  accData({
    @required this.idUser,
    @required this.name,
    @required this.urlAvatar,
    @required this.Bio,
    @required this.Phone,
  });
  setName(String New){
    this.name=New;
  }
  setBio(String New){
    this.Bio=New;
  }
  setPhone(String New){
    this.Phone=New;
  }
  upDateName(String NewName) async {
    await FirebaseApi.upDate(this.idUser,NewName,0);
  }
  upDateBio(String NewBio) async {
    await FirebaseApi.upDate(this.idUser,NewBio,1);
  }
  upDatePhone(String NewPhone) async {
    await FirebaseApi.upDate(this.idUser,NewPhone,2);
  }
}