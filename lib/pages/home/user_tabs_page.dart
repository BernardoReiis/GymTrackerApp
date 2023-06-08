import 'package:gymtracker/models/user.dart';
import 'package:gymtracker/pages/home/user_home_page.dart';

import '../../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../profile/user_profile_page.dart';
import '../user_pages/stats_page.dart';

class UserTabsPage extends StatelessWidget {
  final UserData userData;
  const UserTabsPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              UserHomePage(userData: userData),
              UserStatsPage(userData: userData),
              UserProfilePage(userData: userData),
            ],
          ),
        ));
  }
}

Widget menu() {
  return Container(
    child: const TabBar(
      labelColor: Color.fromRGBO(191, 76, 76, 1),
      unselectedLabelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Color.fromRGBO(191, 76, 76, 1),
      tabs: [
        Tab(
          text: "Home",
          icon: Icon(Icons.home),
        ),
        Tab(
          text: "Stats",
          icon: Icon(Icons.query_stats),
        ),
        Tab(
          text: "Profile",
          icon: Icon(Icons.person),
        ),
      ],
    ),
  );
}
