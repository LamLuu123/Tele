import 'package:flutter/material.dart';

import 'SettingScreen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreen createState() => _DrawerScreen();
}

class _DrawerScreen extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData.dark(),
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.8)),
                accountName: const Text('Luu Van Lam'),
                accountEmail: const Text('+0383765687'),
                currentAccountPicture: const CircleAvatar(
                  //backgroundImage: AssetImage(''),
                  backgroundColor: Colors.white,
                ),
                arrowColor: Color.fromRGBO(255, 255, 255, 1),
                onDetailsPressed: () {},
              ),
              DrawerListTitle(
                iconData: Icons.group,
                title: 'New Group',
                onTitlePressed: () {},
              ),
              DrawerListTitle(
                iconData: Icons.person,
                title: 'Contacts',
                onTitlePressed: () {},
              ),
              DrawerListTitle(
                iconData: Icons.call,
                title: 'Call',
                onTitlePressed: () {},
              ),
              DrawerListTitle(
                iconData: Icons.location_history,
                title: 'People Nearby',
                onTitlePressed: () {},
              ),
              DrawerListTitle(
                iconData: Icons.bookmark,
                title: 'Save Messages',
                onTitlePressed: () {},
              ),
              DrawerListTitle(
                iconData: Icons.settings,
                title: 'Settings',
                onTitlePressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));},
              ),
              const Divider(
                height: 2,
                thickness: 2,
                color: Colors.black,
              ),
              DrawerListTitle(
                iconData: Icons.person_add,
                title: 'Invite Friend',
                onTitlePressed: () {},
              ),
              DrawerListTitle(
                iconData: Icons.help_outline,
                title: 'Teleram Features',
                onTitlePressed: () {},
              ),
            ],
          ),
        ));
}

class DrawerListTitle extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTitlePressed;

  const DrawerListTitle({Key key, this.iconData, this.onTitlePressed, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
      dense: true,
      leading: Icon(iconData),
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      onTap: onTitlePressed,
    );
}
