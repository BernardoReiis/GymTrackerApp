import '../../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerEntriesPage extends StatelessWidget {
  const ManagerEntriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gym Entries"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(191, 76, 76, 1),
      ),
      body: Column(children: [
        addNewUserButton(context),
        usersShow(true),
        usersShow(true),
        usersShow(false),
        usersShow(false),
      ]),
    );
  }
}

Widget usersShow(bool inGym) {
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
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                "images/profile-photo.png",
                scale: 1.7,
              )),
          Container(
              padding: const EdgeInsets.all(10),
              child: Text("Antonio", style: const TextStyle(fontSize: 20))),
          userInGym(inGym)
        ],
      ));
}

Widget userInGym(bool inGym) {
  if (inGym) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: const Icon(Icons.check, color: Colors.green));
  } else {
    return Container(
        padding: const EdgeInsets.all(10),
        child: const Icon(Icons.close, color: Colors.red));
  }
}

Widget addNewUserButton(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(10),
    child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color.fromRGBO(205, 205, 205, 1),
        fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
      ),
      onPressed: () async {},
      child: const Text(
        "Add new user",
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),
      ),
    ),
  );
}
