import 'dart:convert';

import 'package:http/http.dart' as http;

class CallApi {
   static const String url = "http://167.99.46.0/tolclinet/api/";
  // static const String url = "http://10.100.105.155:8000/api/";

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  postData(data, apiUrl) async {
    var fullUrl = url + apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  fetchData(apiUrl) async {
    var fullUrl = apiUrl;
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }
}
