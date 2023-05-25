import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String username, double weight, double height, int age,
      String gender) async {
    return await userCollection.doc(uid).set({
      "username": username,
      "gender": gender,
      "age": age,
      "height": height,
      "weight": weight,
      "isManager": false,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot.get("username"),
      height: snapshot.get("height"),
      weight: snapshot.get("weight"),
      age: snapshot.get("age"),
      isManager: snapshot.get("isManager"),
    );
  }

  Stream<QuerySnapshot> get usersData {
    return userCollection.snapshots();
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
