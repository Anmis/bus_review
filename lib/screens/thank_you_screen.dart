import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThankYouScreen extends StatelessWidget {
  ThankYouScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 100),
              child: Text(
                "Thank You For Your Feedback!",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "You can exit the application now.",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[300]),
              ),
            ),
            buildSubmitButton(context)
          ],
        ),
      ),
    ));
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 24),
  );
  buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 60,
      child: ElevatedButton(
        style: style,
        onPressed:  () => Navigator.popUntil(
                    context,
                    ModalRoute.withName('/'),
                  ),
        child: const Text('Exit'),
      ),
    );
  }
}
