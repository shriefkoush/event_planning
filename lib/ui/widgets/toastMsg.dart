import 'package:fluttertoast/fluttertoast.dart';

import '../../core/utils/AppColors.dart';

class ToastMessage {
  static Future<bool?> toastMsg ({required String msg}){
    return
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: AppColors.whiteColor,
          fontSize: 20,
      );

  }
}