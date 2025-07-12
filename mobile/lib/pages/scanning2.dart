import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile/ai_barcode_scanner.dart';
import 'package:mobile/components/custom_text.dart';
import 'package:mobile/src/gallery_button.dart';

import 'package:pretty_qr_code/pretty_qr_code.dart';

class Scanning2 extends StatefulWidget {
  const Scanning2({super.key});

  @override
  State<Scanning2> createState() => _Scanning2State();
}

class _Scanning2State extends State<Scanning2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.deepOrange,
         centerTitle: true,
         title: CustomText(
          text: 'SCANNER',
          size: 12,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
      body: GestureDetector(
        child: Stack(
          children: [
            MobileScanner(
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                final Uint8List? image = capture.image;
                for (final barcode in barcodes) {
                  print("Barcode found! ${barcode.rawValue}");
                }
                if (image != null) {
                  //send data to online
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: CustomText(text: barcodes.first.rawValue ?? ""),
                        content: Image(image: MemoryImage(image)),
                      );
                    },
                  );
                }
              },
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates,
                returnImage: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
