import 'package:meta/meta.dart';

import '../utils.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
  static final String LastMess = 'LastMess';
}

class User {
  final String idUser;
  final String name;
  final String urlAvatar;
  final String LastMess;
  final DateTime lastMessageTime;
  final String Bio;
  final String Phone;

  const User({
    this.idUser,
    @required this.name,
    @required this.urlAvatar,
    @required this.lastMessageTime,
    @required this.LastMess,
    @required this.Bio,
    @required this.Phone,
  });

  User copyWith({
    String idUser,
    String name,
    String urlAvatar,
    String LastMess,
    String lastMessageTime,
    String Bio,
    String Phone,
  }) =>
      User(
        idUser: idUser ?? this.idUser,
        name: name ?? this.name,
        urlAvatar: urlAvatar ?? this.urlAvatar,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
        LastMess: LastMess??this.LastMess,
        Bio: Bio??this.Bio,
        Phone: Phone??this.Phone
      );

  static User fromJson(Map<String, dynamic> json) => User(
    idUser: json['idUser'],
    name: json['name'],
    urlAvatar: json['urlAvatar'],
    lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
    LastMess: json['LastMess'],
    Bio: json['bio'],
      Phone: json['phone'],
  );

  Map<String, dynamic> toJson() => {
    'idUser': idUser,
    'name': name,
    'urlAvatar': urlAvatar,
    'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
    'LastMess':LastMess,
    'bio': Bio,
    'phone':Phone,
  };
}