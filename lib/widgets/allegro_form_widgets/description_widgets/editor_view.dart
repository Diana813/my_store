import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_store/action_create_offer/offer_model.dart';
import 'package:zefyrka/zefyrka.dart';

import 'item_widget.dart';

class EditorView extends StatelessWidget {
  EditorView({
    @required this.doc,
    @required this.firstImageUrl,
    @required this.secondImageUrl,
    @required this.article,
    @required this.art_track,
    @required this.two_pictures,
    @required this.text_track,
    @required this.image,
    @required this.myOffer,
    @required this.addFirstImage,
    @required this.addSecondImage,
  });

  final NotusDocument doc;
  final String firstImageUrl;
  final String secondImageUrl;
  final OfferModel myOffer;
  final Function addFirstImage;
  final Function addSecondImage;
  bool article;
  bool image;
  bool art_track;
  bool text_track;
  bool two_pictures;

  Widget getEditorView() {
    if (two_pictures) {
      return TwoImageView(
        firstImageUrl: firstImageUrl,
        secondImageUrl: secondImageUrl,
        myOffer: myOffer,
        addFirstImage: addFirstImage,
        addSecondImage: addSecondImage,
      );
    } else if (image) {
      return ImageView(
        imageUrl: firstImageUrl,
        myOffer: myOffer,
        addImage: addFirstImage,
      );
    } else if (art_track) {
      return ArtTrack(
        doc: doc,
        imageUrl: firstImageUrl,
        myOffer: myOffer,
        addFirstImage: addFirstImage,
      );
    } else if (text_track) {
      return TextTrack(
        doc: doc,
        imageUrl: secondImageUrl,
        myOffer: myOffer,
        addSecondImage: addSecondImage,
      );
    } else {
      return ArticleView(
        doc: doc,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: getEditorView()),
      ],
    );
  }
}

class ImageView extends StatelessWidget {
  String imageUrl;
  final OfferModel myOffer;
  final Function addImage;

  ImageView({
    @required this.imageUrl,
    @required this.myOffer,
    @required this.addImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showImageList(myOffer, myOffer.description.sections.length - 1, context,
            addImage);
      },
      child: imageUrl.isEmpty
          ? Image.asset('assets/images/image_placeholder.jpg')
          : GestureDetector(
              child: Image.network(imageUrl),
            ),
    );
  }

  String showImageList(OfferModel myOffer, int sectionNumber,
      BuildContext context, Function addImage) {
    showDialog(
      context: context,
      builder: (BuildContext context) => PopupMenuItem(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 6,
          children: myOffer.images
              .map(
                (data) => GestureDetector(
                    onTap: () {
                      addImage(data.url);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Image.network(
                        data.url,
                        fit: BoxFit.scaleDown,
                      ),
                    )),
              )
              .toList(),
        ),
      ),
    );
  }
}

class TwoImageView extends StatelessWidget {
  final String firstImageUrl;
  final String secondImageUrl;
  final OfferModel myOffer;
  final Function addFirstImage;
  final Function addSecondImage;

  TwoImageView(
      {@required this.firstImageUrl,
      @required this.secondImageUrl,
      @required this.myOffer,
      @required this.addFirstImage,
      @required this.addSecondImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          child: ImageView(
            imageUrl: firstImageUrl,
            myOffer: myOffer,
            addImage: addFirstImage,
          ),
        )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: ImageView(
              imageUrl: secondImageUrl,
              myOffer: myOffer,
              addImage: addSecondImage,
            ),
          ),
        )
      ],
    );
  }
}

class ArticleView extends StatelessWidget {
  final NotusDocument doc;

  ArticleView({@required this.doc});

  @override
  Widget build(BuildContext context) {
    return Item(
      doc: doc,
    );
  }
}

class ArtTrack extends StatelessWidget {
  final NotusDocument doc;
  final String imageUrl;
  final OfferModel myOffer;
  final Function addFirstImage;

  ArtTrack(
      {@required this.doc,
      @required this.imageUrl,
      @required this.myOffer,
      @required this.addFirstImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          child: ImageView(
            imageUrl: imageUrl,
            myOffer: myOffer,
            addImage: addFirstImage,
          ),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: ArticleView(
            doc: doc,
          ),
        )),
      ],
    );
  }
}

class TextTrack extends StatelessWidget {
  final NotusDocument doc;
  final String imageUrl;
  final OfferModel myOffer;
  final Function addSecondImage;

  TextTrack(
      {@required this.doc,
      @required this.imageUrl,
      @required this.myOffer,
      @required this.addSecondImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          child: ArticleView(
            doc: doc,
          ),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: ImageView(
            imageUrl: imageUrl,
            myOffer: myOffer,
            addImage: addSecondImage,
          ),
        )),
      ],
    );
  }
}
