import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    final user =  Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Row(
            children: [
              RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${user.username}\n",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: user.email,
                          style: TextStyle(
                              fontSize: 12,
                              height: 1.5
                          ),
                        )
                      ]
                  )),
              Spacer(),
              Text(
                user.phone,
                style: TextStyle(
                  fontSize: 12,
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
