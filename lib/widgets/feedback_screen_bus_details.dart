import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double getRating(doc) {
  double sum = 0;
  for (int i = 0; i < doc?.length; i++) {
    int val =
        (doc?[i]["driverRate"] + doc?[i]["pace"] + doc?[i]["overallRate"]) / 3;
    sum += val;
  }
  sum /= doc?.length;
  return sum;
}

buildDataContainer(List data, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width - 40,
    height: 300,
    margin: const EdgeInsets.only(top: 70, left: 5, right: 5),
    padding: const EdgeInsets.all(20),
    // decoration: const BoxDecoration(boxShadow: [
    //   BoxShadow(offset: Offset(0, 4), blurRadius: 4, color: Colors.black26)
    // ],),
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20))),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Details",
          style: GoogleFonts.roboto(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
          textAlign: TextAlign.center,
        ),
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
      s + ":",
      style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500),
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
        style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w500),
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
