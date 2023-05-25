import '../../services/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String username = "";
  String password = "";

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

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
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 60),
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 20),
                      child: const Text(
                        "GymTracker",
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      )),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(217, 217, 217, 1),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 1))),
                          labelText: "Email"),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(217, 217, 217, 1),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 1))),
                          labelText: "Password"),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                    'Could not sign in with those credentials';
                              });
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFBF4C4C),
                          fixedSize:
                              Size(MediaQuery.of(context).size.width * 0.9, 50),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "or login with ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Image.asset("images/google-icon.png"))
                        ],
                      )),
                ],
              ))),
    );
  }
}