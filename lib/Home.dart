import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'ChatScreen.dart';
import 'Database.dart';
import 'DrawerScreen.dart';
import 'SearchScreen.dart';
import 'data.dart';
import 'newMess.dart';
import 'user.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}
class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData.dark(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Telegram"),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                    icon: const Icon(Icons.search),
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
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        bool isMe;
                        if (i >= items.length) {
                          if (i == items.length) {
                              return const ListTile(
                                title: Text(
                                  'Your contact on Telegram',
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 255, 0.8),
                                      fontWeight: FontWeight.bold),
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
                                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: items[i].LastMess.isNotEmpty?Text(items[i]
                                .LastMess):const Text(''),
                            trailing: Text(DateFormat.Hm()
                                .format(items[i].lastMessageTime)),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatScreen(user: items[i])));
                            },
                          ):const Divider(
                            height: 0,thickness: 0,color: Colors.transparent,);
                        }
                      },
                      separatorBuilder: (context, i) {
                        bool isMe;
                        if (i >= items.length - 1) {
                          if (i == items.length - 1) {
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
                          if(items[i].idUser==myId){
                            isMe=true;
                          }else {
                            isMe=false;
                          }
                          return !isMe?const Divider(
                            height: 1,
                            thickness: 1,
                            indent: 85,
                            color: Colors.black,
                          ):const Divider(
                            height: 0,thickness: 0,color: Colors.transparent,);
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
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => newMess()));},
          ),
        ));

}
  Widget buildText(String text) => Center(
    child: Text(
      text,
      style: TextStyle(fontSize: 24, color: Colors.white),
    ),
  );
