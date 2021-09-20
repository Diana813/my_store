import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/products/description/description.dart';
import 'package:my_store/action_create_offer/offer_model.dart';
import 'package:my_store/utils/colors.dart';
import 'package:zefyrka/zefyrka.dart';

import 'editor_view.dart';

class NewSection extends StatelessWidget {
  NotusDocument doc;
  final OfferModel offerModel;
  final String firstImageUrl;
  final String secondImageUrl;
  bool article;
  bool image;
  bool art_track;
  bool text_track;
  bool two_pictures;
  final Function setArticle;
  final Function setImage;
  final Function setArtTrack;
  final Function setTextTrack;
  final Function setTwoPictures;
  final Function addFirstImage;
  final Function addSecondImage;

  NewSection({
    @required this.doc,
    @required this.offerModel,
    @required this.firstImageUrl,
    @required this.secondImageUrl,
    @required this.article,
    @required this.image,
    @required this.art_track,
    @required this.text_track,
    @required this.two_pictures,
    @required this.setArticle,
    @required this.setImage,
    @required this.setArtTrack,
    @required this.setTextTrack,
    @required this.setTwoPictures,
    @required this.addFirstImage,
    @required this.addSecondImage,
  });

  Description myDesc = Description();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.article_outlined,
                color: article
                    ? Color(ColorsMyStore.AccentColor)
                    : Color(ColorsMyStore.PrimaryColor),
              ),
              onPressed: article == false ? setArticle : null,
            ),
            IconButton(
              icon: Icon(
                Icons.image,
                color: image
                    ? Color(ColorsMyStore.AccentColor)
                    : Color(ColorsMyStore.PrimaryColor),
              ),
              onPressed: image == false ? setImage : null,
            ),
            IconButton(
              iconSize: 40,
              icon: Icon(
                Icons.art_track,
                color: art_track
                    ? Color(ColorsMyStore.AccentColor)
                    : Color(ColorsMyStore.PrimaryColor),
              ),
              onPressed: art_track == false ? setArtTrack : null,
            ),
            IconButton(
              iconSize: 40,
              icon: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Icon(
                  Icons.art_track,
                  color: text_track
                      ? Color(ColorsMyStore.AccentColor)
                      : Color(ColorsMyStore.PrimaryColor),
                ),
              ),
              onPressed: text_track == false ? setTextTrack : null,
            ),
            IconButton(
              iconSize: 45,
              icon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.image,
                      color: two_pictures
                          ? Color(ColorsMyStore.AccentColor)
                          : Color(ColorsMyStore.PrimaryColor),
                      size: 22,
                    ),
                    Icon(
                      Icons.image,
                      color: two_pictures
                          ? Color(ColorsMyStore.AccentColor)
                          : Color(ColorsMyStore.PrimaryColor),
                      size: 22,
                    ),
                  ]),
              onPressed: two_pictures == false ? setTwoPictures : null,
            ),
          ],
        ),
        EditorView(
          image: image,
          doc: doc,
          secondImageUrl: secondImageUrl,
          two_pictures: two_pictures,
          firstImageUrl: firstImageUrl,
          article: article,
          text_track: text_track,
          art_track: art_track,
          myOffer: offerModel,
          addFirstImage: addFirstImage,
          addSecondImage: addSecondImage,
        ),
      ],
    );
  }
}
