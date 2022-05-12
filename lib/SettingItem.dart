import 'package:flutter/material.dart';

import 'Dialog.dart';
import 'data.dart';

class Account {
  final String titles;
  final String subtitles;
  final VoidCallback ontap;
  Account({this.titles, this.subtitles, this.ontap});
}

List<Account> accountItem = [
Account(titles: 'Account', subtitles: ''),
Account(titles: "+"+account.Phone, subtitles: 'Tap to change phone number', ontap: () {}),
Account(titles: account.name, subtitles: 'Username', ontap: () {}),
Account(titles: account.Bio, subtitles: 'Add a few word about yourself', ontap: () {})
];

class Setting {
  final Icon icons;
  final String titles;
  final VoidCallback ontap;
  Setting({this.icons, this.titles, this.ontap});
}

final List<Setting> settingItem = [
  Setting(titles: 'Settings'),
  Setting(icons: const Icon(Icons.notifications_sharp),
      titles: 'Notifications and Sounds',
      ontap: () {}),
  Setting(icons: const Icon(Icons.lock), titles: 'Privacy and Security',
      ontap: () {}),
  Setting(icons: const Icon(Icons.pie_chart_outline), titles: 'Data and Storage',
      ontap: () {}),
  Setting(icons: const Icon(Icons.chat_bubble_outline_outlined),
      titles: 'Chat Settings ',
      ontap: () {}),
  Setting(icons: const Icon(Icons.folder), titles: 'Folder', ontap: () {}),
  Setting(icons: const Icon(Icons.devices_rounded), titles: 'Devices',
      ontap: () {}),
  Setting(icons: const Icon(Icons.language), titles: 'Language', ontap: () {}),
];

class Helps {
  final Icon icons;
  final String titles;
  final VoidCallback ontap;
  Helps({this.icons, this.titles, this.ontap});
}

final List<Helps> helpItem = [
  Helps(titles: 'Helps'),
  Helps(icons: const Icon(Icons.chat_bubble_outline_outlined),
      titles: 'Ask a Question',
      ontap: () {}),
  Helps(icons: const Icon(Icons.help_outline),
      titles: 'Telegram FAQ',
      ontap: () {}),
  Helps(icons: const Icon(Icons.privacy_tip_rounded),
      titles: 'Privacy Policy',
      ontap: () {}),
];
