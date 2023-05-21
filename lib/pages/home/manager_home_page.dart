import 'package:flutter/material.dart';

class ManagerHomePage extends StatelessWidget {
  const ManagerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GymTracker"),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/backgroud-login-image.png"),
          fit: BoxFit.cover,
        )),
        constraints: const BoxConstraints.expand(),
      ),
    );
  }
}
