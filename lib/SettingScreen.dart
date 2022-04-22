import 'package:flutter/material.dart';
import 'SettingItem.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreen createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData.dark(),
        child: Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  flexibleSpace: const FlexibleSpaceBar(
                    titlePadding: EdgeInsets.fromLTRB(30,20,0,0),
                      centerTitle: true,
                      title:  ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(""),
                          radius: 15,
                        ),
                        title: Text('Luu Van Lam',style: TextStyle(fontSize: 12),),
                        subtitle: Text('online',style: TextStyle(fontSize: 8)),
                      ),
                  ), //FlexibleSpaceBar
                  expandedHeight: 100, //IconButton
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      tooltip: 'Comment Icon',
                      onPressed: () {},
                    ), //IconButton
                    IconButton(
                      icon: Icon(Icons.more_vert_outlined),
                      tooltip: 'Setting Icon',
                      onPressed: () {},
                    ), //IconButton
                  ], //<Widget>[]
                ), //SliverAppBar
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if(index==0){
                            return ListTile(
                              title: Text(accountItem[index].titles,style:
                              const TextStyle(
                                  color: Color.fromRGBO(0, 0, 255, 0.8)),
                              ),
                            );
                          }
                          return ListTile(
                      title: Text(accountItem[index].titles,//TextStyle
                        ),
                          subtitle:Text(accountItem[index].subtitles ,//Text//Center
                    ),
                        );},//ListTile
                    childCount: accountItem.length,
                  ), //SliverChildBuildDelegate
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if(index==0){
                            return ListTile(
                              title: Text(settingItem[index].titles,style:
                              const TextStyle(
                                  color: Color.fromRGBO(0, 0, 255, 0.8)),
                              ),
                            );
                          }
                        return ListTile(
                         title: Text(settingItem[index].titles,//TextStyle
                                ),
                          leading:settingItem[index].icons ,//Text//Center
                      );}, //ListTile
                    childCount: settingItem.length,
                  ), //SliverChildBuildDelegate
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if(index==0){
                            return ListTile(
                              title: Text(helpItem[index].titles,style:
                              const TextStyle(
                                  color: Color.fromRGBO(0, 0, 255, 0.8)),
                              ),
                            );
                          }
                          return ListTile(
                      title: Text(helpItem[index].titles,//TextStyle
                      ),
                      leading:helpItem[index].icons ,//Text//Center
                    ); },//ListTile
                    childCount: helpItem.length,
                  ), //SliverChildBuildDelegate
                )//SliverList
              ], //<Widget>[]
            )));
}
