import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mac_address_plus/mac_address_plus.dart';
import 'package:mobile/functions/functions.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:audioplayers/audioplayers.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController controller = MobileScannerController();
  final AudioPlayer player = AudioPlayer();

  bool _scanned = false;
  String scannedValue = "";

  String _macAddress = 'Unknown';

  final _macAddressPlusPlugin = MacAddressPlus();

  Future<void> initPlatformState() async {
    String macAddress;
    try {
      macAddress =
          await _macAddressPlusPlugin.getMacAddress() ?? 'Unknown mac address';
    } on PlatformException {
      macAddress = 'Failed to get mac address.';
    }

    if (!mounted) return;

    setState(() {
      _macAddress = macAddress;
      print(macAddress);
    });
  }

  void _loadImageAfterDelay() {
    Timer(Duration(seconds: 4), () {
      setState(() {
        SystemNavigator.pop();
      });
    });
  }

  @override
  void initState() {
    initPlatformState();
    // _getIPAddress(context);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("TOLCLIN CONNECT Scanner"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on, color: Colors.white),
            onPressed: () => controller.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch, color: Colors.white),
            onPressed: () => controller.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          // CAMERA VIEW
          MobileScanner(
            controller: controller,
            onDetect: (capture) async {
              if (_scanned) return;

              _scanned = true;

              final barcode = capture.barcodes.first;
              final String code = barcode.rawValue ?? "Unknown";

              // 🔊 beep sound
              await player.play(AssetSource('sounds/beep.mp3'));

              // print the QR code to the UI
              setState(() {
                scannedValue = code;
              });
              await Functions().updateDetails(
                _macAddress,
                scannedValue,
                context,
              );
              _loadImageAfterDelay();

              // resume scanning after a short delay, no page freeze
              await Future.delayed(const Duration(seconds: 2));
              _scanned = false;
            },
          ),

          // OVERLAY (semi-transparent)
          Container(color: Colors.black.withOpacity(0.3)),

          // SCAN BOX
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.greenAccent, width: 4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          // DISPLAY SCANNED VALUE (bottom)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.black.withOpacity(0.5),
              child: Text(
                scannedValue.isEmpty
                    ? "Scan TV..."
                    : "TV Connected Successfully...",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
