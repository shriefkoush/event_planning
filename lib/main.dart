import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_3/providers/appLanguageProvider.dart';
import 'package:event_planning_3/providers/appThemeProvider.dart';
import 'package:event_planning_3/providers/eventListProvider.dart';
import 'package:event_planning_3/ui/addEventScreen.dart';
import 'package:event_planning_3/ui/auth/login/loginScreen.dart';
import 'package:event_planning_3/ui/auth/register/registerScreen.dart';
import 'package:event_planning_3/ui/homeScreen/homeScreen.dart';
import 'package:event_planning_3/utils/appTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> AppLanguageProvider()),
        ChangeNotifierProvider(create: (context)=> AppThemeProvider()),
        ChangeNotifierProvider(create: (context)=> EventListProvider()),
      ],
      child: ( MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName : (context)=> HomeScreen(),
        LoginScreen.routeName : (context)=> LoginScreen(),
        AddEventScreen.routeName : (context)=> AddEventScreen(),
        RegisterScreen.routeName : (context)=> RegisterScreen(),
      },
    );
  }
}