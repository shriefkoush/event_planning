import 'package:event_planning_3/ui/addEventScreen.dart';
import 'package:event_planning_3/ui/homeScreen/Taps/favoriteTap/favoriteTap.dart';
import 'package:event_planning_3/ui/homeScreen/Taps/homeTap/homeTap.dart';
import 'package:event_planning_3/ui/homeScreen/Taps/profileTap/profileTap.dart';
import 'package:flutter/material.dart';

import '../../core/utils/AppColors.dart';
import '../../core/utils/assets_Manager.dart';
import '../../l10n/app_localizations.dart';
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
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.whiteColor,
            unselectedItemColor: AppColors.whiteColor,
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
            width: 4,
            color: AppColors.whiteColor
          ),
        ),
        onPressed: (){
          Navigator.pushNamed(context, AddEventScreen.routeName);
        },
      backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add,size: 30,color: AppColors.whiteColor,
      ),
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
