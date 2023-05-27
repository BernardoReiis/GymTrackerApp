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
    var gender = "";
    IconData? iconGender = null;
    if (userData.gender == "M") {
      gender = "Male";
      iconGender = Icons.male;
    } else {
      gender = "Female";
      iconGender = Icons.female;
    }
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
          emailBox(userData),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            paramBox("${userData.height.toString()} cm", Icons.height),
            paramBox("${userData.weight.toString()} kg", Icons.monitor_weight)
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            paramBox("${userData.age.toString()} years", Icons.access_time),
            paramBox("${gender}", iconGender)
          ]),
          logOutButton(context, _auth),
        ],
      ),
    );
  }
}

Widget emailBox(UserData userData) {
  return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 3), // changes position of shadow
            )
          ],
          border: Border.all(
              color: const Color.fromRGBO(116, 116, 116, 1), width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      margin: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.email)),
          Container(
              padding: const EdgeInsets.all(10),
              child: Text(userData.email, style: const TextStyle(fontSize: 20)))
        ],
      ));
}

Widget paramBox(String info, IconData icon) {
  return Expanded(
    flex: 2,
    child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3), // changes position of shadow
              )
            ],
            border: Border.all(
                color: const Color.fromRGBO(116, 116, 116, 1), width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        margin: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(padding: const EdgeInsets.all(10), child: Icon(icon)),
            Container(
                padding: const EdgeInsets.all(10),
                child: Text(info, style: const TextStyle(fontSize: 20)))
          ],
        )),
  );
}

Widget logOutButton(BuildContext context, AuthService auth) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFFBF4C4C),
        fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
      ),
      onPressed: () async {
        await auth.signOut();
      },
      child: const Text(
        "Log Out",
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
      ),
    ),
  );
}
