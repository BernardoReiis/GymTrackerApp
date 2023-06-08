import '../../models/fingerprint.dart';
import '../../models/user.dart';
import '../../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/database.dart';
import 'fingerprint_page.dart';

class ManagerEntriesPage extends StatelessWidget {
  final UserData userData;
  const ManagerEntriesPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [addNewUserButton(context)];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gym Entries"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(191, 76, 76, 1),
      ),
      body: StreamBuilder<List<UserData>>(
          stream: DatabaseService(uid: userData.uid).allUsersData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<UserData> alltrainings = snapshot.data!;
              if (alltrainings.isNotEmpty) {
                widgetList = groupTrainingData(alltrainings, context);
              }
            }
            return SingleChildScrollView(child: Column(children: widgetList));
          }),
    );
  }
}

List<Widget> groupTrainingData(List<UserData> allusers, BuildContext context) {
  List<Widget> result = [addNewUserButton(context)];
  for (int i = 0; i < allusers.length; i = i + 2) {
    UserData userInfo = allusers[i];
    if (userInfo.isManager == false && userInfo.fingerprintId != -1) {
      result.add(usersShow(userInfo));
    }
  }
  return result;
}

Widget usersShow(UserData userd) {
  bool inGym = false;
  return StreamBuilder<List<FingerPrintData>>(
      stream: DatabaseService(uid: userd.uid)
          .fingerprintsForStats(userd.fingerprintId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length % 2 != 0) {
            inGym = true;
          }
        }
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
                    child: Text(userd.username,
                        style: const TextStyle(fontSize: 20))),
                userInGym(inGym)
              ],
            ));
      });
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
  void showSettingsPanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        });
  }

  return Container(
    padding: const EdgeInsets.all(10),
    child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color.fromRGBO(205, 205, 205, 1),
        fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
      ),
      onPressed: () => showSettingsPanel(),
      child: const Text(
        "Add new user",
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400),
      ),
    ),
  );
}
