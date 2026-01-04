import 'package:event_planning_3/providers/appLanguageProvider.dart';
import 'package:event_planning_3/utils/AppColors.dart';
import 'package:event_planning_3/utils/AppStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Languagebottomsheet extends StatefulWidget {

  @override
  State<Languagebottomsheet> createState() => _LanguagebottomsheetState();
}

class _LanguagebottomsheetState extends State<Languagebottomsheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var languageProider = Provider.of<AppLanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        InkWell(
          onTap: (){
            // change to english
            languageProider.changeAppLanguage("en");
          },
          child: languageProider.appLanguage == "en"?
            getSelectedWidget(AppLocalizations.of(context)!.english):
              getUnSelectedWidget(AppLocalizations.of(context)!.english)

        ),
        SizedBox(height: height*0.02,),
        InkWell(
            onTap: (){
              //change language to arabic
              languageProider.changeAppLanguage("ar");
            },
            child:
        languageProider.appLanguage=="ar"?
            getSelectedWidget(AppLocalizations.of(context)!.arabic):
            getUnSelectedWidget(AppLocalizations.of(context)!.arabic)
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
