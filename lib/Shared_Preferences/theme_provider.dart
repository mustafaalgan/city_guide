import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  cardColor: Colors.white,
  // primarySwatch: Colors.indigo,
  // accentColor: Colors.pink,
  scaffoldBackgroundColor: Colors.blue,
  // appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
);

ThemeData dark = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
  ),
  brightness: Brightness.dark,
  primaryColor: Colors.lightBlue[800],

  cardColor: Color(0xff424242),

  // primarySwatch: Colors.indigo,
  // accentColor: Colors.pink,
  scaffoldBackgroundColor: Color(0xff424242),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  final String keye = "ses";
  SharedPreferences _pref;
  bool _darkTheme;
  bool _ses;

  bool get darkTheme => _darkTheme;
  bool get ses => _ses;

  ThemeNotifier() {
    _darkTheme = true;
    _ses = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  toggleThemee() {
    _ses = !_ses;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_pref == null) _pref = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _pref.getBool(key) ?? false;
    _ses = _pref.getBool(keye) ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _pref.setBool(key, _darkTheme);
    _pref.setBool(keye, _ses);
  }
}
