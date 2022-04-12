import 'package:bus_review/screens/admin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AdminPin extends StatefulWidget {
  AdminPin({Key? key}) : super(key: key);

  @override
  State<AdminPin> createState() => _AdminPinState();
}

class _AdminPinState extends State<AdminPin> {
  var curText;
  var isValid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 400,
          child: Column(
            children: [
              (!isValid)
                  ? Container(
                      margin: EdgeInsets.all(15),
                      child: Text(
                        "Invalid Pin! Please Try Again",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(),
              const Text(
                "Enter Your Secret Pin!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.all(10),
                padding: const EdgeInsets.all(8.0),
                child: PinCodeTextField(
                  onCompleted: (value) {
                    var ref = FirebaseFirestore.instance
                        .collection("adminQr")
                        .doc("sunlight")
                        .get();
                    ref.then((val) {
                      var doc = val.data()?["qrcodepin"];
                      if (doc == value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminScreen()));
                      } else {
                        setState(() {
                          isValid = false;
                        });
                      }
                    });
                  },
                  length: 4,
                  animationType: AnimationType.fade,
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.white,
                  appContext: context,
                  onChanged: (String value) {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
