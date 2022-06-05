import 'package:spiry/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationService{
  Future<UserModel> currentUser();
  Future<UserModel> createUserWithEmailAndPassword(String username, String email, String password);
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> signInWithGoogle();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
  Future<void> deleteUser();
  Stream<FirebaseUser> get onAuthStateChanged; //because we can only stream from a remote source
}