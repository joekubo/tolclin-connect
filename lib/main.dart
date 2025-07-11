import 'package:flutter/material.dart';
import 'package:tv_mac_app/pages/get_ip_address.dart';
import 'package:tv_mac_app/pages/main_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOLCLIN-TV',
      debugShowCheckedModeBanner: false,  
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const GetIp(),
    );
  }
}


