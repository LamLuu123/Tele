import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tele/ChatScreen.dart';
import 'DrawerScreen.dart';
import 'ChatModel.dart';
import 'SearchScreen.dart';

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
          body: ListView.separated(
            itemBuilder: (context, i) {
              if (i >= item.length) {
                if (i == item.length) {
                  return ListTile(
                    title: Text(
                      'Your contact on Telegram',
                      style: TextStyle(color: Color.fromRGBO(0, 0, 255, 0.8), fontWeight: FontWeight.bold),
                    ),
                  );
                } else {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(item[i - item.length - 1].prof_URL),
                    ),
                    title: Text(
                      item[i - item.length - 1].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Last seen at ' + item[i - item.length - 1].message),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatScreen()));
                      }
                  );
                }
              } else {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(item[i].prof_URL),
                  ),
                  title: Text(
                    item[i].name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item[i].message),
                  trailing: Text(item[i].time),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatScreen()));
                  },
                );
              }
            },
            separatorBuilder: (context, i) {
              if (i >= item.length - 1) {
                if (i == item.length - 1) {
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
                return Divider(
                  height: 1,
                  thickness: 1,
                  indent: 85,
                  color: Colors.black,
                );
              }
            },
            itemCount: item.length * 2 + 1,
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
