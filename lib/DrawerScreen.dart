import 'package:flutter/material.dart';
import 'Contacts.dart';
import 'SavedMess.dart';
import 'SettingScreen.dart';
import 'data.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreen createState() => _DrawerScreen();
}

class _DrawerScreen extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData.dark(),
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.8)),
                accountName: Text(myUsername),
                accountEmail: Text('+0383765687'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(myUrlAvatar),
                  backgroundColor: Colors.white,
                ),
                arrowColor: Color.fromRGBO(255, 255, 255, 1),
                onDetailsPressed: () {
                },
              ),
              DrawerListTitle(
                iconData: Icons.group,
                title: "New Group",
                onTitlePressed: () {},
              ),
              DrawerListTitle(
                iconData: Icons.person,
                title: "Contacts",
                onTitlePressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Contacts()));},
              ),
              DrawerListTitle(
                iconData: Icons.call,
                title: "Call",
                onTitlePressed: () {},
              ),
              DrawerListTitle(
                iconData: Icons.location_history,
                title: "People Nearby",
                onTitlePressed: () {},
              ),
              DrawerListTitle(
                iconData: Icons.bookmark,
                title: "Save Messages",
                onTitlePressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SavedScreen(user: myId)));},
              ),
              DrawerListTitle(
                iconData: Icons.settings,
                title: "Settings",
                onTitlePressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SettingScreen()));},
              ),
              Divider(
                height: 2,
                thickness: 2,
                color: Colors.black,
              ),
              DrawerListTitle(
                iconData: Icons.person_add,
                title: "Invite Friend",
                onTitlePressed: () {},
              ),
              DrawerListTitle(
                iconData: Icons.help_outline,
                title: "Teleram Features",
                onTitlePressed: () {},
              ),
            ],
          ),
        ));
  }
}

class DrawerListTitle extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTitlePressed;

  const DrawerListTitle({Key key, this.iconData, this.onTitlePressed, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(iconData),
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      onTap: onTitlePressed,
    );
  }
}
class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate({this.menuAnimation})
      : super(repaint: menuAnimation);

  final Animation<double> menuAnimation;

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) {
    return menuAnimation != oldDelegate.menuAnimation;
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = 0; i < context.childCount; ++i) {
      dx = context.getChildSize(i).width * i;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(
          0 * menuAnimation.value,
          dx* menuAnimation.value,
          0,
        ),
      );
    }
  }
}