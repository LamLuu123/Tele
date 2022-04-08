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
                  trailing: Row(
                    children: <Widget>[
                      Text(item[i].time),

                    ],
                  )
              );
            },
            separatorBuilder: (context, i) {
              return Divider(
                thickness: 1,
                indent: 85,
                color: Colors.black,
              );
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
        ));
  }
}
