import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';


class MoodController extends GetxController {
  String? faceAtMoment = 'normal_face.png';
  String label = '';
  String? confidence = '0';
  File? imageFile;
  late AnimationController animationController;
  bool animationStopped = false;
  bool scanning = false;
  late List<RecommendationModel> reccomendations;

  MoodController() {
    loadModel();
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model.tflite", labels: "assets/labels.txt");
  }

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final file = await ImagePicker().getImage(source: imageSource);
      if (file != null) {
        imageFile = File(file.path);
        processImage();
      }
      update();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> scanImage() async {
    label = '';
    animateScanAnimation(false);
    animationStopped = false;
    update();
    await Future.delayed(const Duration(seconds: 3));
    animationStopped = true;
    update();
  }

  void processImage() async {
    await scanImage();
    bool faceDetected = await detectFace();
    if (faceDetected) {
      var predictions = await Tflite.runModelOnImage(
        path: imageFile!.path,
        numResults: 2,
        threshold: 0.1,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      for (var element in predictions!) {
        label = element['label'];
        confidence =
            (element['confidence'] * 100).toString().substring(0, 2) + '%';
      }
    } else {
      label = 'No image detected';
      confidence = '0';
    }
    update();
  }

  Future<bool> detectFace() async {
    FaceDetector? _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
          enableClassification: true,
          enableLandmarks: true,
          performanceMode: FaceDetectorMode.accurate),
    );

    final faces = await _faceDetector
        .processImage(InputImage.fromFilePath(imageFile!.path));

    return faces.isEmpty ? false : true;
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      animationController.reverse(from: 1.0);
    } else {
      animationController.forward(from: 0.0);
    }
  }

  Future<void> getReccomendatios() async {
    List<RecommendationModel> list = await fireStoreService.getRecommendations(label);
    if (!areListsEqual(reccomendations, list)) {
      reccomendations = list;
    }
  }

  bool areListsEqual(List<RecommendationModel> list1, List<RecommendationModel> list2) {
    if (list1.length != list2.length) {
      return false;
    }
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }
    return true;
  }

}
