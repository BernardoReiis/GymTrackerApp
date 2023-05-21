import 'package:cloud_firestore/cloud_firestore.dart';

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
    });
  }

  Stream<QuerySnapshot> get usersData {
    return userCollection.snapshots();
  }
}
