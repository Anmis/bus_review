import 'package:bus_review/screens/scanner_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 28, color: Colors.black),
        alignment: Alignment.bottomCenter,
        primary: const Color.fromRGBO(222, 255, 231, 1),
        padding: const EdgeInsets.fromLTRB(60.0, 15.0, 60.0, 15.0));

    return Scaffold(
      body: Stack(
        children: [
          buildGifContainer(),
          Align(
            child: SizedBox(
              height: 450,
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: const Text(
                      "APSRTC Online Passenger Review",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.blue,
                    padding: const EdgeInsets.fromLTRB(0.0, 20, 0.0, 120.0),
                    alignment: Alignment.topCenter,
                    child: ElevatedButton(
                      style: style,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QRScanPage()));
                      },
                      child: Text(
                        'Scan QR',
                        style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBackgroundImage() {
    return Container(
      height: 619,
      width: 679,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  buildGifContainer() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.gif"), fit: BoxFit.cover)),
    );
  }
}
