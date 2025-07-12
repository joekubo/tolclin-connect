import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/ai_barcode_scanner.dart';
import 'package:mobile/components/buttons.dart';
import 'package:mobile/components/custom_text.dart';
import 'package:mobile/pages/scanning2.dart';

class Scanning extends StatefulWidget {
  const Scanning({super.key});

  @override
  State<Scanning> createState() => _ScanningState();
}

class _ScanningState extends State<Scanning> {
  MobileScannerController scannerController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: CustomText(
          text: 'TOLCLIN CONNECT',
          size: 12,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.black,
              elevation: 20.0,
              shadowColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ListTile(
                title: CustomText(
                  text: "DateTime : 2025-07-11 10:09:45",
                  size: 10.0,
                  weight: FontWeight.bold,
                  color: Colors.white,
                ),
                subtitle: CustomText(
                  text: "Amount: KES 20, (T234SDFAFS)",
                  size: 7.0,
                  color: Colors.white,
                ),
                trailing: PopupMenuButton(itemBuilder: (context) => []),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: width,
              child: Card(
                color: Colors.white,
                elevation: 20.0,
                shadowColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(width: width * 0.75, child: Divider()),
                    const SizedBox(height: 10),
                    CustomText(
                      text: "SCAN TV QR-CODE",
                      color: Colors.blue,
                      size: 18.0,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(width: width * 0.75, child: Divider()),
                    SizedBox(height: height * 0.2),
                    MyButton(
                      text: "SCAN",
                      width: width * 0.9,
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              // builder: (context) => AiBarcodeScanner( controller: scannerController,),
                              builder: (context) => Scanning2(),
                            ),
                          );
                        });
                        print( scannerController);
                      },
                      textColor: Colors.red,
                      height: height * 0.08,
                      buttonColor: Colors.amber.shade200,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
            CustomText(
              text: "Powered by TOLCLIN",
              color: Colors.amber.shade900,
            ),
          ],
        ),
      ),
    );
  }
}
