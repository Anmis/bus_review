import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DisplayData extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var dbName;
  DisplayData({Key? key, var dbName}) : super(key: key) {
    // ignore: prefer_initializing_formals
    this.dbName = dbName;
  }

  @override
  _DisplayDataState createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection(widget.dbName).snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return const Scaffold();
          }
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }));
  }
}
