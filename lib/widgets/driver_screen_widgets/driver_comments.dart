import 'package:flutter/material.dart';

class DriverCommentsScreen extends StatelessWidget {
  var comments;
  DriverCommentsScreen({Key? key, required comm}) : super(key: key) {
    comments = comm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
    int remLen = comment["remark"].length().round();
    print(remLen.toString());
    return Container(
      height: 120,
      width: 400,
      child: Column(
        children: [
          (remLen > 0)
              ? Text(comment["remark"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
              : Center(),
          Row(
            children: [Text("Driver Pace"), Text(comment["pace"].toString())],
          ),
          Row(children: [
            Text("Driver Behaviour"),
            (comment["driverBehaviour"] == 1) ? Text("Good") : Text("Bad"),
          ]),
        ],
      ),
    );
  }
}
