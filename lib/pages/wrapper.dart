import 'package:flutter/material.dart';
import 'package:gymtracker/pages/home/user_home_page.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import 'authenticate/enter_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserGT?>(context);
    if (user == null) {
      return const EnterPage();
    } else {
      return const UserHomePage();
    }
  }
}
