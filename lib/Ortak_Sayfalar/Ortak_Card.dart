import 'package:city_guide/Ortak_Sayfalar/Ortak_Page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_page_olusturucu.dart';

// ignore: must_be_immutable, camel_case_types
class Ortak_Card extends StatelessWidget {
  // ignore: non_constant_identifier_names
  Bilgileri_Tut bilgileri_tut;
  // ignore: non_constant_identifier_names
  Ortak_Card({this.bilgileri_tut});

  final dbRef = FirebaseDatabase.instance.reference().child("yemek");

  List<Map<dynamic, dynamic>> listeci = [];

  Widget _buildaciklama(BuildContext context) {
    if (Firebase_Tut.Mekan_Kategori_Tut == "Yemek") {
      return FutureBuilder(
        future: dbRef
            .orderByChild("yemek_sahibi")
            .equalTo('${bilgileri_tut.adi}')
            .once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData) {
            listeci.clear();
            Map<dynamic, dynamic> values = snapshot.data.value;
            if (values != null) {
              // print(values.values);
              print(values);
              values.forEach(
                (key, values) {
                  listeci.add(values);
                },
              );
              return Column(
                children: [
                  new ListView.builder(
                    padding: new EdgeInsets.all(10.0),
                    shrinkWrap: true,
                    itemCount: listeci.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        // color: Colors.white70,
                        // clipBehavior: Clip.antiAlias,
                        // clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                // color: Colors.blue,
                                child: Image.network(
                                  '${listeci[index]['yemek_resim']}',
                                  width: 70,
                                ),
                              ),
                              title: Text(
                                '${listeci[index]['yemek_ad']}',
                                style: TextStyle(fontSize: 22),
                              ),
                              trailing: Text(
                                '${listeci[index]['yemek_fiyat']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                '${listeci[index]['yemek_cesit']}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            } else if (values == null) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Üzgünüz!!!\n Bu Restorana ait bir \n menü olşturulmadı...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      );
    } else {
      TextStyle bioTextStyle = TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 20,
        color: Colors.black,
      );

      return Container(
        // color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.all(8.0),
        child: Text(
          '${bilgileri_tut.aciklama}',
          textAlign: TextAlign.center,
          style: bioTextStyle,
        ),
      );
    }
  }

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.8,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            '${bilgileri_tut.resim}',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        '${bilgileri_tut.adi}',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          // fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 20,
      color: Colors.black,
    );

    return Container(
      // color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        '${bilgileri_tut.adres}',
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => launch('tel:${bilgileri_tut.tel}'),
              child: Container(
                height: 60.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      Text(
                        "ARA",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () {
                MapsLauncher.launchCoordinates(
                    double.parse(bilgileri_tut.enlem),
                    double.parse(bilgileri_tut.boylam),
                    '${bilgileri_tut.adi} - ${bilgileri_tut.adres}');
              },
              child: Container(
                height: 60.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.near_me, color: Colors.black),
                      Text(
                        "KONUM",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () {
                var url = bilgileri_tut.web;
                launchURL(url);
              },
              child: Container(
                height: 60.0,
                decoration: BoxDecoration(
                  color: Color(0xFF404A5C),
                  border: Border.all(),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.web,
                        color: Colors.white,
                      ),
                      Text(
                        "WEB",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://firebasestorage.googleapis.com/v0/b/cepkent-17660.appspot.com/o/mavi_bg.jpg?alt=media&token=31476e19-9731-42cc-912d-b10483516b58",
              // "https://firebasestorage.googleapis.com/v0/b/city-guide-2d76b.appspot.com/o/mavi_bg.jpg?alt=media&token=497f1432-764f-4c28-968d-a41d23f500cd",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            _buildCoverImage(screenSize),
            // SizedBox(height: screenSize.height / 3.4),
            _buildStatus(context),
            _buildButtons(),
            _buildBio(context),
            _buildaciklama(context),
          ],
        ),
      ),
    );
  }
}
