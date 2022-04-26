import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'Dialog.dart';
import 'SettingItem.dart';
import 'data.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreen createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  String phone =accountItem[1].titles;
  String name =accountItem[2].titles;
  String bio =accountItem[3].titles;
  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData.dark(),
        child: Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  title: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(children:<Widget>[
                      CircleAvatar(backgroundImage: NetworkImage(myUrlAvatar),
                        radius: 15,),
                      Expanded(
                        child: ListTile(title: Text('Barack Obama',style: TextStyle(fontSize: 16),textAlign: TextAlign.left,overflow: TextOverflow.clip,),
                          subtitle: Text('online',style: TextStyle(fontSize: 10),),),
            )
          ]),
        ),
                  //), //FlexibleSpaceBar//IconButton
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
                          if(index==1){
                          return ListTile(
                            title: Text(phone,//TextStyle
                        ),
                          subtitle:Text(accountItem[index].subtitles ,//Text//Center
                          ),
                            onTap: ()=>PhoneDialog(context, accountItem[index].titles).then((value){
                              if(value!=null){
                              setState(() {
                                phone="+84"+value;
                              });}
                            }),
                        );}
                          if(index==2){
                            return ListTile(
                              title: Text(name,//TextStyle
                              ),
                              subtitle:Text(accountItem[index].subtitles ,//Text//Center
                              ),
                              onTap: ()=>NameDialog(context, accountItem[index].titles).then((value){
                                if(value!=null){
                                  setState(() {
                                    name=value;
                                    myUsername=value;
                                  });}
                              }),
                            );}
                          if(index==3){
                            return ListTile(
                              title: Text(bio,//TextStyle
                              ),
                              subtitle:Text(accountItem[index].subtitles ,//Text//Center
                              ),
                              onTap: ()=>BioDialog(context, accountItem[index].titles).then((value){
                                if(value!=null){
                                  setState(() {
                                    bio=value;
                                  });}
                              }),
                            );}return Divider();},//ListTile
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
                ),
                SliverToBoxAdapter()//SliverList
              ], //<Widget>[]
            )

        ));
}
