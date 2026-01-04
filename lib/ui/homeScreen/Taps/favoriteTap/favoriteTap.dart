import 'package:event_planning_3/providers/eventListProvider.dart';
import 'package:event_planning_3/ui/widgets/customTextFeild.dart';
import 'package:event_planning_3/utils/AppColors.dart';
import 'package:event_planning_3/utils/AppStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../widgets/eventItemWidget.dart';

class FavoriteTap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventListProvider = Provider.of<EventListProvider>(context);
    if (eventListProvider.favoriteEventList.isEmpty){
      eventListProvider.getFavoriteEvent();
    }
    return  Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding:  EdgeInsets.only(
          top: height*0.1,
          left: width*0.01 ,
          right: width*0.01,
        ),
        child: Column(children: [
          CustomTextField(
            hintText: AppLocalizations.of(context)!.search_event,
            hintStyle: AppStyle.bold14primary,
            prefixIcon: Icon(Icons.search,color: AppColors.primaryLight,),
            borderColor: AppColors.primaryLight,
          ),
          Expanded(child:
              eventListProvider.favoriteEventList.isEmpty?
                  Center(child: Text(AppLocalizations.of(context)!.favorite_list_is_empty,
                  style: AppStyle.Mediam16black,),):
          ListView.builder(itemBuilder: (context , index){
            return EventItemWidget(event: eventListProvider.favoriteEventList[index]);
          },
            padding: EdgeInsets.symmetric(vertical: height*0.01,
                horizontal: width*0.02
            ),
            itemCount: eventListProvider.favoriteEventList.length,
          )
          )

        ],),
      ),
    );
  }
}
