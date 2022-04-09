import 'dart:io';
// import 'package:bus_review/screens/feedback_screen.dart';
import 'package:bus_review/screens/admin_screen.dart';
import 'package:bus_review/screens/feedback_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({Key? key}) : super(key: key);

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  PermissionStatus status = PermissionStatus.denied;

  @override
  void initState() {
    _getCameraPermission();

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return (barcode == null)
        ? SafeArea(
            child: Scaffold(
                body: (status.isGranted)
                    ? buildQrView(context)
                    : const Center(
                        child: Text("Please Allow camera Permissions"))))
        : (barcode?.code == "226612@admin#!")
            ? const AdminScreen()
            : FeedbackScreen(
                bar: barcode,
              );
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 20,
          borderLength: 20,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
      // Navigator.push(context,
      // MaterialPageRoute(builder: (context)=>FeedbackScreen()));
    });
  }

  void _getCameraPermission() async {
    var stat = await Permission.camera.status;
    if (!stat.isGranted) {
      final result = await Permission.camera.request();
      setState(() {
        status = result;
      });
    } else {
      setState(() {
        status = stat;
      });
    }
  }
}
