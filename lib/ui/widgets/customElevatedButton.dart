
import 'package:event_planning_3/utils/assets_Manager.dart';
import 'package:flutter/material.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppStyle.dart';

class CustomElevatedButton extends StatelessWidget {
  Function onButtonClick;
  String text;
  TextStyle? textStyle;
  Widget? icon ;
  Color? color;
  CustomElevatedButton({
    required this.onButtonClick,
    required this.text,this.icon,this.color,this.textStyle,
  });
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: width*0.02),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.primaryLight
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(
                vertical: height*0.01,
                horizontal: width*0.02,
              ),
              backgroundColor: color ?? AppColors.primaryLight
          ),
          onPressed: (){
            onButtonClick();
          },
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? SizedBox(),
                SizedBox(width: width*0.02,),
                Text(text,style: textStyle?? AppStyle.Mediam20white,),
              ],
            ),
          )),
    );
  }
}
