import 'package:bus_review/screens/thank_you_screen.dart';
import 'package:bus_review/widgets/feedback_screen_bus_details.dart';
import 'package:bus_review/widgets/feedback_widgets/transfer_to_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// ignore: must_be_immutable
class FeedbackScreen extends StatefulWidget {
  Barcode? barcode;
  TextEditingController? txt;
  FeedbackScreen({Key? key, Barcode? bar}) : super(key: key) {
    barcode = bar;
    txt = TextEditingController();
  }

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

var context;

class _FeedbackScreenState extends State<FeedbackScreen> {
  // ignore: prefer_typing_uninitialized_variables

  var userInputData = {
    "pace": 4,
    "busInfra": 4,
    "busSeats": "Yes",
    "driverBehaviour": 1,
    "remark": "",
    "overallRate": 4,
    "driverRate": 4
  };

  var data = [];

  @override
  void dispose() {
    widget.txt?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    context = ctx;
    String? qrText = widget.barcode?.code;

    if (qrText != null) data = qrText.split(",");
    return (data.length == 6)
        ? Scaffold(
            body: Stack(children: [
            buildBackGround("assets/form_back.jpg"),
            // Container(
            //   color: Colors.pink[200],
            // ),
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
          ]))
        : const Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Invalid QR Code! Try With Valid One ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 48),
                ),
              ),
            ),
          );
  }

//user form
  buildQuestionsContainer() {
    return Center(
      child: Container(
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
              buildQuestion(
                  "How do you rate the speed of the driver ?\n(5-Good,3-Normal,1-Too Fast)"),
              buildRating("pace"),
              buildQuestion(
                  "Is the driver following traffic rules and the timings?"),
              buildRating("driverRate"),
              buildQuestion("Rate bus infrastructure & seat Condition?"),
              buildRating("busInfra"),
              buildQuestion(
                  "Does the driver allowing more passengers than available seats?"),
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
          )),
    );
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
        itemBuilder: (context, _) => Icon(Icons.star, color: Colors.pink[200]),
        onRatingUpdate: (rating) {
          userInputData[s] = rating;
        },
      ),
    );
  }

// YES, NO(SEATS) , GOOD, BAD(Behaviour)
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
        selectedColor: Colors.pink[100]!,
        enableShape: true,
      ),
    );
  }

  buildRemarkInputText(String s) {
    return TextField(
        autofocus: false,
        onChanged: (ss) {
          userInputData["remark"] = ss;
        },
        decoration: InputDecoration(
          labelText: "Write Your Remark Here!",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink[200]!, width: 2.0),
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
      rethrow;
    }
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      elevation: 3,
      primary: Colors.pink[200],
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10));

  buildSubmitButton() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: style,
        onPressed: () async {
          // ignore: avoid_print
          var collectionref = FirebaseFirestore.instance.collection('driver');
          var doc = await collectionref.doc(data[1].toLowerCase()).get();

          if (!doc.exists) {
            setDriver(userInputData, data);
          } else {
            updateDriver(userInputData, data);
          }

          bool busdocExits = await checkIfDocExists(data[0], "bus");

          if (busdocExits) {
            updateBus(userInputData, data);
          } else {
            SetBus(userInputData, data);
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

  void updateData() {}
}
