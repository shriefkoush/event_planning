import 'package:event_planning_3/providers/appLanguageProvider.dart';
import 'package:event_planning_3/providers/appThemeProvider.dart';
import 'package:event_planning_3/utils/AppColors.dart';
import 'package:event_planning_3/utils/AppStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget {

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        InkWell(
          onTap: (){
            // change to dark
            themeProvider.changeAppTheme(ThemeMode.dark);
          },
          child: themeProvider.isDark()?
            getSelectedWidget(AppLocalizations.of(context)!.dark):
              getUnSelectedWidget(AppLocalizations.of(context)!.dark)

        ),
        SizedBox(height: height*0.02,),
        InkWell(
            onTap: (){
              //change language to arabic
              themeProvider.changeAppTheme(ThemeMode.light);
            },
            child:
        themeProvider.isDark()?
            getUnSelectedWidget(AppLocalizations.of(context)!.light):
            getSelectedWidget(AppLocalizations.of(context)!.light)
        ),
      ],),
    );
  }
  Widget getSelectedWidget(String text){
    return
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,style: AppStyle.bold20primary,),
        Icon(Icons.check,size: 25,color: AppColors.primaryLight,)
      ],
    );
  }
  Widget getUnSelectedWidget(String text){
    return
    Text(text,style: AppStyle.bold20Black,);
  }
}
