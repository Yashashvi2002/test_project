import 'package:flutter/material.dart';
//package imported from pub.dev to get qr scanning functionality
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//main code for qr scan
class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey qrKey = GlobalKey(
      debugLabel: 'QR'); // Key required by the QRView used to scan qr code.
  var qrText = ''; // Variable to hold scanned text
  QRViewController? controller; // QRViewController for QRView
  bool cameraEnabled = true; //Used to check if camera is enabled or not

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //Column to place all the widgets required
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //used to give appropriate spacing at the start of Column
            const SizedBox(height: 85),
            //Image at the top of the column
            Ink.image(
              height: 66.64,
              width: 141.04,
              image: const AssetImage(
                  "assets/images/Ebene.png"), //path to the image
            ),
            const SizedBox(height: 128.36),
            //implementation of qr scanning begins here
            SizedBox(
              height: 291,
              width: 294,
              //ClipRRect used to give border radius to the scene
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                //used to display the camera feed as well as the QR code data on top of each other
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    //check if necessary permissions are provided and camera is emabled
                    if (cameraEnabled)
                      //if camera is enabled show this widget
                      QRView(
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                        //to give shape to the QRView Scene
                        overlay: QrScannerOverlayShape(
                          borderRadius: 20,
                          borderWidth: 10,
                          borderColor: Colors.black,
                          cutOutSize: 290,
                        ),
                      )
                    else
                      //if camera is disabled or permissions are denied show this container
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
                    //This displays on top of the QRView scene when data is collected from qr code. Initially it is an empty string hence it is not visible
                    Positioned(
                      top: 120,
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        color: Colors.white70,
                        //data of the qr code that has been scanned
                        child: Text(
                          qrText,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 81),
            //Some footer text
            const Text(
              "Scannen Sie den QR-Code",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            //footer text
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
      //change the state of the app when data is scanned from the qr
      setState(() {
        //set qrText equal to scanData which is scanned
        qrText = scanData.code ?? '';
      });
    });
  }

//dispose method to avoid memory leak
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
