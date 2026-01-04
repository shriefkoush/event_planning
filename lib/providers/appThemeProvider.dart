import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {

  //data   // function
  ThemeMode appTheme = ThemeMode.light;
  void changeAppTheme(ThemeMode newTheme){
    if(newTheme == appTheme){
      return ;
    }else{
      appTheme = newTheme ;
      notifyListeners();
    }

  }
  bool isDark (){
    return appTheme == ThemeMode.dark;
  }
}
