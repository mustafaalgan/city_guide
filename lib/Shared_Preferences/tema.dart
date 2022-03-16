import 'package:city_guide/home_page_olusturucu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => SwitchListTile(
                title: Text("Tema Durumu"),
                activeColor: Colors.white,
                inactiveThumbColor: Colors.red,
                onChanged: (value) {
                  notifier.toggleTheme();
                },
                value: notifier.darkTheme,
              ),
            ),
            Consumer<ThemeNotifier>(
              builder: (contexte, notifiere, childe) => SwitchListTile(
                activeColor: Colors.white,
                inactiveThumbColor: Colors.red,
                title: Text("Ses Durumu"),
                onChanged: (valuee) {
                  notifiere.toggleThemee();
                  Firebase_Tut.Ses_Tut = valuee.toString();
                },
                value: notifiere.ses,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
