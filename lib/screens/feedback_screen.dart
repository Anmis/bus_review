import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// ignore: must_be_immutable
class FeedbackScreen extends StatelessWidget {
  Barcode? barcode;
   FeedbackScreen({ Key? key, Barcode? bar}) : super(key: key){
     barcode=bar;
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(barcode?.code??"hello"),),
    );
  }
}