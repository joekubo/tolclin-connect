import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile/components/custom_text.dart';
import 'package:mobile/functions/call_api.dart';

class Functions {
  Future<Map<String, dynamic>> updateDetails(
    String phoneMac,
    String tvIp,
    BuildContext context,
  ) async {
    final Map<String, dynamic> payload = {
      "phone_mac": phoneMac,
      "tv_ip": tvIp,
      "type": "-",
    };

    try {
      final response = CallApi().postData(payload, "updatemac");
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomText(text: body["message"], color: Colors.white),
          ),
        );
        return body;
      } else {
        print("Failed: ${response.statusCode} ${response.body}");

        return {
          "success": false,
          "message": "Server returned ${response.statusCode}",
        };
      }
    } catch (e) {
      print("Error calling API: $e");
      return {"success": false, "message": e.toString()};
    }
  }
}
