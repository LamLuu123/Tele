import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DrawerScreen.dart';
import 'ChatModel.dart';

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
                child: Icon(Icons.search),
              )
            ],
          ),
          drawer: DrawerScreen(),
          body: ListView.separated(
            itemBuilder: (context, i) {
              print(i);
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
                    thickness: 0,
                    indent: 85,
                    color: Colors.black,
                  );
                }
              } else {
                return Divider(
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
