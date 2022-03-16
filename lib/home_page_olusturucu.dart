import 'dart:ui';

//Isparta uluborlu

import 'package:audioplayer/audioplayer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'Ortak_Sayfalar/Ortak_Page.dart';
import 'Shared_Preferences/tema.dart';
import 'Shared_Preferences/theme_provider.dart';

// ignore: camel_case_types
class Firebase_Tut {
  // ignore: non_constant_identifier_names
  static String Ses_Tut;

  // ignore: non_constant_identifier_names
  static String Mekan_Kategori_Tut;

  // ignore: non_constant_identifier_names
  static String Id_tut;
}

var tuttur;
var dbRef = FirebaseDatabase.instance
    .reference()
    .child("kategori")
    .orderByChild("kategori_sira");
var query = dbRef.onChildAdded.forEach((element) {
  print(element.snapshot.value);
});

List<Map<dynamic, dynamic>> liste = [];
final List<String> images = [
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

FutureBuilder<DataSnapshot> buildFutureBuilder(ThemeNotifier notifier) {
  return FutureBuilder(
    future: dbRef.once(),
    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
      if (snapshot.hasData) {
        liste.clear();

        Map<dynamic, dynamic> values = snapshot.data.value;
        values.forEach((key, values) {
          liste.add(values);
        });

        return Center(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.black,
                          ),
                          iconSize: 36,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsPage(),
                              ),
                            );
                          }),
                    ),
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/cepkent-17660.appspot.com/o/ic_launcher.png?alt=media&token=7ea54561-db27-4183-8f04-ff8490c00cb5",
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(liste.length, (index) {
                      return Center(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                iconSize: 70,
                                icon: Image.network(
                                  liste[index]["kategori_resim"],
                                ),
                                onPressed: () {
                                  play() {
                                    AudioPlayer audioPlayer = AudioPlayer();
                                    audioPlayer.play(
                                        "${liste[index]["kategori_audio"]}");
                                  }

                                  if (Firebase_Tut.Ses_Tut == "true") {
                                    play();
                                  }

                                  Firebase_Tut.Mekan_Kategori_Tut =
                                      (liste[index]['kategori_ad'].toString());

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Ortak_Sayfalar(),
                                    ),
                                  );
                                },
                              ),
                              Text(liste[index]["kategori_ad"]),
                              // Text(liste[index]["kategori_sira"]),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(45),
                  child: new Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return new Image.network(
                        images[index],
                        fit: BoxFit.fill,
                      );
                    },
                    autoplay: true,
                    itemCount: images.length,
                    pagination: new SwiperPagination(
                      margin: new EdgeInsets.all(0.0),
                      builder: new SwiperCustomPagination(
                        builder:
                            (BuildContext context, SwiperPluginConfig config) {
                          return new ConstrainedBox(
                            child: new Row(
                              children: <Widget>[
                                new Expanded(
                                  child: new Align(
                                    alignment: Alignment.center,
                                    child: new DotSwiperPaginationBuilder(
                                            color: Colors.white,
                                            activeColor: Colors.black,
                                            size: 10.0,
                                            activeSize: 15.0)
                                        .build(context, config),
                                  ),
                                )
                              ],
                            ),
                            constraints:
                                new BoxConstraints.expand(height: 50.0),
                          );
                        },
                      ),
                    ),
                    control: new SwiperControl(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return Center(child: CircularProgressIndicator());
    },
  );
}
