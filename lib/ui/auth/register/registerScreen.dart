import 'package:event_planning_3/core/helpers/shared_pref_helper.dart';
import 'package:event_planning_3/ui/auth/login/loginScreen.dart';
import 'package:event_planning_3/ui/homeScreen/homeScreen.dart';
import 'package:event_planning_3/ui/widgets/customElevatedButton.dart';
import 'package:event_planning_3/ui/widgets/customTextFeild.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/AppColors.dart';
import '../../../core/utils/AppStyle.dart';
import '../../../core/utils/assets_Manager.dart';
import '../../../core/utils/dialogUtils.dart';
import '../../../l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "registerScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObscureText = true;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     AppLocalizations.of(context)!.register,
      //     style: AppStyle.Mediam20white,
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: height*0.07 ,horizontal: width*0.02),
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
                SizedBox(height: height * 0.022),
                CustomTextField(
                  isObscureText: isObscureText,
                  controller: nameController,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please, enter your name!";
                    }
                    return null;
                  },
                  prefixIcon: Icon(Icons.person, color: AppColors.greyColor),
                  hintStyle: AppStyle.Mediam16grey,
                  hintText: AppLocalizations.of(context)!.name,
                ),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  isObscureText: isObscureText,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please, enter your email!";
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
                  isObscureText: isObscureText,
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please, enter your password!";
                    }
                    if (text.length < 6) {
                      return "password should be at least 6 chars";
                    }
                    return null;
                  },
                  prefixIcon: Icon(Icons.lock, color: AppColors.greyColor),
                  // suffixIcon: Icon(
                  //   Icons.visibility_off,
                  //   color: AppColors.greyColor,
                  // ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    child: Icon(
                      isObscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility,
                      color: AppColors.blueColor,
                    ),
                  ),
                  obscureText: true,
                  hintStyle: AppStyle.Mediam16grey,
                  hintText: AppLocalizations.of(context)!.password,
                ),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  isObscureText: isObscureText,
                  controller: rePasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "please, enter your re-password!";
                    }
                    if (text.length < 6) {
                      return "password should be at least 6 chars";
                    }
                    if (text != passwordController.text) {
                      return "Re-Password dosnt match password";
                    }
                    return null;
                  },
                  prefixIcon: Icon(Icons.lock, color: AppColors.greyColor),
                  // suffixIcon: Icon(
                  //   Icons.visibility_off,
                  //   color: AppColors.greyColor,
                  // ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    child: Icon(
                      isObscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility,
                      color: AppColors.blueColor,
                    ),
                  ),
                  obscureText: true,
                  hintStyle: AppStyle.Mediam16grey,
                  hintText: AppLocalizations.of(context)!.rePassword,
                ),
                SizedBox(height: height * 0.02),
                CustomElevatedButton(
                  onButtonClick: () {
                    register();
                  },
                  text: AppLocalizations.of(context)!.create_account,
                ),
                SizedBox(height: height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.already_have_an_account,
                      style: AppStyle.Mediam16black,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: AppStyle.bold16primary.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() async{
    if (formKey.currentState?.validate() == true) {
      // todo show loading
      DialogUtils.showLoading(context: context, message: "Loading...");
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (credential.user != null) {
          await SharedPrefHelper.saveUserSession(
            tokenOrUid: credential.user!.uid,
            sessionDurationDays: 20,
          );
        }
        // todo hide loading
        DialogUtils.hideLoading(context);
        // todo show message
        DialogUtils.showMessage(context: context, title: "Success",message: "register successfully",
        posAction: (){Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);});
        print("registered successfully");
        print(credential.user?.uid??"");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // todo hide loading
          DialogUtils.hideLoading(context);
          // todo show message
          DialogUtils.showMessage(context: context,title: "Error", message: "The password provided is too weak.");
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          // todo hide loading
          DialogUtils.hideLoading(context);
          // todo show message
          DialogUtils.showMessage(context: context,title: "Error", message: "The account already exists for that email.");
          print('The account already exists for that email.');
        }
        else if (e.code == 'network-request-failed') {
          // todo hide loading
          DialogUtils.hideLoading(context);
          // todo show message
          DialogUtils.showMessage(context: context, title: "Error",
              message: 'network-request-failed');
          print('The supplied auth credential is incorrect, malformed or has expired.');}
      } catch (e) {
        // todo hide loading
        DialogUtils.hideLoading(context);
        // todo show message
        DialogUtils.showMessage(context: context,title: "Error", message: e.toString());
        print(e);
      }
    }
  }
}
