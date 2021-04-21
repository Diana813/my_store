import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const clientID = '';
const clientSecret =
    '';
const url = '';

class AuthenticateClient {
  Future<http.Response> createClient() async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$clientID:$clientSecret'));
    http.Response response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: basicAuth,
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
    }, body: {
      'client_id': clientID,
    });
    print(response.request);
    print(response.body);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }
}
