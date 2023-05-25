import 'package:gymtracker/pages/home/user_home_page.dart';

import '../../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../manager_pages/entries_page.dart';
import '../manager_pages/temperature_page.dart';
import '../profile/manager_profile_page.dart';
import 'manager_home_page.dart';

class ManagerTabsPage extends StatelessWidget {
  const ManagerTabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: menu(),
          body: const TabBarView(
            children: [
              ManagerHomePage(),
              ManagerTemperaturePage(),
              ManagerEntriesPage(),
              ManagerProfilePage(),
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
          text: "Temperature",
          icon: Icon(Icons.thermostat),
        ),
        Tab(
          text: "Entries",
          icon: Icon(Icons.door_sliding),
        ),
        Tab(
          text: "Profile",
          icon: Icon(Icons.person),
        ),
      ],
    ),
  );
}
