import 'package:emotion_detector/app/modules/learning/views/flash_cards.dart';
import 'package:emotion_detector/app/modules/learning/views/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/color_theme.dart';


class LearnView extends StatelessWidget {
  LearnView({Key? key}) : super(key: key);

  List<String> learningActivities = ['FLash Cards', 'Play Game'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn'),
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: learningActivities.map((e) => Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            height: 80,
            child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(primaryColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20)))),
                ),
                onPressed: () {
                  if(e == 'FLash Cards'){
                    Get.to(const FlashCard());
                  }else{
                    Get.to(const PlayGame());
                  }
                },
                child: Text(e,
                    style: const TextStyle(fontSize: 20.0))),
          )).toList(),
        ),
      ),
    );
  }
}
