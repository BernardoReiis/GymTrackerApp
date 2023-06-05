import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_functions/cloud_functions.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  final HttpsCallable callable =
      FirebaseFunctions.instance.httpsCallable('registerFingerprintUser');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              const Text(
                'Register Fingerprint',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    icon: Icon(Icons.email),
                    fillColor: Color.fromRGBO(241, 241, 241, 1),
                    labelText: "Email"),
                validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => email = val),
              ),
            ],
          ),
          ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(191, 76, 76, 1),
                fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
              ),
              child: const Text(
                'Register',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await callable.call(<String, dynamic>{'email': email});
                }
              }),
        ],
      ),
    );
  }
}
