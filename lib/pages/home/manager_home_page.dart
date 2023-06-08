import '../../models/fingerprint.dart';
import '../../models/temperature.dart';
import '../../models/user.dart';
import '../../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../services/database.dart';

class ManagerHomePage extends StatefulWidget {
  final UserData userData;
  const ManagerHomePage({super.key, required this.userData});

  @override
  State<ManagerHomePage> createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarGT(userData: widget.userData),
          UsersInGym(userData: widget.userData),
        ],
      ),
    );
  }
}

class UsersInGym extends StatelessWidget {
  final UserData userData;
  const UsersInGym({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    List<UserData> allusers = [];
    List<FingerPrintData> allfingers = [];
    List<Widget> widgetList = [];
    return StreamBuilder<List<UserData>>(
        stream: DatabaseService(uid: userData.uid).allUsersData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            allusers = snapshot.data!;
          }
          return StreamBuilder<List<FingerPrintData>>(
              stream:
                  DatabaseService(uid: userData.uid).allFingerprintsForStats(),
              builder: (context, snapshot) {
                widgetList = [];
                if (snapshot.hasData) {
                  allfingers = snapshot.data!;
                  for (int i = 0; i < allusers.length; i++) {
                    if (allusers[i].isManager == false &&
                        allusers[i].fingerprintId != -1) {
                      int counter = 0;
                      for (int j = 0; j < allfingers.length; j++) {
                        if (allusers[i].fingerprintId ==
                            allfingers[j].fingerPrintId) {
                          counter++;
                        }
                      }
                      if (counter % 2 != 0) {
                        widgetList.add(usersShow(allusers[i]));
                      }
                    }
                  }
                }
                if (widgetList.isEmpty) {
                  return Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints.expand(
                          height: MediaQuery.of(context).size.height * 0.4),
                      child: const Text(
                        "No one is in the gym",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ));
                }
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        "Users in the gym",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: widgetList,
                      ),
                    ),
                  ],
                );
              });
        });
  }
}

Widget usersShow(UserData userd) {
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
              child:
                  Text(userd.username, style: const TextStyle(fontSize: 20))),
        ],
      ));
}

class AppBarGT extends StatelessWidget {
  final UserData userData;
  const AppBarGT({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<TemperatureData?>.value(
      initialData: null,
      value: DatabaseService(uid: userData.uid).temperatureShowManagerHome,
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(191, 76, 76, 1),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height * 0.35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            managerProfileGT(userData),
            IconsStatsGT(userData: userData),
          ],
        ),
      ),
    );
  }
}

Widget managerProfileGT(UserData userData) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      managerNameGT(userData),
      Image.asset('images/manager-photo.png')
    ],
  );
}

Widget managerNameGT(UserData userData) {
  final now = DateTime.now();
  String timeGT = DateFormat('yMMMEd').format(now);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        timeGT,
        style: const TextStyle(
            fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),
      ),
      Text(
        "Hello ${userData.username}",
        style: const TextStyle(
            fontSize: 27, color: Colors.white, fontWeight: FontWeight.w400),
      ),
    ],
  );
}

class IconsStatsGT extends StatelessWidget {
  final UserData userData;
  const IconsStatsGT({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final temperatureToShow = Provider.of<TemperatureData?>(context);
    List<UserData> allusers = [];
    List<FingerPrintData> allfingers = [];
    int totalMembers = 0;
    int trainingMembers = 0;
    return StreamBuilder<List<UserData>>(
        stream: DatabaseService(uid: userData.uid).allUsersData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            allusers = snapshot.data!;
          }
          return Container(
            child: StreamBuilder<List<FingerPrintData>>(
                stream: DatabaseService(uid: userData.uid)
                    .allFingerprintsForStats(),
                builder: (context, snapshot) {
                  int totalMembers = 0;
                  int trainingMembers = 0;
                  if (snapshot.hasData) {
                    allfingers = snapshot.data!;
                    for (int i = 0; i < allusers.length; i++) {
                      if (allusers[i].isManager == false &&
                          allusers[i].fingerprintId != -1) {
                        totalMembers++;
                        int counter = 0;
                        for (int j = 0; j < allfingers.length; j++) {
                          if (allusers[i].fingerprintId ==
                              allfingers[j].fingerPrintId) {
                            counter++;
                          }
                        }
                        if (counter % 2 != 0) {
                          trainingMembers++;
                        }
                      }
                    }
                  }
                  return Container(
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 254, 254, 0.95),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      constraints: BoxConstraints.expand(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.85),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          iconStat("images/people-group.png", "Total Members",
                              totalMembers.toString()),
                          iconStat(
                              "images/thermometer-icon.png",
                              "Rooms \nTemperature",
                              temperatureValue(temperatureToShow)),
                          iconStat("images/zumba-icon.png", "Members Training",
                              trainingMembers.toString())
                        ],
                      ));
                }),
          );
        });
  }
}

String temperatureValue(TemperatureData? temperatureToShow) {
  if (temperatureToShow == null) {
    return "0.0";
  } else {
    return temperatureToShow.temperature.toStringAsFixed(1);
  }
}

Widget iconStat(String iconName, String textDefault, String textNumber) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(191, 76, 76, 1),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Image.asset(iconName)),
      Text(
        textNumber,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 10, color: Colors.black, fontWeight: FontWeight.w900),
      ),
      Text(
        textDefault,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 10, color: Colors.black, fontWeight: FontWeight.w500),
      ),
    ],
  );
}
