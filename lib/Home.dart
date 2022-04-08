import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'ChatModel.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Telegram"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(),
      body: ListView.separated(
        itemBuilder: (context, i) {
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
        },
        separatorBuilder: (context, i) {
          return Divider();
        },
        itemCount: item.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.create,
          color: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(0, 0, 255, 0.8),
        onPressed: () {},
      ),
    );
  }
}
