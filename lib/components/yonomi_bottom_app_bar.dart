import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yonomi_flutter_demo/themes/app_themes.dart';

class YonomiBottomAppBar extends StatelessWidget {
  final ValueChanged<int> onTap;

  final int selectedIndex;

  YonomiBottomAppBar(
      {Key key, @required this.onTap, @required this.selectedIndex})
      : super(key: key);

  static Widget dotIcon = Icon(
    Icons.circle,
    size: 10,
  );

  static Widget homeIcon = SvgPicture.asset(
    'assets/icons/ic_home_unselected.svg',
    color: AppThemes.bottomAppBarUnselectedItemColor,
    semanticsLabel: "home",
  );

  static Widget devicesIcon = SvgPicture.asset(
    'assets/icons/ic_routines_unselected.svg',
    semanticsLabel: "devices",
  );

  static Widget settingsIcon = SvgPicture.asset(
    'assets/icons/ic_settings_unselected.svg',
    semanticsLabel: "settings",
  );

  static Widget homeUnselectedWidget = Column(
    children: [homeIcon, Text("HOME")],
  );

  static Widget homeSelectedWidget = Column(
    children: [
      Text("HOME"),
      SizedBox(
        height: 8.0,
      ),
      dotIcon
    ],
  );

  static Widget devicesUnselectedWidget = Column(
    children: [devicesIcon, Text("DEVICES")],
  );

  static Widget devicesSelectedWidget = Column(
    children: [
      Text("DEVICES"),
      SizedBox(
        height: 8.0,
      ),
      dotIcon
    ],
  );

  static Widget settingsUnselectedWidget = Column(
    children: [settingsIcon, Text("SETTINGS")],
  );

  static Widget settingsSelectedWidget = Column(
    children: [
      Text("SETTINGS"),
      SizedBox(
        height: 8.0,
      ),
      dotIcon
    ],
  );

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarItem homeItem = BottomNavigationBarItem(
      icon: homeUnselectedWidget,
      activeIcon: homeSelectedWidget,
      label: "Home",
    );

    BottomNavigationBarItem devicesItem = BottomNavigationBarItem(
      icon: devicesUnselectedWidget,
      activeIcon: devicesSelectedWidget,
      label: "Devices",
    );

    BottomNavigationBarItem accountsItem = BottomNavigationBarItem(
      icon: settingsUnselectedWidget,
      activeIcon: settingsSelectedWidget,
      label: "Settings",
    );

    return BottomAppBar(
        color: AppThemes.bottomAppBarBgColor,
        shape: AutomaticNotchedShape(
            RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),
        notchMargin: 10.0,
        child: Container(
          padding: EdgeInsets.only(right: 90.0),
          child: BottomNavigationBar(
              key: Key('bottomNavBar'),
              elevation: 0,
              selectedFontSize: 0,
              backgroundColor: Colors.transparent,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                homeItem,
                devicesItem,
                accountsItem,
              ],
              currentIndex: selectedIndex,
              unselectedItemColor: AppThemes.bottomAppBarUnselectedItemColor,
              selectedItemColor: AppThemes.bottomAppBarSelectedItemColor,
              onTap: onTap),
        ));
  }
}
