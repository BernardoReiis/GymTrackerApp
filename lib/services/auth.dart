// ignore_for_file: avoid_print

import 'package:gymtracker/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserGT? _userFromFirebaseUser(User? user) {
    return user != null ? UserGT(uid: user.uid) : null;
  }

  Stream<UserGT?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  Future registerWithEmailAndPassword(
      String email,
      String password,
      String username,
      String weight,
      String height,
      String age,
      List<bool> genderList) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      String gender = genderList[0] ? "M" : "F";
      await DatabaseService(uid: user!.uid).updateUserData(username,
          double.parse(weight), double.parse(height), int.parse(age), gender);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(" ------- registerWithEmailAndPassword ---------");
      print(e.toString());
      print("----------");
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(" ------- signInWithEmailAndPassword ---------");
      print(error.toString());
      print("----------");
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
