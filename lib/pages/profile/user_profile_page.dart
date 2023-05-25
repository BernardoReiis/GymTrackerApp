import '../../models/user.dart';
import '../../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfilePage extends StatelessWidget {
  final UserData userData;
  const UserProfilePage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(191, 76, 76, 1),
      ),
      body: ProfileBodyGT(userData: userData),
    );
  }
}

class ProfileBodyGT extends StatelessWidget {
  final UserData userData;
  ProfileBodyGT({super.key, required this.userData});
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Image.asset("images/profile-photo-big.png")),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              userData.username,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFBF4C4C),
                fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
              child: const Text(
                "Log Out",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
