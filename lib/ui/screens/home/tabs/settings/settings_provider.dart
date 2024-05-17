import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier{
  ThemeMode currentMode = ThemeMode.light;
  bool isDarkMode ()=> currentMode == ThemeMode.dark;
  void setMode(ThemeMode newMode){
   currentMode = newMode;
   notifyListeners();
  }
}