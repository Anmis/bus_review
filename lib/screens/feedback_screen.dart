import 'package:bus_review/screens/thank_you_screen.dart';
import 'package:bus_review/widgets/feedback_screen_bus_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// ignore: must_be_immutable
class FeedbackScreen extends StatelessWidget {
  Barcode? barcode;
  FeedbackScreen({Key? key, Barcode? bar}) : super(key: key) {
    barcode = bar;
  }
  // ignore: prefer_typing_uninitialized_variables
  var context;
  var userInputData = {
    "pace": 4,
    "busInfra": 4,
    "busSears": "Yes",
    "driverBehaviour": 1,
    "remark": "",
    "overallRate": 4,
    "driverRate": 4
  };
  var data = [];

  @override
  Widget build(BuildContext context) {
    this.context = context;
    String? qrText = barcode?.code;

    if (qrText != null) data = qrText.split(",");
    return Scaffold(
        body: Stack(children: [
      buildBackGround("assets/form_back.jpg"),
      SingleChildScrollView(
          child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildDataContainer(data, context),
              buildQuestionsContainer(),
              buildSubmitButton()
            ],
          ),
        ],
      )),
    ]));
  }

//user form
  buildQuestionsContainer() {
    return Container(
        width: MediaQuery.of(context).size.width - 20,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4), blurRadius: 4, color: Colors.black26)
            ]),
        margin: const EdgeInsets.only(top: 70, left: 5, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildQuestion("How do you rate pace of the driver ?"),
            buildRating("pace"),
            buildQuestion("How much rating you give for driver?"),
            buildRating("driverRate"),
            buildQuestion("Rate bus infrastructure?"),
            buildRating("busInfra"),
            buildQuestion("Does the bus have enough seats?"),
            buildMultiOptions(
                "busSeats", context, ["Yes", "No"], ["Yes", "No"]),
            buildQuestion("How is driver’s behaviour?"),
            buildMultiOptions(
                "driverBehaviour", context, ["Good", "Bad"], [1, 0]),
            buildQuestion("Do you have any remarks?"),
            buildRemarkInputText("remark"),
            buildQuestion("Rate your overall journey?"),
            buildRating("overallRate")
          ],
        ));
  }

  buildQuestion(String question) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(question,
          textAlign: TextAlign.left,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
          )),
    );
  }

  buildRating(String s) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RatingBar.builder(
        initialRating: 4,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          userInputData[s] = rating;
        },
      ),
    );
  }

  buildMultiOptions(String s, BuildContext context, var labels, var values) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: CustomRadioButton(
        elevation: 1,
        absoluteZeroSpacing: false,
        unSelectedColor: Theme.of(context).canvasColor,
        buttonLables: labels,
        buttonValues: values,
        buttonTextStyle: const ButtonTextStyle(
            selectedColor: Colors.white,
            unSelectedColor: Colors.black,
            textStyle: TextStyle(fontSize: 16)),
        radioButtonValue: (value) {
          userInputData[s] = value!;
        },
        // ignore: deprecated_member_use
        selectedColor: Theme.of(context).accentColor,
      ),
    );
  }

  buildRemarkInputText(String s) {
    return TextField(
        autofocus: false,
        onChanged: (ss) {
          userInputData[s] = ss;
          print(ss);
        },
        decoration: const InputDecoration(
          labelText: "Write Your Remark Here!",
          //  focusedBorder: OutlineInputBorder(
          //           borderSide: BorderSide(color: Colors.greenAccent, width: 2.0),
          //       ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ));
  }

  /// Check If Document Exists
  Future<bool> checkIfDocExists(String docId, dbName) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection(dbName);

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  buildSubmitButton() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: style,
        onPressed: () async {
          // ignore: avoid_print
          print("Data is Available for Transmission");
          bool driverdocExists =
              await checkIfDocExists(data[1].toLowerCase(), "driver");
          print(driverdocExists.toString());
          bool busdocExits = await checkIfDocExists(data[0], "bus");
          if (driverdocExists) {
            userInputData.forEach((key, value) {
              FirebaseFirestore.instance
                  .collection("driver")
                  .doc(data[1].toLowerCase())
                  .update({
                "driverName": data[1].toLowerCase(),
                "reviews": FieldValue.arrayUnion([
                  {
                    "driverName": data[1].toLowerCase(),
                    "busNum": data[0],
                    "from": data[2],
                    "to": data[3],
                    "pace": userInputData["pace"],
                    "driverRate": userInputData["driverRate"],
                    "driverBehaviour": userInputData["driverBehaviour"],
                    "remark": userInputData["remark"],
                    "overallRate": userInputData["overallRate"]
                  }
                ])
              });
            });
          } else {
            userInputData.forEach((key, value) {
              FirebaseFirestore.instance
                  .collection("driver")
                  .doc(data[1].toLowerCase())
                  .set({
                "driverName": data[1].toLowerCase(),
                "reviews": [
                  {
                    "driverName": data[1].toLowerCase(),
                    "busNum": data[0],
                    "from": data[2],
                    "to": data[3],
                    "pace": userInputData["pace"],
                    "driverRate": userInputData["driverRate"],
                    "driverBehaviour": userInputData["driverBehaviour"],
                    "remark": userInputData["remark"],
                    "overallRate": userInputData["overallRate"]
                  }
                ]
              });
            });
          }
          if (busdocExits) {
            FirebaseFirestore.instance.collection("bus").doc(data[0]).update({
              "reviews": FieldValue.arrayUnion([
                {
                  "busNo": data[0],
                  "busInfra": userInputData["busInfra"],
                  "busSeats": userInputData["busSeats"]
                }
              ])
            });
          } else {
            FirebaseFirestore.instance.collection("bus").doc(data[0]).set({
              "reviews": [
                {
                  "busNo": data[0],
                  "busInfra": userInputData["busInfra"],
                  "busSeats": userInputData["busSeats"]
                }
              ]
            });
          }
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => ThankYouScreen()));
        },
        child: const Text('Submit'),
      ),
    );
  }

  buildBackGround(String assetPhoto) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(assetPhoto), fit: BoxFit.fill)),
    );
  }
}
