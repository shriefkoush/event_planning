import 'package:firebase_auth/firebase_auth.dart';
import 'package:event_planning_3/providers/appLanguageProvider.dart';
import 'package:event_planning_3/providers/appThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/utils/AppColors.dart';
import '../../../../core/utils/AppStyle.dart';
import '../../../../core/utils/assets_Manager.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/login/loginScreen.dart';
import '../../../widgets/languageBottomSheet.dart';
import '../../../widgets/themeBottomSheet.dart';



class ProfileTap extends StatefulWidget {

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: height*0.18,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(65))
        ),
        title: Row(children: [
          Image.asset(AssetsManager.profileImage),
          SizedBox(width: width*0.03,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Route Academy",style: AppStyle.bold24white,),
          Text("route@gmail.com",style: AppStyle.Mediam16white,)
          ],)
        ],),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: AppStyle.bold20Black,
            ),
            SizedBox(height: height*0.02,),
            InkWell(
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(languageProvider.appLanguage=="en"?
                      AppLocalizations.of(context)!.english:
                        AppLocalizations.of(context)!.arabic
                      ,style: AppStyle.bold20primary.copyWith(
                        color: Theme.of(context).primaryColor
                      ),),
                    SizedBox(height: height*0.02,),
                    Icon(Icons.arrow_drop_down,size: 25,color: Theme.of(context).primaryColor)
                  ],
                ),
              ),
            ),
            SizedBox(height: height*0.02,),
            Text(
              AppLocalizations.of(context)!.theme,
              style: AppStyle.bold20Black,
            ),
            SizedBox(height: height*0.02,),
            InkWell(
              onTap: () {
                showThemeBottomSheet();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                    themeProvider.appTheme== ThemeMode.dark?
                        AppLocalizations.of(context)!.dark:
                        AppLocalizations.of(context)!.light
                      ,style: AppStyle.bold20primary.copyWith(
                        color: Theme.of(context).primaryColor
                    ),),
                    SizedBox(height: height*0.02,),
                    Icon(Icons.arrow_drop_down,size: 25,color: Theme.of(context).primaryColor)
                  ],
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: height*0.01,
                  horizontal: width*0.02,
                ),
                backgroundColor: AppColors.redColor
              ),
                onPressed: () async {
                  await SharedPrefHelper.clearUserSession();
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginScreen.routeName,
                      (route) => false,
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app,size: 30,color: AppColors.whiteColor,),
                    SizedBox(width: width*0.02,),
                    Text(AppLocalizations.of(context)!.logout,style: AppStyle.regular16white,)
                  ],
                )),
            SizedBox(height: height*0.02,)
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(context: context,
        builder: (context)=> Languagebottomsheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(context: context,
        builder: (context)=> ThemeBottomSheet());
  }
}
