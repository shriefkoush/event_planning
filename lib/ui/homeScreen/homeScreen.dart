import 'package:event_planning_3/ui/addEventScreen.dart';
import 'package:event_planning_3/ui/homeScreen/Taps/favoriteTap/favoriteTap.dart';
import 'package:event_planning_3/ui/homeScreen/Taps/homeTap/homeTap.dart';
import 'package:event_planning_3/ui/homeScreen/Taps/profileTap/profileTap.dart';
import 'package:event_planning_3/utils/AppColors.dart';
import 'package:event_planning_3/utils/assets_Manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Taps/mapTap/mapTap.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 int selectedIndex = 0;
List<Widget> taps = [Hometap(),MapTap(),FavoriteTap(),ProfileTap()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.transparentColor
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(
          ),
          notchMargin: 4,
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index){
              selectedIndex = index;
              setState(() {

              });
            },
            items: [
            buildBottomNavBarItem(
              selectedImageName: AssetsManager.iconHomeSelected,
                index: 0,
                imageName: AssetsManager.iconHome,
                text: AppLocalizations.of(context)!.home),
            buildBottomNavBarItem(
                selectedImageName: AssetsManager.iconMapSelected,
                index: 1,
                imageName: AssetsManager.iconMap,
                text: AppLocalizations.of(context)!.map),
            buildBottomNavBarItem(
                selectedImageName: AssetsManager.iconFavoriteSelected,
                index: 2,
                imageName: AssetsManager.iconFavorite,
                text: AppLocalizations.of(context)!.favorite),
            buildBottomNavBarItem(
                selectedImageName: AssetsManager.iconProfileSelected,
                index: 3,
                imageName: AssetsManager.iconProfile,
                text: AppLocalizations.of(context)!.profile)
          ],),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
          side: BorderSide(
            width: 5,
            color: AppColors.whiteColor
          ),
        ),
        onPressed: (){
          Navigator.pushNamed(context, AddEventScreen.routeName);
        },
        child: Icon(Icons.add,size: 30,color: AppColors.whiteColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: taps[selectedIndex],

    );
  }

 BottomNavigationBarItem buildBottomNavBarItem({required String imageName,
   required String selectedImageName,
 required String text,required int index
 }){
    return BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(
      selectedIndex==index? selectedImageName: imageName
    )),label: text);
  }
}
