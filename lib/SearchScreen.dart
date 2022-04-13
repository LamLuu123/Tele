import 'package:flutter/material.dart';

import 'ChatModel.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  int empty = 0;
  Actions() {
    if (empty != 0) {
      return <Widget>[
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.clear),
              color: Colors.white,
              onPressed: () {
                searchController.clear();
                setState(() {
                  empty = 0;
                });
              },
            ))
      ];
    }
    return;
  }

  SearchAppbar(TextEditingController searchController) {
    return AppBar(
        title: TextFormField(
            cursorColor: Colors.white,
            controller: searchController,
            decoration: InputDecoration.collapsed(
              hintText: 'Search',
              hintStyle: TextStyle(fontSize: 20, color: Colors.grey,),
            ),
            keyboardType: TextInputType.text,
            onChanged: (String string) {
              if (searchController.text != '') {
                setState(() {
                  empty = 1;
                });
              } else
                setState(() {
                  empty = 0;
                });
            }),
        actions: Actions());
  }

  @override
  Widget build(BuildContext context) {
    Axis Scroll = Axis.horizontal;
    double _height=100;
    if (empty != 0) {
      Scroll = Axis.vertical;
      _height = MediaQuery.of(context).size.height;
    }
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
          appBar: SearchAppbar(searchController),
          body: Container(
              height: _height,
              margin: const EdgeInsets.symmetric(vertical: 0.0),
              child: ListView.separated(
                  scrollDirection: Scroll,
                  itemBuilder: (context, i) {
                    if (empty == 0) {
                      return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 50,
                            child: Column(

                              children:<Widget>[
                                CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(item[i].prof_URL),),
                                Text(item[i].name,style: const TextStyle(fontSize: 15),overflow: TextOverflow.clip,softWrap: false,),])
                          ));
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
                        subtitle: Text('Last seen at ' + item[i].message),
                      );
                    }
                  },
                  separatorBuilder: (context, i) {
                    if (empty == 0) {
                      return Divider();
                    } else {
                      return Divider(
                        thickness: 1,
                        indent: 85,
                        color: Colors.black,
                      );
                    }
                  },
                  itemCount: item.length))),
    );
  }
}
