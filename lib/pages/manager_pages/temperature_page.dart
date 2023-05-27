import 'package:gymtracker/models/temperature.dart';

import '../../models/user.dart';
import '../../services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/database.dart';

List<Widget> airCon = <Widget>[
  Row(children: const [Icon(Icons.air), Text('OFF')]),
  Row(children: const [Icon(Icons.air), Text('ON')]),
];

class ManagerTemperaturePage extends StatefulWidget {
  final UserData userData;
  const ManagerTemperaturePage({super.key, required this.userData});

  @override
  State<ManagerTemperaturePage> createState() => _ManagerTemperaturePageState();
}

class _ManagerTemperaturePageState extends State<ManagerTemperaturePage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TemperatureData>?>.value(
        initialData: null,
        value: DatabaseService(uid: widget.userData.uid).temperatureDataLatest,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Gym Temperature"),
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(191, 76, 76, 1),
            ),
            body: const TempListlast()));
  }
}

class TempListlast extends StatefulWidget {
  const TempListlast({super.key});

  @override
  State<TempListlast> createState() => _TempListlastState();
}

class _TempListlastState extends State<TempListlast> {
  final List<bool> _selectedFruits = <bool>[true, false];
  @override
  Widget build(BuildContext context) {
    final temperatureData = Provider.of<List<TemperatureData>?>(context);

    if (temperatureData == null) {
      return Column(children: [
        tempNow("0.0"),
      ]);
    } else {
      TemperatureData lastTemp = temperatureData.first;
      return Column(children: [
        tempNow(lastTemp.temperature.toStringAsFixed(1)),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: ToggleButtons(
            borderWidth: 0,
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            direction: Axis.horizontal,
            disabledColor: const Color.fromRGBO(241, 241, 241, 1),
            onPressed: (int index) {
              setState(() {
                // The button that is tapped is set to true, and the others to false.
                for (int i = 0; i < _selectedFruits.length; i++) {
                  _selectedFruits[i] = i == index;
                }
              });
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedBorderColor: const Color(0xFFBF4C4C),
            selectedColor: Colors.white,
            fillColor: const Color(0xFFBF4C4C),
            color: Colors.black,
            constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.7 / 2),
            isSelected: _selectedFruits,
            children: airCon,
          ),
        ),
        Column(
          children: temperatureData.map((e) {
            return cardTemperature(e);
          }).toList(),
        )
      ]);
    }
  }
}

Widget tempNow(String temperature) {
  return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            )
          ],
          border: Border.all(
              color: const Color.fromRGBO(116, 116, 116, 1), width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      margin: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset("images/temperature.png")),
          Container(
              padding: const EdgeInsets.all(10),
              child:
                  Text("$temperature ºC", style: const TextStyle(fontSize: 40)))
        ],
      ));
}

Widget cardTemperature(TemperatureData temperature) {
  final now = DateTime.now().millisecondsSinceEpoch / 10e2;
  var time_show = (now - temperature.dataTime) ~/ 60;
  return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(217, 217, 217, 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  child: const Icon(Icons.thermostat)),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                      "${temperature.temperature.toStringAsFixed(1)} ºC",
                      style: const TextStyle(fontSize: 16))),
            ],
          ),
          Container(
              padding: const EdgeInsets.all(10),
              child: Text("Há $time_show mins",
                  style: const TextStyle(fontSize: 16)))
        ],
      ));
}
