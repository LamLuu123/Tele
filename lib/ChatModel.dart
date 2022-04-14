import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Database.dart';
import 'SearchScreen.dart';
final List<SearchModel> Searchitem= [];
DatabaseMethods databaseMethods= new DatabaseMethods();
Future<List<QueryDocumentSnapshot>> data;
class ChatModel {
  final String name;
  final String message;
  final String time;
  final String prof_URL;
  final String phone;
  final String email;
  ChatModel({this.name, this.message, this.time, this.prof_URL, this.phone,this.email});

}

class SearchModel{
  final String Sname;
  final String Sphone;
  final String Semail;
  SearchModel({this.Sname,this.Sphone,this.Semail});


  getSearchList(String searchController)  {
    data = databaseMethods.getUserName(searchController);
    data.then((value){
      for(int i=0;i<value.length;i++){
        Map<String,dynamic>Da=value[0].data();
        String name=Da['Name'];
        String phone=Da['Phone'];
        String email=Da['Email'];
        Searchitem.add(SearchModel(Sname: name ,Sphone: phone,Semail:email));
      print(Da["Name"]);
    }
    }
      );
  /*
  }*/
  }
}
final List<ChatModel> item = [
  ChatModel(name: 'sgsdgsasfgdfhgh,ngcfbxczx', message: 'sdfghj', time: '10:12', prof_URL: ''),
  ChatModel(name: 'sdgsdg', message: 'sdfhmg,j', time: '10:12', prof_URL: ''),
  ChatModel(name: 'sdgsdg', message: 'sdfhdndsfn', time: '10:12', prof_URL: ''),
  ChatModel(name: 'sdgsdgs', message: 'sfnsxfsns', time: '10:12', prof_URL: ''),
  ChatModel(name: 'sgsdgs', message: 'sdfnsfnsfn', time: '10:12', prof_URL: ''),
  ChatModel(name: 'sgsdgsd', message: 'sfnsfnsnsfbs', time: '10:12', prof_URL: ''),
  ChatModel(name: 'sdgsdgs', message: 'sfbfsfbsfb', time: '10:12', prof_URL: ''),
  ChatModel(name: 'sdgsgds', message: 'bsfbsbfsbf', time: '10:12', prof_URL: ''),
  ChatModel(name: 'wegsdbf', message: 'sbsfbsf', time: '10:12', prof_URL: ''),
  ChatModel(name: 'segsfh', message: 'bfsfbs', time: '10:12', prof_URL: ''),
];

