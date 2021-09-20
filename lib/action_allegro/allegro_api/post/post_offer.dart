import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_store/action_allegro/allegro_api/authentication.dart';
import 'package:my_store/action_allegro/models/categories/categories.dart';
import 'package:my_store/action_allegro/models/offer_parameter/offer_parameters.dart';
import 'package:my_store/action_create_offer/offer_model.dart';
import 'package:my_store/action_allegro/models/offer_photo.dart';

const offerUrl = 'https://api.allegro.pl/sale/offers';

class PostOffer {
  static Future createDraft(OfferModel offer, var category) async {
    String data = jsonEncode({
      "name": offer.title,
      "images": offer.images,
      'category': category,
      'product': {'id': offer.productId},
      'parameters': offer.parameters,
      'description': offer.description,
      'sellingMode': offer.sellingMode,
      'stock': offer.stock,
    });
    print(data);
    await AuthenticateClient.readTokens();
    String token = 'Bearer ' + AuthenticateClient.accessToken;
    http.Response response = await http.post(Uri.parse(offerUrl),
        headers: {
          HttpHeaders.authorizationHeader: token,
          HttpHeaders.acceptHeader: 'application/vnd.allegro.public.v1+json',
          HttpHeaders.contentTypeHeader:
              'application/vnd.allegro.public.v1+json'
        },
        body: data);

    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> decodeResponse = jsonDecode(response.body);
      String _id = decodeResponse['id'];
      print('networking: createDraft: id = $_id');
      return response.statusCode;
    } else {
      print('PostOffer: postOffer status code:');
      print(response.statusCode);
      return response.statusCode;
    }
  }

  static Future addImegesToAllegroServer(
      String file, List<dynamic> myImagesUrls) async {
    await AuthenticateClient.readTokens();
    String token = 'Bearer ' + AuthenticateClient.accessToken;
    http.Response response =
        await http.post(Uri.parse('https://upload.allegro.pl/sale/images'),
            headers: {
              HttpHeaders.authorizationHeader: token,
              HttpHeaders.acceptHeader:
                  'application/vnd.allegro.public.v1+json',
              HttpHeaders.contentTypeHeader: 'image/jpg',
              HttpHeaders.contentTypeHeader: 'image/png',
            },
            body: File(file).readAsBytesSync());

    if (response.statusCode == 201) {
      print(response.body);
      OfferPhoto offerImage =
          OfferPhoto.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      myImagesUrls.add(offerImage.location);
    } else {
      print('PostOffer: image status code:');
      print(response.statusCode);
    }
  }

  static getCategories(String categoryId) async {
    await AuthenticateClient.readTokens();
    String token = 'Bearer ' + AuthenticateClient.accessToken;
    String url;
    if (categoryId == null) {
      url = 'https://api.allegro.pl/sale/categories';
    } else {
      url = 'https://api.allegro.pl/sale/categories?parent.id=$categoryId';
    }
    http.Response response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: 'application/vnd.allegro.public.v1+json',
    });
    if (response.statusCode == 200) {
      Categories categories =
          Categories.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      return categories;
    } else {
      print('PostOffer: category status code:');
      print(response.statusCode);
    }
  }

  static Future<OfferParameters> getParameters(OfferModel offer) async {
    if (offer.category == null && offer.productCategory == null) {
      return null;
    }
    String categoryId;
    if (offer.category != null) {
      categoryId = offer.category.id;
    } else {
      categoryId = offer.productCategory.id;
    }

    await AuthenticateClient.readTokens();
    String token = 'Bearer ' + AuthenticateClient.accessToken;
    String url =
        'https://api.allegro.pl/sale/categories/$categoryId/parameters';
    http.Response response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.acceptHeader: 'application/vnd.allegro.public.v1+json',
    });
    if (response.statusCode == 200) {
      OfferParameters parameters = OfferParameters.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
      return parameters;
    } else {
      print('PostOffer: parameters status code:');
      print(response.statusCode);
      return null;
    }
  }
}
