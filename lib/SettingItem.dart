import 'package:flutter/material.dart';

class Account {
  final String titles;
  final String subtitles;
  final VoidCallback ontap;
  Account({this.titles, this.subtitles, this.ontap});
}

final List<Account> accountItem = [
  Account(titles: 'Account', subtitles: ''),
  Account(titles: '+84383765687', subtitles: 'Tap to change phone number', ontap: () {}),
  Account(titles: 'None', subtitles: 'Username', ontap: () {}),
  Account(titles: 'Bio', subtitles: 'Add a few word about yourself', ontap: () {})
];

class Setting {
  final Icon icons;
  final String titles;
  final VoidCallback ontap;
  Setting({this.icons, this.titles, this.ontap});
}

final List<Setting> settingItem = [
  Setting(icons: null, titles: 'Settings'),
  Setting(icons: Icon(Icons.notifications_sharp), titles: 'Notifications and Sounds', ontap: () {}),
  Setting(icons: Icon(Icons.lock), titles: 'Privacy and Security', ontap: () {}),
  Setting(icons: Icon(Icons.pie_chart_outline), titles: 'Data and Storage', ontap: () {}),
  Setting(icons: Icon(Icons.chat_bubble_outline_outlined), titles: 'Chat Settings ', ontap: () {}),
  Setting(icons: Icon(Icons.folder), titles: 'Folder', ontap: () {}),
  Setting(icons: Icon(Icons.devices_rounded), titles: 'Devices', ontap: () {}),
  Setting(icons: Icon(Icons.language), titles: 'Language', ontap: () {}),
];

class Helps {
  final Icon icons;
  final String titles;
  final VoidCallback ontap;
  Helps({this.icons, this.titles, this.ontap});
}

final List<Helps> helpItem = [
  Helps(icons: null, titles: 'Helps'),
  Helps(icons: Icon(Icons.chat_bubble_outline_outlined), titles: 'Ask a Question', ontap: () {}),
  Helps(icons: Icon(Icons.help_outline), titles: 'Telegram FAQ', ontap: () {}),
  Helps(icons: Icon(Icons.privacy_tip_rounded), titles: 'Privacy Policy', ontap: () {}),
];
