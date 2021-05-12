import 'dart:convert';
import 'dart:io';

import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:my_store/action_post/allegro_api/authentication.dart';

const productUrl = 'https://api.allegro.pl/sale/products?';
const newOfferUrl = 'https://api.allegro.pl/sale/product-offers’';
const categoryUrl = 'https://api.allegro.pl/sale/categories/';

class NetworkHelper {
  static Future<String> getAccess() async {
    await AuthenticateClient.readTokens();
    if (AuthenticateClient.accessToken == null) {
      return 'Brak połączenia z Allegro';
    }
    return 'Bearer ' + AuthenticateClient.accessToken;
  }

  static Future getProductData(String EAN) async {
    String token = await getAccess();
    http.Response response = await getProductByEAN(EAN, token);
    if (response == null) {
      return;
    }
    bool connected = await AuthenticateClient.AuthenticationOk(response);
    if (connected) {
      var data = parse(response.body);
      print(data.body.text);
      return await json.decode(utf8.decode(response.bodyBytes));
    } else {
      print('networking: getProductData: Brak połączenia');
      return 'Brak połączenia z Allegro';
    }
  }

  static Future<http.Response> getProductByEAN(String EAN, String token) async {
    if (EAN == 'null' || EAN == null) {
      return null;
    }
    String url = productUrl + 'ean=$EAN';

    return await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: ' application/vnd.allegro.public.v1+json'
    });
  }

  static getCategoryById(String categoryId) async {
    if (categoryId == 'null' || categoryId == null) {
      return null;
    }
    String token = await getAccess();
    String url = categoryUrl + categoryId;
    http.Response response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: ' application/vnd.allegro.public.v1+json'
    });

    bool connected = await AuthenticateClient.AuthenticationOk(response);
    if (connected) {
      return await json.decode(utf8.decode(response.bodyBytes));
    } else {
      print('networking: getProductData: Brak połączenia');
      return 'Brak połączenia z Allegro';
    }
  }

  Future getProductDataById(String id) async {
    await AuthenticateClient.readTokens();
    String token = 'Bearer ' + AuthenticateClient.accessToken;
    String url =
        'https://api.allegro.pl/sale/products/043788e6-e1af-45b0-b62c-809bef3db94e';
    print(url);

    http.Response response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: ' application/vnd.allegro.public.v1+json'
    });
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future createOffer(String offerTitle) async {
    await AuthenticateClient.readTokens();
    String token = 'Bearer ' + AuthenticateClient.accessToken;
    http.Response response = await http.post(Uri.parse(newOfferUrl), headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: ' application/vnd.allegro.public.v1+json'
    }, body: {
      'name': offerTitle,
    });
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> decodeResponse = jsonDecode(response.body);
      String _id = decodeResponse['id'];
      print('networking: createDraft: id = $_id');
      return response.statusCode;
    }
  }

  Future postData() async {
    http.Response response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future putData() async {
    http.Response response = await http.put(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future patchData() async {
    http.Response response = await http.patch(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future deleteData() async {
    http.Response response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
