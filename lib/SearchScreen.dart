import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'Database.dart';
import 'data.dart';
List<SearchModel> Searchitem= [];
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  bool isLoading = false;
  ScrollController _chatScrollController;
  int loadMoreMsgs = 10; // at first it will load only 10
  int a = 20;
  TextEditingController searchController = TextEditingController();
  bool empty = true;
  void initState() {
    if(!empty){
    _chatScrollController = ScrollController()
      ..addListener(() async {
        if (_chatScrollController.position.atEdge) {
          if (_chatScrollController.position.pixels == 0){
            setState(() {
              isLoading = false;
            });
            //print('ListView scrolled to top');
          }
          else {

            if (!isLoading) {
              setState(() {
                isLoading = true;
              });
            }
            await FirebaseApi.getSaveMessagesLeng(account.idUser).
            forEach((element) {
              setState(() {
                if(loadMoreMsgs<element.length) {
                  loadMoreMsgs =  loadMoreMsgs + a;
                  //print('ListView scrolled to bottom '+loadMoreMsgs.toString()+ isLoading.toString());
                }else{
                  isLoading = false;
                  //print('ListView scrolled to bottom '+loadMoreMsgs.toString()+ isLoading.toString());
                }
              });
            });
            // }
            //print('ListView scrolled to bottom '+loadMoreMsgs.toString()+ isLoading.toString());
          }
        }
      });}
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    if(!empty){
    //_chatScrollController.dispose();
    searchController.dispose();}
    // TODO: implement dispose
    super.dispose();
  }
  Actions() {
    if (!empty) {
      return <Widget>[
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.clear),
              color: Colors.white,
              onPressed: () {
                searchController.clear();
                setState(() {
                  empty = true;
                  Searchitem.clear();
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
              Searchitem.clear();
              FirebaseApi.searchUsers(searchController.text).forEach((element) {
                //Searchitem.clear();
                for (int i = 0; i < element.length; i++) {
                  Map<String, dynamic>Da = element[i].toJson();
                  String name = Da['name'];
                  DateTime time = Da['lastMessageTime'];
                  String avatar = Da['urlAvatar'];
                  setState(() {
                    Searchitem.add(
                        SearchModel(Sname: name, Stime: time, Savatar: avatar));
                  });
                }
              }
              );
              if (searchController.text != '') {
                setState(() {
                  empty = false;
                });
              } else
                setState(() {
                  empty = true;
                  Searchitem.clear();
                });
            }),
        actions: Actions());
  }
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity:1.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    Axis Scroll = Axis.horizontal;
    double _height=100;
    if (!empty) {
      Scroll = Axis.vertical;
      _height = MediaQuery.of(context).size.height;
      setState(() {
      });
    }
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
          appBar: SearchAppbar(searchController),
          body:Container(
              height: _height,
              margin: const EdgeInsets.symmetric(vertical: 0.0),
            child:StreamBuilder(
                stream: empty?FirebaseApi.getUsers():FirebaseApi.searchUsers(searchController.text),
                builder: (context,snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if(snapshot.hasError){
                        print(snapshot.error);
                        return buildText('Something Went Wrong Try later');
                      }
                      else{
                        final item = snapshot.data;
                        if(item.isEmpty){
                          return buildText('No Users Found');
                        }else{
                          return ListView.separated(
                            controller: _chatScrollController,
                              scrollDirection: Scroll,
                              itemBuilder: (context, i) {
                                if (empty) {
                                  bool isMe;
                                  if(item[i].idUser==account.idUser){
                                    isMe=true;
                                  }else {
                                    isMe=false;
                                  }
                                  return !isMe?Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        width: 50,
                                        child: Column(
                                            children:<Widget>[
                                              GestureDetector(
                                                child:CircleAvatar(
                                                    radius: 28,
                                                    backgroundImage: NetworkImage(item[i].urlAvatar)),
                                                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatScreen(user: item[i])));},
                                              )
                                              ,
                                              Text(item[i].name,style: const TextStyle(fontSize: 15),overflow: TextOverflow.clip,softWrap: false,),]),
                                      )):Divider(height: 0,thickness: 0,color: Colors.transparent,);
                                } else {
                                  return  (i==item.length-1&&isLoading)? _buildProgressIndicator() :ListTile(
                                    leading: CircleAvatar(
                                      radius: 28,
                                      backgroundImage: NetworkImage(Searchitem[i].Savatar),
                                    ),
                                    title: Text(
                                      Searchitem[i].Sname,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text( Searchitem[i].Stime.toString()),
                                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChatScreen(user: item[i])));},
                                  );
                                }
                              },
                              separatorBuilder: (context, i) {
                                if (empty) {
                                  return Divider();
                                } else {
                                  return Divider(
                                    thickness: 1,
                                    indent: 85,
                                    color: Colors.black,
                                  );
                                }
                              },
                              itemCount: item.length);
                        }
                      }
                  }
                }),
    )
    ));
  }
}
class SearchModel{
  final String Sname;
  final DateTime Stime;
  final  String Savatar;
  SearchModel({this.Sname,this.Stime,this.Savatar});
}
Widget buildText(String text) => Center(
  child: Text(
    text,
    style: TextStyle(fontSize: 24, color: Colors.white),
  ),
);