import 'package:flutter/material.dart';
import 'package:gymtracker/pages/home/user_home_page.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../services/database.dart';
import 'authenticate/enter_page.dart';
import 'home/manager_tabs_page.dart';
import 'home/user_tabs_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserGT?>(context);
    if (user == null) {
      return const EnterPage();
    } else {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      return StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData? userData = snapshot.data;
              if (userData!.isManager == true) {
                return ManagerTabsPage(userData: userData);
              } else {
                return UserTabsPage(userData: userData);
              }
            } else {
              return const EnterPage();
            }
          });
    }
  }
}
