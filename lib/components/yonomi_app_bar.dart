import 'package:flutter/material.dart';
import 'package:yonomi_flutter_demo/themes/app_themes.dart';
import 'package:yonomi_flutter_demo/themes/color_constants.dart';

class YonomiAppBar extends AppBar {
  YonomiAppBar(this.titleString, {this.notification = false, this.onPressed})
      : super(title: Text(titleString), centerTitle: false, actions: [
          Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.only(right: 16),
              width: 40.0,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: IconButton(
                      iconSize: 28,
                      color: AppThemes.appBarAlertIconColor,
                      icon: Icon(Icons.notifications),
                      onPressed: onPressed,
                    ),
                  ),
                  if (notification)
                    Positioned(
                      bottom: 12,
                      left: 26,
                      child: Icon(Icons.circle,
                          color: ColorConstants.redAlert, size: 15),
                    ),
                ],
              )),
        ]);

  final String titleString;
  final bool notification;
  final Function() onPressed;
}
