
import 'package:event_planning_3/providers/eventListProvider.dart';
import 'package:event_planning_3/ui/widgets/eventItemWidget.dart';
import 'package:event_planning_3/ui/widgets/eventTapWidget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/AppColors.dart';
import '../../../../core/utils/AppStyle.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../model/event.dart';

class Hometap extends StatefulWidget {
  @override
  State<Hometap> createState() => _HometapState();
}

class _HometapState extends State<Hometap> {

  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    eventListProvider.getEventNameList(context);
    if(eventListProvider.eventsList.isEmpty){
      eventListProvider.getAllEvents();
    }
    // List<String> eventNameList = [
    //   AppLocalizations.of(context)!.all,
    //   AppLocalizations.of(context)!.sport,
    //   AppLocalizations.of(context)!.meeting,
    //   AppLocalizations.of(context)!.eating,
    //   AppLocalizations.of(context)!.exhibition,
    //   AppLocalizations.of(context)!.book_club,
    //   AppLocalizations.of(context)!.holiday,
    //   AppLocalizations.of(context)!.gaming,
    //   AppLocalizations.of(context)!.birthday,
    //   AppLocalizations.of(context)!.workShop,
    // ];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.1,
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome,
                  style: AppStyle.regular16white,
                ),
                Text("Route Academy", style: AppStyle.bold24white),
              ],
            ),
            Row(
              children: [
                Icon(Icons.sunny, size: 25, color: AppColors.whiteColor),
                SizedBox(width: width * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.015,
                    vertical: height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.whiteColor,
                  ),
                  child: Text("En", style: AppStyle.bold20primary.copyWith(
                    color: Theme.of(context).primaryColor
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
      // backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            height: height * 0.13,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.whiteColor,
                      size: 30,
                    ),
                    Text("Alex", style: AppStyle.regular16white),
                    Text(" ,Egypt", style: AppStyle.regular16white),
                  ],
                ),
                DefaultTabController(
                  length: eventListProvider.eventNameList.length,
                  child: TabBar(
                    onTap: (index) {
                      eventListProvider.changeSelectedIndex(index);
                    },
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    dividerColor: AppColors.transparentColor,
                    indicatorColor: AppColors.transparentColor,
                    labelPadding: EdgeInsets.symmetric(
                      vertical: height * 0.01,
                      horizontal: width * 0.02,
                    ),
                    tabs:
                        eventListProvider.eventNameList.map((eventName) {
                          return EventTapWidget(
                            backgroundColor: AppColors.whiteColor,
                            borderSelectedColor: Theme.of(context).primaryColor,
                            borderUnSelectedColor: AppColors.whiteColor,
                            selectedStyle: AppStyle.Mediam16primary.copyWith(
                              color:  Theme.of(context).primaryColor,
                            ),
                            unSelectedStyle: AppStyle.Mediam16white,
                            eventName: eventName,
                            isSelected:
                                eventListProvider.selectedIndex ==
                                eventListProvider.eventNameList.indexOf(eventName),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: eventListProvider.filterList.isEmpty?
              Center(child: Text("no items found.."),)
              :
          ListView.builder(itemBuilder: (context , index){
            return EventItemWidget(
              event: eventListProvider.filterList[index],
            );
          },
            padding: EdgeInsets.symmetric(vertical: height*0.01,
            horizontal: width*0.02
            ),
            itemCount: eventListProvider.filterList.length,
          )
          )

        ],
      ),
    );
  }
}
