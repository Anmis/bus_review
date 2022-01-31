import 'package:bus_review/screens/thank_you_screen.dart';
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
  var userInputData = {};
  @override
  Widget build(BuildContext context) {
    this.context = context;
    String? qrText = barcode?.code;
    var data = [];
    if (qrText != null) data = qrText.split(",");
    return Scaffold(
        body: Stack(
      children:[
        buildBackGround("assets/form_back.jpg"),
        SingleChildScrollView(
        child: Column(
          children: [
          
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildDataContainer(data, context),
              // buildBeginContainer(
              //     "Let us know how is your journey so that we can improve your experience next time!",
              //     "assets/containerBack.jpg",
              //     context),

              buildQuestionsContainer(),
              buildSubmitButton()
            ],
          ),
        ],
        )
      ),
  ]
    ));
  }
































  buildDataContainer(List data, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 300,
      margin: const EdgeInsets.only(top: 70, left: 5, right: 5),
      padding: EdgeInsets.all(20),
      // decoration: const BoxDecoration(boxShadow: [
      //   BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: Colors.black26)
      // ],),
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))),
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Details", style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold, color:Colors.blue),textAlign: TextAlign.center,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildHeadingContainer("Bus Number"),
                  buildHeadingContainer("Driver Name"),
                  buildHeadingContainer("From"),
                  buildHeadingContainer("To"),
                  buildHeadingContainer("Scheduled Start"),
                  buildHeadingContainer("Scheduled End"),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildOppositeContainer(data[0]),
                  buildOppositeContainer(data[1]),
                  buildOppositeContainer(data[2]),
                  buildOppositeContainer(data[3]),
                  buildOppositeContainer((data.length == 4) ? "NA" : data[4]),
                  buildOppositeContainer((data.length == 4) ? "NA" : data[5]),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  buildHeadingContainer(String s) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        s+":",
        style: GoogleFonts.roboto(
            fontSize: 14,  fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
      ),
    );
  }

  buildOppositeContainer(String s) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          s,
          
          style: GoogleFonts.roboto(
              fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  buildBeginContainer(String s, String assetPhoto, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6, right: 6, top: 20, bottom: 10),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width - 15,
      height: 92,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(assetPhoto),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Center(
          child: Text(
        s,
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(fontWeight: FontWeight.w900),
      )),
    );
  }

  buildQuestionsContainer() {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      padding: EdgeInsets.all(10),
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.all(Radius.circular(20)),
       boxShadow: [
         BoxShadow(
           offset: Offset(0,4),
           blurRadius: 4,
           color: Colors.black26
         )
       ]

     ),
      margin: const EdgeInsets.only(top: 70, left: 5, right: 5),
      child: GestureDetector(
        onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
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
          buildMultiOptions("busSeats", context, ["Yes", "No"], ["Yes", "No"]),
          buildQuestion("How is driver’s behaviour?"),
          buildMultiOptions(
              "driverBehaviour", context, ["Good", "Bad"], [1, 0]),
          buildQuestion("Do you have any remarks?"),
          buidRemarkInputText("remark"),
          buildQuestion("Rate your overall journey?"),
          buildRating("overallRate")
        ],
      ),
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
          userInputData[s] = value;
        },
        // ignore: deprecated_member_use
        selectedColor: Theme.of(context).accentColor,
      ),
    );
  }

  buidRemarkInputText(String s) {
    return TextField(
      autofocus: false,
      onChanged: (ss){
        userInputData[s]=ss;
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
final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  buildSubmitButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: ElevatedButton(
              style: style,
              onPressed: () {
                print("Data is Available for Transmission");
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ThankYouScreen()));
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
        image: DecorationImage(
          image: AssetImage(assetPhoto),
          fit: BoxFit.fill
        )
      ),
      
    );
  }
}
