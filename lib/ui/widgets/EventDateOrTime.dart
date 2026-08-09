
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/utils/AppStyle.dart';

class EventDateOrTime extends StatelessWidget {
  String iconName;
  String eventDateOrTime;
  String chooseDateOrTime;
  Function chooseDateOrTimeClicked;

  EventDateOrTime({
    required this.chooseDateOrTimeClicked,
    required this.iconName,required this.chooseDateOrTime,
  required this.eventDateOrTime});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Image.asset(iconName),
        SizedBox(width: width*0.02,),
        Text(eventDateOrTime,style: AppStyle.Mediam16black,),
        Spacer(),
        TextButton(onPressed: (){
          chooseDateOrTimeClicked();
        }, child: Text(chooseDateOrTime,style: AppStyle.Mediam16primary.copyWith(
          color: Theme.of(context).primaryColor
        ),))
      ],
    );
  }
}
