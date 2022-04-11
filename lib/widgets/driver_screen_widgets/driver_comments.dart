// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class DriverCommentsScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var comments;
  DriverCommentsScreen({Key? key, required comm}) : super(key: key) {
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
    String driverBehave = (comment['driverBehaviour'] == 1) ? "Good" : "Bad";

    int remLen = comment["remark"].length;
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      height: 90,
      width: 335,
      child: Column(
        children: [
          if (remLen > 0) buildRemark(comment),
          buildTextRow("Driver Pace", comment['pace'].toString()),
          buildTextRow("Driver Bahaviour", driverBehave),
        ],
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 4), blurRadius: 2)
          ],
          color: Color.fromRGBO(254, 248, 229, 1),
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(7))),
    );
  }

  buildRemark(comment) {
    return Row(
      children: [
        Text("Remark: ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.inter().fontFamily)),
        Text(comment["remark"])
      ],
    );
  }

  buildTextRow(key, value) {
    return Row(
      children: [
        Text(key + ": ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.inter().fontFamily)),
        Text(value)
      ],
    );
  }
}
