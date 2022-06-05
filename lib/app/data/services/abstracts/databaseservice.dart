import '../../model/usermodel.dart';
import '../../model/reccomendation.dart';

abstract class DatabaseService {
  Future<void> addUser(UserModel user);//unique
  Future<void> updateUser(Map<String,dynamic> userMap);
  Future<void> editUsername(UserModel user, String newUsername);
  Future<void> removeUser();
  Stream<UserModel> userStream();
  Future<UserModel> getUser();

  Future<List<RecommendationModel>> getShoppingList();

}