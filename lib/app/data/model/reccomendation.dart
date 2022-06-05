import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecommendationModel{
  Map<String, String> stories;
  Map<String, String> motivationalSpeeches;
  List<Map<String, String>> games;
  List<Map<String, int>> songFIle;

  RecommendationModel(
      {this.stories,
      this.motivationalSpeeches,
      this.games,
      this.songFIle});

  factory UserModel.fromFireStore(DocumentSnapshot snapshot){
    Map data = snapshot.data;
    return RecommendationModel(
      stories: data['stories'],
      motivationalSpeeches:  data['motivationalSpeeches'],
      games: data['games'],
      songFIle: data['songFIle'],
    );
  }
}
