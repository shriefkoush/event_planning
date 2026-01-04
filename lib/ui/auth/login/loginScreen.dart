import 'package:event_planning_3/ui/auth/register/registerScreen.dart';
import 'package:event_planning_3/ui/homeScreen/homeScreen.dart';
import 'package:event_planning_3/ui/widgets/customElevatedButton.dart';
import 'package:event_planning_3/ui/widgets/customTextFeild.dart';
import 'package:event_planning_3/utils/AppColors.dart';
import 'package:event_planning_3/utils/AppStyle.dart';
import 'package:event_planning_3/utils/assets_Manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/dialogUtils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: "shrief@gmail.com");
  var passwordController = TextEditingController(text: "123456");
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: height * 0.1,
          left: width * 0.02,
          right: width * 0.02,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  height: height * 0.22,
                  image: AssetImage(AssetsManager.logoImage),
                ),
                SizedBox(height: height * 0.01),
                CustomTextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please , enter your email";
                    }
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(text);
                    if (!emailValid) {
                      return "please, enter valid email";
                    }
                    return null;
                  },
                  prefixIcon: Icon(Icons.email, color: AppColors.greyColor),
                  hintStyle: AppStyle.Mediam16grey,
                  hintText: AppLocalizations.of(context)!.email,
                ),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  controller: passwordController,
                  keyboardType: TextInputType.phone,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please, enter your password!";
                    }
                    if (text.length < 6) {
                      return "password should be at least 6 chars";
                    }
                    return null;
                  },
                  prefixIcon: Icon(Icons.password, color: AppColors.greyColor),
                  suffixIcon: Icon(
                    Icons.visibility_off,
                    color: AppColors.greyColor,
                  ),
                  obscureText: true,
                  hintStyle: AppStyle.Mediam16grey,
                  hintText: AppLocalizations.of(context)!.password,
                ),
                SizedBox(height: height * 0.01),
                TextButton(
                  onPressed: () {},
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppLocalizations.of(context)!.forget_password,
                      style: AppStyle.bold16primary.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryLight,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                CustomElevatedButton(
                  onButtonClick: () {
                    login();
                  },
                  text: AppLocalizations.of(context)!.login,
                ),
                SizedBox(height: height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dont_have_an_account,
                      style: AppStyle.Mediam16black,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.create_account,
                        style: AppStyle.bold16primary.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.primaryLight,
                        thickness: 1,
                        endIndent: 20,
                        indent: 20,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.or,
                      style: AppStyle.Mediam16primary,
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.primaryLight,
                        thickness: 1,
                        endIndent: 20,
                        indent: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                CustomElevatedButton(
                  onButtonClick: () {
                    ///login with google
                  },
                  textStyle: AppStyle.Mediam20primary,
                  color: AppColors.transparentColor,
                  icon: Image(image: AssetImage(AssetsManager.googleIcon)),
                  text: AppLocalizations.of(context)!.login_with_google,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async{
    if (formKey.currentState?.validate() == true) {
      /// login
      // todo show loading
      DialogUtils.showLoading(context: context, message: "Loading...");
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        // todo hide loading
        DialogUtils.hideLoading(context);
        // todo show message
        DialogUtils.showMessage(context: context,title: "Success"
            ,message: "login successfully" , posAction: (){
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            });
        print("login successfully");
        print(credential.user?.uid??"");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
        else if (e.code == 'invalid-credential') {
          // todo hide loading
          DialogUtils.hideLoading(context);
          // todo show message
          DialogUtils.showMessage(context: context, title: "Error",message: "The supplied auth credential is incorrect, malformed or has expired.");
          print('The supplied auth credential is incorrect, malformed or has expired.');
        }
        else if (e.code == 'network-request-failed') {
          // todo hide loading
          DialogUtils.hideLoading(context);
          // todo show message
          DialogUtils.showMessage(context: context, title: "Error",
              message: 'network-request-failed');
          print('The supplied auth credential is incorrect, malformed or has expired.');
        }
      }
      catch(e){
        // todo hide loading
        DialogUtils.hideLoading(context);
        // todo show message
        DialogUtils.showMessage(context: context,title: "Error", message: e.toString());
        print(e.toString());
      }
    }
  }
}
