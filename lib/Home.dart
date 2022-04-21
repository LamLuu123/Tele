import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tele/ChatScreen.dart';
import 'package:tele/data.dart';
import 'DrawerScreen.dart';
import 'SearchScreen.dart';
import 'Database.dart';
import 'message.dart';
import 'user.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}
class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData.dark(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Telegram"),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchScreen()));
                    }),
              )
            ],
          ),
          drawer: DrawerScreen(),
          body: SafeArea(
            child: StreamBuilder<List<User>>(
              stream: FirebaseApi.getUsers(),
              builder: (context,snapshot){
                switch (snapshot.connectionState) {
                  //case ConnectionState.waiting:
                     //return Center(child: CircularProgressIndicator());
                 default:
                   if (snapshot.hasError) {
                     print(snapshot.error);
                     return buildText('Something Went Wrong Try later');
                     }
                 else {
                  final items = snapshot.data;

                  if (items?.isEmpty??true) {
                    return buildText('No Users Found');
                  } else {
                    return ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        bool isMe;
                        if (i >= items.length) {
                          if (i == items.length) {
                              return ListTile(
                                title: Text(
                                  'Your contact on Telegram',
                                  style: TextStyle(color: Color.fromRGBO(0, 0, 255, 0.8), fontWeight: FontWeight.bold),
                                ),
                              );
                          } else {
                            if(items[i - items.length - 1].idUser==myId){
                              isMe=true;
                            }else {
                              isMe=false;
                            }
                            return !isMe?ListTile(
                                leading: CircleAvatar(
                                  radius: 28,
                                  backgroundImage: NetworkImage(items[i - items.length - 1].urlAvatar),
                                ),
                                title: Text(
                                  items[i - items.length - 1].name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text('Last seen at '+DateFormat.Hm().format(items[i - items.length - 1].lastMessageTime)+", " + DateFormat.yMd().format(items[i - items.length - 1].lastMessageTime)),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatScreen(user: items[i - items.length - 1])));
                                }
                            ):Divider(height: 0,thickness: 0,color: Colors.transparent,);
                          }
                        } else {
                        if(items[i].idUser==myId){
                        isMe=true;
                        }else {
                        isMe=false;
                        }
                          return !isMe?ListTile(
                            leading: CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(items[i].urlAvatar),
                            ),
                            title: Text(
                              items[i].name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(''),
                            trailing: Text(DateFormat.Hm().format(items[i].lastMessageTime)),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatScreen(user: items[i])));
                            },
                          ):Divider(height: 0,thickness: 0,color: Colors.transparent,);
                        }
                      },
                      separatorBuilder: (context, i) {
                        bool isMe;
                        if (i >= items.length - 1) {
                          if (i == items.length - 1) {
                            return Divider(
                              thickness: 15,
                              color: Colors.black,
                            );
                          } else {
                            return Divider(
                              height: 0,
                              thickness: 0,
                              color: Colors.transparent,
                            );
                          }
                        } else {
                          if(items[i].idUser==myId){
                            isMe=true;
                          }else {
                            isMe=false;
                          }
                          return !isMe?Divider(
                            height: 1,
                            thickness: 1,
                            indent: 85,
                            color: Colors.black,
                          ):Divider(height: 0,thickness: 0,color: Colors.transparent,);
                        }
                      },
                      itemCount: items.length * 2 +1,
                    );
                  }
    }
              }
              }),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.create,
              color: Colors.white,
            ),
            backgroundColor: Color.fromRGBO(0, 0, 255, 0.8),
            onPressed: () {},
          ),
        ));
  }

}
  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24, color: Colors.white),
    ),
  );
String getLastMess(String idUser){
  String LastMess='Nothing';
  Future<QuerySnapshot<Map<String, dynamic>>> temp = FirebaseApi.getLastMessage(idUser);
  temp;
  print(temp);
  return LastMess;
}