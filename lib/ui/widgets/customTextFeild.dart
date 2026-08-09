
import 'package:flutter/material.dart';

import '../../core/utils/AppColors.dart';
import '../../core/utils/AppStyle.dart';

typedef MyValidate = String? Function(String?)?;

class CustomTextField extends StatelessWidget {

  Color? borderColor;
  String? hintText;
  String? labelText;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool? obscureText;
  int? maxLines;
  MyValidate   validator;
  TextEditingController? controller;
  TextInputType? keyboardType ;

  CustomTextField({
    this.keyboardType= TextInputType.text ,
    this.controller,this.maxLines,this.borderColor,this.hintText,this.labelText,this.hintStyle,
  this.labelStyle,this.prefixIcon,this.suffixIcon,this.obscureText,this.validator, required bool isObscureText
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      maxLines: obscureText == true? 1 : maxLines ,
        obscureText: obscureText?? false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle?? AppStyle.Mediam16grey,
        labelStyle: labelStyle,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor?? AppColors.greyColor,
          )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: borderColor?? AppColors.greyColor,
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: borderColor?? AppColors.redColor,
            )
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: borderColor?? AppColors.redColor,
            )
        ),
      ),
    );
  }
}
