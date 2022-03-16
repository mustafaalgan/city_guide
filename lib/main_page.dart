import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Shared_Preferences/theme_provider.dart';
import 'home_page_olusturucu.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return new SplashScreen(
        seconds: 1,
        navigateAfterSeconds: RegisterPet(),
        image: new Image.asset('assets/pamukova_intro_video.gif'),
        backgroundColor: Colors.black,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 150.0,
        loaderColor: Colors.red,
      );
    } else if (Platform.isAndroid) {
      return Scaffold(
        body: RegisterPet(),
      );
    }
  }
}

class RegisterPet extends StatefulWidget {
  RegisterPet({Key key}) : super(key: key);

  @override
  _RegisterPetState createState() => _RegisterPetState();
}

class _RegisterPetState extends State<RegisterPet> {
  final dbRef = FirebaseDatabase.instance.reference().child("kategori");
  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return Scaffold(
            body: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/cepkent-17660.appspot.com/o/mavi_bg.jpg?alt=media&token=31476e19-9731-42cc-912d-b10483516b58",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: buildFutureBuilder(notifier),
            ),
          );
        },
      ),
    );
  }
}
