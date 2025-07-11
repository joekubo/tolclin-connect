import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:tv_mac_app/components/custom_text.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GetIp extends StatefulWidget {
  const GetIp({super.key});

  @override
  State<GetIp> createState() => _GetIpState();
}

class _GetIpState extends State<GetIp> {
  String? _ipAddress;
  bool _isImageReady = false;

  void _loadImageAfterDelay() {
    Timer(Duration(seconds: 7), () {
      setState(() {
        _isImageReady = true; // Change state to show the image after 5 seconds.
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _getIPAddress(context);
      _loadImageAfterDelay();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: CustomText(
          text: 'TOLCLIN CONNECT TV',
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
          ? Center(
              child: QrImageView(
                data: "$_ipAddress",
                version: QrVersions.auto,
                size: 200,
              ),
            )
          : Center(
              child: LoadingAnimationWidget.stretchedDots(
                color: Colors.blueGrey,
                size: 50,
              ),
            ),
    );
  }

  _getIPAddress(context) async {
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
    });
  }
}
