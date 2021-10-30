import 'package:bus_review/screens/scanner_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 28, color: Colors.black),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.fromLTRB(60.0, 15.0, 60.0, 15.0));

    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundImage(),
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 120.0),
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QRScanPage()));
              },
              child: const Text('Scan'),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
