import 'dart:io';

import 'package:emotion_detector/app/core/theme/color_theme.dart';
import 'package:emotion_detector/app/core/widgets/scanner.dart';
import 'package:emotion_detector/app/modules/mood/controller/mood_controller.dart';
import 'package:emotion_detector/app/modules/mood/view/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MoodView extends StatefulWidget {
  const MoodView({Key? key}) : super(key: key);

  @override
  State<MoodView> createState() => _MoodViewState();
}

class _MoodViewState extends State<MoodView>
    with SingleTickerProviderStateMixin {
  final _moodController = Get.put(MoodController());

  @override
  void initState() {
    _moodController.animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _moodController.animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _moodController.animateScanAnimation(true);
      } else if (status == AnimationStatus.dismissed) {
        _moodController.animateScanAnimation(false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _moodController.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mood'),
          backgroundColor: Colors.white,
          foregroundColor: primaryColor,
          elevation: 0,
        ),
        body: GetBuilder<MoodController>(
          init: _moodController,
          builder: (controller) => Column(
            children: [
              _buildButtons(),
              const SizedBox(
                height: 24,
              ),
              Expanded(child: Center(child: _buildImage())),
              const SizedBox(
                height: 24,
              ),
              Container(
                height: 80,
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: controller.label.isEmpty ||
                        controller.label == 'No image detected'
                    ? const SizedBox()
                    : TextButton(
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
                          Get.to(const Suggestion());
                        },
                        child: const Text("Suggestions",
                            style: TextStyle(fontSize: 20.0))),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ));
  }

  Widget _buildImage() {
    if (_moodController.imageFile != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                  height: 300,
                  width: 300,
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(color: Colors.black, width: 4),
                    ),
                    child: Image.file(File(_moodController.imageFile!.path)),
                  )),
              ImageScannerAnimation(
                _moodController.animationStopped,
                300,
                animation: _moodController.animationController,
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          _moodController.label.isNotEmpty
              ? Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.black45,
                  alignment: Alignment.center,
                  child: Text(
                    _moodController.label.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                )
              : const SizedBox()
        ],
      );
    } else {
      return const Text('Take an image to start',
          style: TextStyle(fontSize: 18.0));
    }
  }

  Widget _buildButtons() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        constraints: const BoxConstraints.expand(height: 80.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildActionButton(
                key: const Key('retake'),
                text: 'Photos',
                onPressed: () =>
                    _moodController.captureImage(ImageSource.gallery),
              ),
              const Spacer(),
              _buildActionButton(
                key: const Key('upload'),
                text: 'Camera',
                onPressed: () =>
                    _moodController.captureImage(ImageSource.camera),
              ),
            ]));
  }

  Widget _buildActionButton(
      {required Key key, required String text, required Function onPressed}) {
    return IconButton(
        onPressed: () async {
          await onPressed();
        },
        icon: Icon(
          text == 'Camera' ? Icons.camera_alt_rounded : Icons.image,
          size: 60,
          color: primaryColor,
        ));
  }
}
