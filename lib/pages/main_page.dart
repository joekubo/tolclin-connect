import 'dart:async';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:tv_mac_app/components/barcode.dart';
import 'package:tv_mac_app/components/custom_text.dart';
import 'package:barcode/barcode.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? _ipAddress;
  bool _isImageReady = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _getIPAddress(context);
      _loadImageAfterDelay();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadImageAfterDelay() {
    Timer(Duration(seconds: 7), () {
      setState(() {
        _isImageReady = true; // Change state to show the image after 5 seconds.
      });
    });
  }

  Future<void> _getIPAddress(context) async {
    final networkInfo = NetworkInfo();
    String? wifiIP;
    try {
      wifiIP = await networkInfo.getWifiIP();
    } catch (e) {
      SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() {
      _ipAddress = wifiIP;
      buildBarcode(
        height: 200,
        Barcode.dataMatrix(),

        "$_ipAddress",
        filename: 'barcode',
      );
    });
  }

  Widget svg = SvgPicture.asset("assets/barcode.svg");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: CustomText(
          text: 'TOLCLIN-TV',
          size: 20,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white, size: 30),
            onPressed: () {
              setState(() {
                _getIPAddress(context);
                _loadImageAfterDelay();
              });
            },
          ),
        ],
      ),
      body: _isImageReady
          ? Center(child: svg)
          : Center(
              child: LoadingAnimationWidget.stretchedDots(color: Colors.blueGrey, size: 50),
            ),
    );
  }
}
