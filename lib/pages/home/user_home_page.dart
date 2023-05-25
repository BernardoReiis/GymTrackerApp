import '../../models/user.dart';
import '../../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserHomePage extends StatefulWidget {
  final UserData userData;
  const UserHomePage({super.key, required this.userData});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBarGT(userData: widget.userData),
    );
  }
}

class AppBarGT extends StatelessWidget {
  final UserData userData;
  const AppBarGT({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          UserProfileGT(userData: userData),
          const IconsStatsGT(),
        ],
      ),
    );
  }
}

class UserProfileGT extends StatelessWidget {
  final UserData userData;
  const UserProfileGT({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        UserNameGT(userData: userData),
        Image.asset('images/profile-photo.png')
      ],
    );
  }
}

class UserNameGT extends StatelessWidget {
  final UserData userData;
  UserNameGT({super.key, required this.userData});
  final now = DateTime.now();
  @override
  Widget build(BuildContext context) {
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
}

class IconsStatsGT extends StatelessWidget {
  const IconsStatsGT({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 254, 254, 0.95),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.85),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            IconStat(
              iconName: "images/calendar-icon.png",
              textDefault: "Times Per Week",
              textNumber: "3",
            ),
            IconStat(
              iconName: "images/stopwatch-icon.png",
              textDefault: "Avg. Training \nTime",
              textNumber: "3",
            ),
            IconStat(
              iconName: "images/zumba-icon.png",
              textDefault: "Group Classes \n Per Week",
              textNumber: "3",
            )
          ],
        ));
  }
}

class IconStat extends StatelessWidget {
  final String iconName;
  final String textDefault;
  final String textNumber;

  const IconStat(
      {super.key,
      required this.iconName,
      required this.textDefault,
      required this.textNumber});

  @override
  Widget build(BuildContext context) {
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
              fontSize: 10, color: Colors.black, fontWeight: FontWeight.w500),
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
}
