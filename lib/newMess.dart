import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'ChatScreen.dart';
import 'Database.dart';
import 'DrawerScreen.dart';
import 'SearchScreen.dart';
import 'data.dart';
import 'user.dart';

class newMess extends StatefulWidget {
  @override
  _newMess createState() => _newMess();
}
class _newMess extends State<newMess> {
  @override
  Widget build(BuildContext context) => Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("New Message"),
          actions: <Widget>[

                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchScreen()));
                  }),

               IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchScreen()));
                  }),

          ],
        ),
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
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, i) {
                            bool isMe;
                            if (i >= 3) {
                              if (i == 3) {
                                return const ListTile(
                                  title: Text(
                                    'Your contact on Telegram',
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 255, 0.8),
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              } else {
                                if(items[i - 4].idUser==myId){
                                  isMe=true;
                                }else {
                                  isMe=false;
                                }
                                return !isMe?ListTile(
                                    leading: CircleAvatar(
                                      radius: 28,
                                      backgroundImage: NetworkImage(items[i - 4].urlAvatar),
                                    ),
                                    title: Text(
                                      items[i - 4].name,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text('Last seen at '+DateFormat.Hm().format(items[i -4].lastMessageTime)+", " + DateFormat.yMd().format(items[i - 4].lastMessageTime)),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatScreen(user: items[i - 4])));
                                    }
                                ):Divider(height: 0,thickness: 0,color: Colors.transparent,);
                              }
                            } else {
                              if(items[i].idUser==myId){
                                isMe=true;
                              }else {
                                isMe=false;
                              }
                              if(i==0){
                              return ListTile(
                                leading: Icon( Icons.group),
                                title: Text(
                                  'New Group',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),

                                onTap: (){
                                },
                              );}
                              if(i==1){
                                return ListTile(
                                  leading: Icon( Icons.lock_outline),
                                  title: Text(
                                    'New Secret Chat',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),

                                  onTap: (){
                                  },
                                );}
                              if(i==2){
                                return ListTile(
                                  leading: Icon( Icons.volume_up_outlined),
                                  title: Text(
                                    'New Chanel',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),

                                  onTap: (){
                                  },
                                );}
                              return Divider(height: 0,thickness: 0,color: Colors.transparent,);
                            }
                          },
                          separatorBuilder: (context, i) {
                            if (i >= 3 - 1) {
                              if (i == 3 - 1) {
                                return const Divider(
                                  thickness: 15,
                                  color: Colors.black,
                                );
                              } else {
                                return const Divider(
                                  height: 0,
                                  thickness: 0,
                                  color: Colors.transparent,
                                );
                              }
                            } else {
                              return const Divider(
                                height: 0,
                                thickness:0,
                                color: Colors.transparent,
                              );
                            }
                          },
                          itemCount: 4 + items.length,
                        );
                      }
                    }
                }
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.person_add_alt_1_rounded,
            color: Colors.white,
          ),
          backgroundColor: Color.fromRGBO(0, 0, 255, 0.8),
          onPressed: () {},
        ),
      ));

}
Widget buildText(String text) => Center(
  child: Text(
    text,
    style: TextStyle(fontSize: 24, color: Colors.white),
  ),
);
