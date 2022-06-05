import 'package:emotion_detector/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

class Item {
  final String title;
  final Color color;
  final IconData iconData;
  final String path;

  Item(
      {required this.title,
      required this.color,
      required this.iconData,
      required this.path});

  static List<Item> homeMenuItems() {
    return [
      Item(
          title: 'Mood',
          color: Colors.deepPurpleAccent,
          iconData: Icons.face,
          path: Routes.MOOD),
      Item(
          title: 'Learning',
          color: Colors.orangeAccent,
          iconData: Icons.gamepad,
          path: Routes.LEARN),
      Item(
          title: 'Text to Speech',
          color: Colors.lightBlueAccent,
          iconData: Icons.volume_up,
          path: Routes.TTS),
      Item(
          title: 'Settings',
          color: Colors.lightGreenAccent,
          iconData: Icons.settings,
          path: Routes.SETTINGS),
    ];
  }
}
