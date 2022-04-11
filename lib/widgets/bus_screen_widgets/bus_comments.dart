import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class BusCommentsScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var comments;
  BusCommentsScreen({Key? key, required comm}) : super(key: key) {
    comments = comm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 600,
          width: 400,
          child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return buildCommentContainer(comments[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget buildCommentContainer(comment) {
    String seatsAvailable = comment['busSeats'];

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      height: 90,
      width: 335,
      child: Column(
        children: [
          buildTextRow(
              "Bus Infrastructure Rating", comment['busInfra'].toString()),
          buildTextRow("Is Bus Seats Enough?", seatsAvailable),
        ],
      ),
      decoration: BoxDecoration(
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 4), blurRadius: 2)
          ],
          color: const Color.fromRGBO(254, 248, 229, 1),
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(7))),
    );
  }

  buildTextRow(key, value) {
    return Container(
      margin: const EdgeInsets.all(6),
      child: Row(
        children: [
          Text(key + ": ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.roboto().fontFamily)),
          Text(value)
        ],
      ),
    );
  }
}
