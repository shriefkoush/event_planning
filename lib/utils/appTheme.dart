import 'package:event_planning_3/utils/AppColors.dart';
import 'package:event_planning_3/utils/AppStyle.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppColors.primaryLight
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.primaryLight,
      showUnselectedLabels: true,
      selectedLabelStyle: AppStyle.bold12white,
      unselectedLabelStyle: AppStyle.bold12white
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDark,
     bottomAppBarTheme: BottomAppBarTheme(
      color: AppColors.primaryDark
  ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
        backgroundColor: AppColors.primaryDark,
        showUnselectedLabels: true,
        selectedLabelStyle: AppStyle.bold12white,
        unselectedLabelStyle: AppStyle.bold12white
    ),

  );
}