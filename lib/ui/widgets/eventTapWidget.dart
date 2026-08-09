
import 'package:flutter/cupertino.dart';

import '../../core/utils/AppColors.dart';

class EventTapWidget extends StatelessWidget {
  Color borderSelectedColor;
  Color borderUnSelectedColor;
  Color? backgroundColor;
  TextStyle selectedStyle;
  TextStyle unSelectedStyle;
  String eventName ;
  bool isSelected;
 EventTapWidget({required this.eventName,required this.selectedStyle ,required this.borderSelectedColor
  ,required this.unSelectedStyle,required this.isSelected,this.backgroundColor,required this.borderUnSelectedColor});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: height*0.005,
        horizontal: width*0.015
      ),
      decoration: BoxDecoration(
          color: isSelected? backgroundColor : AppColors.transparentColor,
          borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: isSelected? borderSelectedColor : borderUnSelectedColor
        )
      ),
      child: Center(
        child: Text(eventName,
          style: isSelected?  selectedStyle : unSelectedStyle , ),
      ),
    );
  }
}
