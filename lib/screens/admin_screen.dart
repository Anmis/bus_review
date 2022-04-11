import 'package:bus_review/screens/bus_screen.dart';
import 'package:bus_review/screens/driver_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      // print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      buildBackgroundImage(),
      Center(
        child: SizedBox(
          height: 500,
          width: 300,
          child: Column(
            children: [
              buildButton("assets/driver.jpg", "Driver Reviews", "driver"),
              buildButton("assets/bus.jpg", "Bus Reviews", "bus")
            ],
          ),
        ),
      ),
    ]));
  }

  buildBackgroundImage() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.3), BlendMode.dstATop),
              image: const AssetImage("assets/bus.png"))),
    );
  }

  buildButton(imgPath, buttonName, dbName) {
    return GestureDetector(
      onTap: () {
        if (dbName == "driver") {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const DriverScreen();
            },
          ));
        } else {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const BusScreen();
            },
          ));
        }
      },
      child: Container(
        height: 200,
        width: 300,
        margin: const EdgeInsets.all(10),
        child: Stack(
          children: [
            //driver ellipse
            buildImage(imgPath),
            buildText(buttonName)
          ],
        ),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 4,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
      ),
    );
  }

  buildImage(imgPath) {
    return Container(
      height: 70,
      width: 70,
      decoration:
          BoxDecoration(image: DecorationImage(image: AssetImage(imgPath))),
    );
  }

  buildText(buttonName) {
    return Center(
      child: Text(
        buttonName,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }
}
