import 'package:city_guide/home_page_olusturucu.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Ortak_Card.dart';

// ignore: camel_case_types
class Bilgileri_Tut {
  String adi;
  String adres;
  String boylam;
  String enlem;
  String resim;
  String aciklama;
  String tel;
  String web;
  Bilgileri_Tut(
      {this.adi,
      this.adres,
      this.boylam,
      this.enlem,
      this.resim,
      this.aciklama,
      this.tel,
      this.web});
}

// ignore: must_be_immutable, camel_case_types
class Ortak_Sayfalar extends StatelessWidget {
  final dbRef = FirebaseDatabase.instance
      .reference()
      .child("mekan")
      .orderByChild("mekan_kategori")
      .equalTo(Firebase_Tut.Mekan_Kategori_Tut);

  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder(
          future: dbRef.once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasData) {
              lists.clear();
              Map<dynamic, dynamic> values = snapshot.data.value;
              if (values != null) {
                // print(values.values);
                // print(values);
                values.forEach(
                  (key, values) {
                    lists.add(values);
                  },
                );
                return Column(
                  children: [
                    new ListView.builder(
                      padding: new EdgeInsets.all(10.0),
                      shrinkWrap: true,
                      itemCount: lists.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
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
                                    '${lists[index]['mekan_resim']}',
                                    width: 80,
                                    // color: Colors.yellow,
                                  ),
                                ),
                                title: Text(
                                  '${lists[index]['mekan_ad']}',
                                  style: TextStyle(fontSize: 22),
                                ),
                                subtitle: Text(
                                  '${lists[index]['mekan_adres']}',
                                  style: TextStyle(
                                      // color: Colors.black,
                                      fontSize: 15),
                                ),
                                onTap: () {
                                  Bilgileri_Tut bilgileriTut = Bilgileri_Tut(
                                    adi: lists[index]['mekan_ad'].toString(),
                                    adres:
                                        lists[index]['mekan_adres'].toString(),
                                    boylam:
                                        lists[index]['mekan_boylam'].toString(),
                                    enlem:
                                        lists[index]['mekan_enlem'].toString(),
                                    resim:
                                        lists[index]['mekan_resim'].toString(),
                                    aciklama:
                                        lists[index]['mekan_sehir'].toString(),
                                    tel: lists[index]['mekan_tel'].toString(),
                                    web: lists[index]['mekan_web'].toString(),
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Ortak_Card(
                                        bilgileri_tut: bilgileriTut,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else if (values == null) {
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
                    child: Center(
                      child: Text(
                        "Henüz bu Kategoriye ait\n mekan oluşturulmadı",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black),
                      ),
                    ),
                  ),
                );
              }
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
