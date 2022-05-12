import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'Database.dart';
import 'Dialog.dart';
import 'Home.dart';
import 'SettingItem.dart';
import 'data.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreen createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  void getAcc(String id) async {
    await FirebaseApi.upDateAcc(id).then((value){
      String idUser;
      String name;
      String urlAvatar;
      String Bio;
      String Phone;
      value.docs.first.data().forEach((key, value) {
        switch(key){
          case "name":
            name=value;
            break;
          case "idUser":
            idUser=value;
            break;
          case "urlAvatar":
            urlAvatar=value;
            break;
          case "bio":
            Bio=value;
            break;
          case "phone":
            Phone=value;
            break;
        }
      });
      account.setName(name);
      account.setPhone(Phone);
      account.setBio(Bio);
      accountItem = [
        Account(titles: 'Account', subtitles: ''),
        Account(titles: "+"+account.Phone, subtitles: 'Tap to change phone number', ontap: () {}),
        Account(titles: account.name, subtitles: 'Username', ontap: () {}),
        Account(titles: account.Bio, subtitles: 'Add a few word about yourself', ontap: () {})
      ];
    });
    print(account.Phone.toString());
    print(account.Bio.toString());
    print(account.name.toString());
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getAcc(account.idUser);
  }
  @override
  Widget build(BuildContext context) {
    getAcc(account.idUser);
    String phone=accountItem[1].titles;
    String bio=accountItem[3].titles;
    String name=accountItem[2].titles;
    return Theme(
        data: ThemeData.dark(),
        child: Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  leading: IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext contxet) => Home()));}, icon: Icon(Icons.arrow_back)),
                  pinned: true,
                  title: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(children:<Widget>[
                      CircleAvatar(backgroundImage: NetworkImage(account.urlAvatar),
                        radius: 15,),
                      Expanded(
                        child: ListTile(title: Text(account.name,style: TextStyle(fontSize: 16),textAlign: TextAlign.left,overflow: TextOverflow.clip,),
                          subtitle: Text('online',style: TextStyle(fontSize: 10),),),
            )
          ]),
        ),
                  //), //FlexibleSpaceBar//IconButton
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                     // tooltip: 'Comment Icon',
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
                            title: Text(phone),
                          subtitle:Text(accountItem[index].subtitles ,//Text//Center
                          ),
                            onTap: ()=>PhoneDialog(context, accountItem[index].titles).then((value){
                              if(value!=null){
                              setState(() {
                                phone=value;
                                account.upDatePhone(value);
                              });}
                            }),
                        );}
                          if(index==2){
                            return ListTile(
                              title: Text(name),
                              subtitle:Text(accountItem[index].subtitles ,//Text//Center
                              ),
                              onTap: ()=>NameDialog(context, accountItem[index].titles).then((value){
                                if(value!=null){
                                  setState(() {
                                    name=value;
                                    account.upDateName(value);
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
                                    account.upDateBio(value);
                                  });}else{
                                  setState(() {
                                    bio="Bio";
                                    account.upDateBio("Bio");
                                  });
                                }
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

        ));}
}
