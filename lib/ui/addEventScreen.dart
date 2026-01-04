import 'package:event_planning_3/firebaseUtils.dart';
import 'package:event_planning_3/model/event.dart';
import 'package:event_planning_3/providers/eventListProvider.dart';
import 'package:event_planning_3/ui/widgets/EventDateOrTime.dart';
import 'package:event_planning_3/ui/widgets/customElevatedButton.dart';
import 'package:event_planning_3/ui/widgets/customTextFeild.dart';
import 'package:event_planning_3/ui/widgets/eventTapWidget.dart';
import 'package:event_planning_3/utils/AppColors.dart';
import 'package:event_planning_3/utils/AppStyle.dart';
import 'package:event_planning_3/utils/assets_Manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/eventListProvider.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = "add_event";

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
 int selectedIndex = 0;
 var formKey = GlobalKey<FormState>();
 var titleController = TextEditingController();
 var descriptionController = TextEditingController();
 String  formatedDate = "";
 DateTime? selectedDate;
 String  formatedTime = "";
 TimeOfDay? selectedTime;
 String selectedImage = "";
 String selectedEvent = "";
 late EventListProvider eventListProvider ;

 @override
  Widget build(BuildContext context) {
   eventListProvider = Provider.of<EventListProvider>(context);
    List<String> eventNameList = [
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
    List<String> imagesList = [
      AssetsManager.sportImage,
      AssetsManager.meetingImage,
      AssetsManager.eatingImage,
      AssetsManager.exhibitionImage,
      AssetsManager.bookClubImage,
      AssetsManager.holidayImage,
      AssetsManager.gamingImage,
      AssetsManager.birthdayImage,
      AssetsManager.workShopImage,
    ];
    selectedImage = imagesList[selectedIndex];
    selectedEvent = eventNameList[selectedIndex];
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.primaryLight
        ),
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.create_event,style: AppStyle.Mediam20primary,),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.02,
        vertical: height*0.01
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(fit: BoxFit.fill,
                  imagesList[selectedIndex]),
            ),
            SizedBox(height: height*0.015,),
            SizedBox(
              height: height*0.05,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    selectedIndex = index;
                    setState(() {
                    });
                  },
                  child: EventTapWidget(
                    borderUnSelectedColor: AppColors.primaryLight,
                    borderSelectedColor: AppColors.whiteColor,
                    selectedStyle: AppStyle.Mediam16white,
                    unSelectedStyle: AppStyle.Mediam16primary,
                    backgroundColor: AppColors.primaryLight,
                      eventName: eventNameList[index],
                      isSelected: selectedIndex== index ),
                );
              },
                  separatorBuilder: (context,index){return
                SizedBox(width: width*0.02,);
                  },
                  itemCount: eventNameList.length),
            ),
            SizedBox(height: height*0.015,),
           Form(
               key: formKey,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: [
             Text(AppLocalizations.of(context)!.title,style: AppStyle.Mediam16black,),
             SizedBox(height: height*0.015,),
             CustomTextField(
               controller: titleController,
               validator: (text){
                 if(text== null || text.isEmpty){
                   return AppLocalizations.of(context)!.please_enter_event_title;
                 }
                 return null;
               },
               prefixIcon: Icon(Icons.edit),
               hintText: AppLocalizations.of(context)!.event_title,
             ),
             SizedBox(height: height*0.015,),
             Text(AppLocalizations.of(context)!.description,style: AppStyle.Mediam16black,),
             SizedBox(height: height*0.015,),
             CustomTextField(
               controller: descriptionController,
               validator: (text){
                 if(text== null || text.isEmpty){
                   return AppLocalizations.of(context)!.please_enter_event_description;
                 }
                 return null;
               },
               obscureText: false,
               maxLines: 4,
               hintText: AppLocalizations.of(context)!.event_description,
             ),
             SizedBox(height: height*0.015,),
             EventDateOrTime(iconName: AssetsManager.dateIcon,
               chooseDateOrTimeClicked: chooseDate,
               chooseDateOrTime: selectedDate== null? AppLocalizations.of(context)!.choose_date:
               DateFormat("dd/MM/yyyy").format(selectedDate!),
               eventDateOrTime:  AppLocalizations.of(context)!.event_date
               ,),
             EventDateOrTime(iconName: AssetsManager.timeIcon,
               chooseDateOrTimeClicked: chooseTime,
               chooseDateOrTime: selectedTime == null? AppLocalizations.of(context)!.choose_time:
               formatedTime,
               eventDateOrTime:  AppLocalizations.of(context)!.event_time,),
             SizedBox(height: height*0.015,),
             Text(AppLocalizations.of(context)!.location,style: AppStyle.Mediam16black,),
             SizedBox(height: height*0.015,),
             Container(decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(16),
                 border: Border.all(
                     color: AppColors.primaryLight
                 )
             ),
               padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.02),
               child: Row(children: [
                 Container(
                   decoration: BoxDecoration(
                     color: AppColors.primaryLight,
                     borderRadius: BorderRadius.circular(16),
                   ),
                   padding: EdgeInsets.symmetric(vertical: height*0.015,horizontal: width*0.03),
                   child: Icon(Icons.my_location,color: AppColors.whiteColor,
                     size: 30,
                   ),),
                 SizedBox(width: width*0.02,),
                 Text(AppLocalizations.of(context)!.choose_event_location,style:
                 AppStyle.Mediam16primary
                   ,),
                 Spacer(),
                 IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_rounded,
                   color: AppColors.primaryLight,
                   size: 20,
                 ))
               ],),
             ),
             SizedBox(height: height*0.02,),
             CustomElevatedButton(onButtonClick: (){
               addEvent();
             },
                 text: AppLocalizations.of(context)!.add_event)
           ],))

            ],),
        ),
      ),
    );
  }

 void chooseDate() async{
   var chooseDate = await showDatePicker(context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime.now(),
       lastDate: DateTime.now().add(Duration(days: 365)));
   setState(() {
     selectedDate = chooseDate;
     formatedDate = DateFormat("dd/MM/yyyy").format(selectedDate!);
   });
  }

 void chooseTime()async {
   var chooseTime = await showTimePicker(context: context,
       initialTime: TimeOfDay.now());
   selectedTime = chooseTime;
   formatedTime = selectedTime!.format(context);
   setState(() {

   });
  }

  void addEvent() {
   if(formKey.currentState?.validate()== true){
     Event event = Event(title: titleController.text,
         description: descriptionController.text,
         eventName: selectedEvent,
         image: selectedImage,
         time: formatedTime,
         dateTime: selectedDate!);
     FirebaseUtils.addEventToFireStore(event).timeout(Duration(milliseconds: 600),
     onTimeout: (){
       print("event added successfully");
       eventListProvider.getAllEvents();
       Navigator.pop(context);
     }
     );
   }
  }
}
