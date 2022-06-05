import 'package:emotion_detector/app/modules/learning/views/learn_view.dart';
import 'package:emotion_detector/app/modules/mood/view/mood_view.dart';
import 'package:emotion_detector/app/modules/tts/view/tts_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/home/views/home_view.dart';


part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () =>  HomeView(),
    ),
    GetPage(
      name: _Paths.MOOD,
      page: () => const MoodView(),
    ),
    GetPage(
      name: _Paths.LEARN,
      page: () => LearnView(),
    ),
    GetPage(
      name: _Paths.TTS,
      page: () => TtsView(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const Scaffold(),
    )
  ];
}
