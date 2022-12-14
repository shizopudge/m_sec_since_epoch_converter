import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class AppTheme {
  static var lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color.fromARGB(255, 231, 244, 250),
  );
  static TextStyle txtStyle1Light = GoogleFonts.ubuntu(
      fontSize: 50, color: Colors.black87, fontWeight: FontWeight.w800);
  static TextStyle txtStyle2Light = GoogleFonts.ubuntu(
      fontSize: 42, color: Colors.black, fontWeight: FontWeight.w800);
  static TextStyle txtStyle3Light = GoogleFonts.ubuntu(
      fontSize: 32, color: Colors.black, fontWeight: FontWeight.w800);
  static TextStyle txtStyle4Light = GoogleFonts.ubuntu(
      fontSize: 14, color: Colors.black, fontWeight: FontWeight.w800);
  static var darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color.fromARGB(255, 13, 13, 14),
  );
  static TextStyle txtStyle1Dark = GoogleFonts.ubuntu(
      fontSize: 50, color: Colors.white70, fontWeight: FontWeight.w800);
  static TextStyle txtStyle2Dark = GoogleFonts.ubuntu(
      fontSize: 42, color: Colors.white, fontWeight: FontWeight.w800);
  static TextStyle txtStyle3Dark = GoogleFonts.ubuntu(
      fontSize: 32, color: Colors.white, fontWeight: FontWeight.w800);
  static TextStyle txtStyle4Dark = GoogleFonts.ubuntu(
      fontSize: 14, color: Colors.white, fontWeight: FontWeight.w800);
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;
  ThemeNotifier({ThemeMode mode = ThemeMode.dark})
      : _mode = mode,
        super(AppTheme.darkTheme) {
    getTheme();
  }

  ThemeMode get mode => _mode;

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = AppTheme.lightTheme;
    } else {
      _mode = ThemeMode.dark;
      state = AppTheme.darkTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = AppTheme.lightTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = AppTheme.darkTheme;
      prefs.setString('theme', 'dark');
    }
  }
}
