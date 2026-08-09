import 'dart:math';

import 'package:event_planning_3/model/event.dart';
import 'package:event_planning_3/providers/eventListProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/utils/AppColors.dart';
import '../../core/utils/AppStyle.dart';

class EventItemWidget extends StatelessWidget {
  Event event ;
  EventItemWidget({required this.event});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    return Container(
      height: height*0.28,
      margin: EdgeInsets.symmetric(vertical: height*0.01,
        horizontal: width*0.01
      ),
      padding: EdgeInsets.symmetric(vertical: height*0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
          event.image
        )),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width*0.01
            ),
            margin: EdgeInsets.symmetric(
              horizontal: width*0.02
            ),
            decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: [
            Text(event.dateTime.day.toString()
              ,style: AppStyle.bold20primary.copyWith(
                  color:  Theme.of(context).primaryColor,
                ),),
            Text(DateFormat("MMM").format(event.dateTime)
              ,style: AppStyle.bold20primary.copyWith(
                color:  Theme.of(context).primaryColor,
              ),)
          ],),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: width*0.01,
              vertical: height*0.01
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
                 borderRadius: BorderRadius.circular(10)
            ),
            margin: EdgeInsets.symmetric(
                horizontal: width*0.02
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(event.title,style: AppStyle.bold14Black,)),
              InkWell(
                  onTap: (){
                    // todo : update is favorite
                    eventListProvider.updateFavoriteEvent(event);
                  },
                  child:
                  event.isFavorite == true?
                  Icon(
                    Icons.favorite,color:  Theme.of(context).primaryColor,size: 27,):
                  Icon(
                    Icons.favorite_border,color: Theme.of(context).primaryColor,size: 27,)
              )
            ],
          ),
          )
        ],
      ),
    );
  }
}
