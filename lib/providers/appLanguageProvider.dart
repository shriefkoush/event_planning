import 'package:flutter/cupertino.dart';

class AppLanguageProvider extends ChangeNotifier {

  //data   // function
  String appLanguage ="en";
  void changeAppLanguage(String newLanguage){
    if(newLanguage == appLanguage){
      return ;
    }else{
      appLanguage = newLanguage ;
      notifyListeners();
    }

  }

}
