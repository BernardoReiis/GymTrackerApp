import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gymtracker/models/user.dart';
import 'package:gymtracker/pages/wrapper.dart';
import 'package:gymtracker/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserGT?>.value(
              initialData: null,
              value: AuthService().user,
              child: const MaterialApp(
                  home: Wrapper(), debugShowCheckedModeBanner: false));
        }
        throw "...";
      },
      future: Firebase.initializeApp(),
    );
  }
}
