import 'package:flutter/material.dart';
import 'package:gymtracker/pages/authenticate/login_page.dart';
import 'package:gymtracker/pages/authenticate/register_page.dart';

class EnterPage extends StatelessWidget {
  const EnterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/backgroud-login-image.png"),
            fit: BoxFit.cover,
          )),
          constraints: const BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 60),
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: const Text(
                    "GymTracker",
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  )),
              const EnterPageButtons()
            ],
          )),
    );
  }
}

class EnterPageButtons extends StatelessWidget {
  const EnterPageButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: const Text(
                "Manage and take care of your gym like no other app can",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(
                    left: 10, top: 20, bottom: 10, right: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFBF4C4C),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.9, 50),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                )),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFD9D9D9),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.9, 50),
                  ),
                  child: const Text(
                    "I already have an account",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF383838),
                        fontWeight: FontWeight.w400),
                  ),
                ))
          ],
        ));
  }
}
