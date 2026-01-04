import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_3/ui/widgets/toastMsg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../firebaseUtils.dart';
import '../model/event.dart';

class EventListProvider extends ChangeNotifier {
  /// data       ,         function

  List<Event> eventsList = [];
  List<Event> filterList = [];
  List<Event> favoriteEventList = [];
  int selectedIndex = 0;
  List<String> eventNameList = [
    "all",
    "sport",
    "meeting",
    "eating",
    "exhibition",
    "book_club",
    "holiday",
    "gaming",
    "birthday",
    "workShop",
  ];

  void getEventNameList(BuildContext context){
    eventNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.eating,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.workShop,
    ];
  }
  void getFavoriteEvent()async{
   var querySnapshot = await FirebaseUtils.getEventCollection().orderBy("dateTime").where("isFavorite",
    isEqualTo: true).get();
    favoriteEventList = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList();
    notifyListeners();
  }
  getAllEvents()async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection().get();
    eventsList= querySnapshot.docs.map((doc){
      return doc.data();
    }).toList();
    filterList = eventsList ;
    // TODO : SORTING
    filterList.sort((Event event1 , Event event2){
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }
  getFilterEvents()async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection().get();
    eventsList= querySnapshot.docs.map((doc){
      return doc.data();
    }).toList();
    // TODO : FILTER EVENT LIST
   filterList = eventsList.where((event){ return
      event.eventName == eventNameList[selectedIndex];
    }).toList();
    // TODO : SORTING
    filterList.sort((Event event1 , Event event2){
      return event1.dateTime.compareTo(event2.dateTime);
    });

    notifyListeners();
  }
  getFilterEvents1()async{
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection().where("eventName",isEqualTo:
    eventNameList[selectedIndex])
        .get();
    filterList= querySnapshot.docs.map((doc){
      return doc.data();
    }).toList();
   // filterList = eventsList.where((event){ return
   //    event.eventName == eventNameList[selectedIndex];
   //  }).toList();
    notifyListeners();
  }
  void changeSelectedIndex(int newSelectedIndex){
    selectedIndex = newSelectedIndex;
    if(selectedIndex == 0){
      getAllEvents();
    }else{
    getFilterEvents();
  }
  }
  void updateFavoriteEvent(Event event){
    FirebaseUtils.getEventCollection().doc(event.id).update({
      "isFavorite" : !event.isFavorite
    }).timeout(Duration(milliseconds: 500),onTimeout:
    (){
      print("event updated successfully");
      ToastMessage.toastMsg(msg: "Event updated successfully.");
      selectedIndex == 0 ? getAllEvents() : getFilterEvents();
      getFavoriteEvent();
    }
    );
    notifyListeners();
  }

}