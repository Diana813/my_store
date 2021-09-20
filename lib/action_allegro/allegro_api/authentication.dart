import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_store/action_find_item_on_the_internet/network_search_brain.dart';
import 'package:path_provider/path_provider.dart';

const clientID = '';
const clientSecret =
    '';
const url = '';
const tokenUrl = '';

class AuthenticateClient {
  static String _device_code = '';
  static String _accessToken;
  static String _refreshToken;

  static String get accessToken => _accessToken;

  static String get refreshToken => _refreshToken;

  static String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$clientID:$clientSecret'));

  static Future<int> createClient() async {
    http.Response response = await http.post(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader: basicAuth,
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
    }, body: {
      'client_id': clientID,
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> decodeResponse = jsonDecode(response.body);
      _device_code = decodeResponse['device_code'];
      String verificationUrl = decodeResponse['verification_uri_complete'];
      NetworkSearchBrain.launchURL(verificationUrl);
      getAccessToken();
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  static getAccessToken() async {
    http.Response response;
    String url =
        'https://allegro.pl/auth/oauth/token?grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Adevice_code&device_code=$_device_code';
    do {
      sleep(Duration(seconds: 2));
      response = await http.post(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: basicAuth,
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
      });
    } while (response.statusCode != 200);
    Map<String, dynamic> decodeResponse = jsonDecode(response.body);
    _accessToken = decodeResponse['access_token'];
    _refreshToken = decodeResponse['refresh_token'];
    await _saveTokens(accessToken, refreshToken);
  }

  static refreshAccessToken() async {
    await readTokens();
    print('authentication: refresh token: $_refreshToken');
    if (_refreshToken == null) {
      return -1;
    }
    String url =
        'https://allegro.pl/auth/oauth/token?grant_type=refresh_token&refresh_token=$_refreshToken';

    http.Response response = await http.post(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader: basicAuth,
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
    });

    Map<String, dynamic> decodeResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      _accessToken = decodeResponse['access_token'];
      _refreshToken = decodeResponse['refresh_token'];
      await _saveTokens(_accessToken, refreshToken);
    }
    print(response.statusCode);
    return response.statusCode;
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tokens.txt');
  }

  static Future<File> _saveTokens(String token, String refreshToken) async {
    final file = await _localFile;
    return file.writeAsString('$token, $refreshToken');
  }

  static Future<String> readTokens() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      _accessToken = contents.split(', ')[0];
      _refreshToken = contents.split(', ')[1];
      return contents;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> AuthenticationOk(http.Response response) async {
    if (response.statusCode == 401) {
      int status = await refreshAccessToken();
      if (status == 401) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
