import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
//main code for qr scan

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = ''; // Variable to hold scanned text
  QRViewController? controller;
  bool cameraEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 85),
            Ink.image(
              height: 66.64,
              width: 141.04,
              image: const AssetImage("assets/images/Ebene.png"),
            ),
            const SizedBox(height: 128.36),
            SizedBox(
              height: 291,
              width: 294,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (cameraEnabled)
                      QRView(
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                        overlay: QrScannerOverlayShape(
                          borderRadius: 20,
                          borderWidth: 10,
                          borderColor: Colors.black,
                          cutOutSize: 290,
                        ),
                      )
                    else
                      Container(
                        color: Colors.black26,
                        child: const Center(
                          child: Text(
                            'Camera is disabled',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      top: 120,
                      child: Container(
                        padding: const EdgeInsets.all(0),
                         color: Colors.white70,
                        child: Text(
                          qrText,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 81),
            const Text(
              "Scannen Sie den QR-Code",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Scannen Sie den QR-Code auf der Unterseite des\n"
                  "Gateways, um die Installation fortzusetzen",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Callback when QR view is created
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code?? '';
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}





