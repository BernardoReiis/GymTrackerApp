import '../../services/auth.dart';
import 'package:flutter/material.dart';

List<Widget> fruits = <Widget>[
  Row(children: const [Icon(Icons.male), Text('Male')]),
  Row(children: const [Icon(Icons.female), Text('Female')]),
];

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final List<bool> _selectedFruits = <bool>[true, false];
  String email = "";
  String username = "";
  String password = "";
  String age = "";
  String weight = "";
  String height = "";
  String errorMessage = "";

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 20),
                              child: const Text(
                                "Create an Account",
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              )),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(241, 241, 241, 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                )
                              ],
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  icon: Icon(Icons.email),
                                  fillColor: Color.fromRGBO(241, 241, 241, 1),
                                  labelText: "Email"),
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                              validator: (val) =>
                                  val!.isEmpty ? "Enter an email" : null,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  )
                                ],
                                color: const Color.fromRGBO(241, 241, 241, 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  icon: Icon(Icons.person),
                                  fillColor: Color.fromRGBO(241, 241, 241, 1),
                                  labelText: "Name"),
                              onChanged: (val) {
                                setState(() {
                                  username = val;
                                });
                              },
                              validator: (val) =>
                                  val!.isEmpty ? "Enter an Name" : null,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  )
                                ],
                                color: const Color.fromRGBO(241, 241, 241, 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  icon: Icon(Icons.password),
                                  fillColor: Color.fromRGBO(241, 241, 241, 1),
                                  labelText: "Password"),
                              obscureText: true,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                              validator: (val) =>
                                  val!.isEmpty ? "Enter an password" : null,
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: const Offset(0,
                                                1), // changes position of shadow
                                          )
                                        ],
                                        color: const Color.fromRGBO(
                                            241, 241, 241, 1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12))),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          fillColor:
                                              Color.fromRGBO(241, 241, 241, 1),
                                          labelText: "Weight"),
                                      onChanged: (val) {
                                        setState(() {
                                          weight = val;
                                        });
                                      },
                                      validator: (val) => val!.isEmpty
                                          ? "Enter an weight"
                                          : null,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 5, left: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: const Offset(0,
                                                1), // changes position of shadow
                                          )
                                        ],
                                        color: const Color.fromRGBO(
                                            241, 241, 241, 1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12))),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          fillColor:
                                              Color.fromRGBO(241, 241, 241, 1),
                                          labelText: "Height"),
                                      onChanged: (val) {
                                        setState(() {
                                          height = val;
                                        });
                                      },
                                      validator: (val) => val!.isEmpty
                                          ? "Enter an height"
                                          : null,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 20, left: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: const Offset(0,
                                                1), // changes position of shadow
                                          )
                                        ],
                                        color: const Color.fromRGBO(
                                            241, 241, 241, 1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12))),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          fillColor:
                                              Color.fromRGBO(241, 241, 241, 1),
                                          labelText: "Age"),
                                      onChanged: (val) {
                                        setState(() {
                                          age = val;
                                        });
                                      },
                                      validator: (val) =>
                                          val!.isEmpty ? "Enter an age" : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: ToggleButtons(
                              borderWidth: 1,
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                              direction: Axis.horizontal,
                              disabledColor:
                                  const Color.fromRGBO(241, 241, 241, 1),
                              onPressed: (int index) {
                                setState(() {
                                  // The button that is tapped is set to true, and the others to false.
                                  for (int i = 0;
                                      i < _selectedFruits.length;
                                      i++) {
                                    _selectedFruits[i] = i == index;
                                  }
                                });
                              },
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              selectedBorderColor: const Color(0xFFBF4C4C),
                              selectedColor: Colors.white,
                              fillColor: const Color(0xFFBF4C4C),
                              color: Colors.white,
                              constraints: BoxConstraints.expand(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width: MediaQuery.of(context).size.width *
                                      0.7 /
                                      2),
                              isSelected: _selectedFruits,
                              children: fruits,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 40),
                              child: TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email,
                                            password,
                                            username,
                                            weight,
                                            height,
                                            age,
                                            _selectedFruits);
                                    if (result == null) {
                                      setState(() {
                                        errorMessage =
                                            "Please supply a valid email";
                                      });
                                    }
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFBF4C4C),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.9,
                                      50),
                                ),
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              )),
                        ],
                      ),
                    )
                  ]))),
    );
  }
}
