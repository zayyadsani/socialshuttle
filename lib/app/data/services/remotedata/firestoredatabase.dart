import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../../model/reccomendation.dart';
import '../../model/usermodel.dart';
import '../abstracts/databaseservice.dart';

class FireStoreService implements DatabaseService {
  final String userInformationCollection = "userinformation";
  final String pantryCollection = "reccomendations";


  CollectionReference _userInformationReference; //base
  CollectionReference _reccomendationsCollection;

  UserModel _user;

  void startFireStore(UserModel user) {
    _user = user;
    _userInformationReference =
        Firestore.instance.collection(userInformationCollection);
    _storageReference = FirebaseStorage.instance.ref();
  }


  @override
  Future<void> addUser(UserModel user) async {
    try {
      user.reminders = NotificationReminders.reminders();
      user.expiryNotification = true;
      await _userInformationReference
          .document(user.userID)
          .setData(user.toJson());
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Future<void> updateUser(Map<String,dynamic> userMap) async {
    try {
      await _userInformationReference
          .document(_user.userID)
          .updateData(userMap).catchError((err){print(err);});
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Future<void> editUsername(UserModel user, String newUsername) async {
    try {
      final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
        functionName: 'editUsername',
      );
      await callable.call(<String, dynamic>{
        'userID': user.userID,
        'oldUsername': user.username,
        'newUsername': newUsername
      });
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Future<void> removeUser() async {
    try {
      final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
        functionName: 'deleteUser',
      );
      await callable.call(<String, dynamic>{
        'userID': _user.userID,
      });
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Stream<UserModel> userStream() {
    return _userInformationReference
        .document(_user.userID)
        .snapshots()
        .map((doc) => UserModel.fromFireStore(doc));
  }

  @override
  Future<List<RecommendationModel>> getRecommendations(Mood mood) async {
    try {
      QuerySnapshot snapshot = await _recommendationCollection.getDocuments();
      return snapshot.documents
          .map((doc) => RecommendationModel.fromFireStore(doc))
          .toList().where((element) => element.type == mood.type).toList();

    }
