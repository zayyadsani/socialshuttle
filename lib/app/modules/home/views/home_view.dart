import 'package:emotion_detector/app/core/theme/color_theme.dart';
import 'package:emotion_detector/app/modules/home/model/item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final itemMenuList = Item.homeMenuItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(10),
          child: const CircleAvatar(
            backgroundColor: primaryColor,
            child: Text(
              'Z',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
      ),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, position) {
            return Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                    onTap: () {
                      Get.toNamed(itemMenuList[position].path);
                    },
                    child: Center(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                itemMenuList[position].iconData,
                                size: 80,
                                color: primaryColor,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                itemMenuList[position].title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )));
          },
          itemCount: itemMenuList.length,
        ),
      ),
    );
  }
}
