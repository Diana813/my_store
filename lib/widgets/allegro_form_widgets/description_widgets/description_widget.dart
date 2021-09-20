import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/products/description/description_sections.dart';
import 'package:my_store/action_allegro/models/products/description/description_sections_items_desc.dart';
import 'package:my_store/action_create_offer/offer_model.dart';
import 'package:my_store/notus_doc_to_html/notus_to_html.dart';
import 'package:my_store/widgets/allegro_form_widgets/description_widgets/description_section_list.dart';
import 'package:my_store/widgets/allegro_form_widgets/description_widgets/section_widget.dart';
import 'package:zefyrka/zefyrka.dart';

class DescriptionPart extends StatefulWidget {
  final OfferModel myOffer;

  DescriptionPart({
    @required this.myOffer,
  });

  @override
  _DescriptionPartState createState() => _DescriptionPartState();
}

class _DescriptionPartState extends State<DescriptionPart> {
  bool image;
  bool twoPictures;
  bool article;
  bool textTrack;
  bool artTrack;
  NotusDocument newSectionText;
  String newFirstImageUrl;
  String newSecondImageUrl;

  @override
  void initState() {
    super.initState();
    newSectionText = NotusDocument();
    newSectionText.changes.listen((event) {
      print(event.change);
    });
    newFirstImageUrl = '';
    newSecondImageUrl = '';
    article = true;
    artTrack = false;
    textTrack = false;
    image = false;
    twoPictures = false;
  }



  @override
  void dispose() {
    super.dispose();
    newSectionText.close();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Opis',
            style: TextStyle(color: Color(0xFF89ACBE), fontSize: 18),
          ),
          DescriptionSectionList(
            myOffer: widget.myOffer,
          ),
          NewSection(
            doc: newSectionText,
            offerModel: widget.myOffer,
            secondImageUrl: newSecondImageUrl,
            firstImageUrl: newFirstImageUrl,
            text_track: textTrack,
            two_pictures: twoPictures,
            art_track: artTrack,
            article: article,
            image: image,
            setArtTrack: () {
              setArtTrack();
            },
            setTwoPictures: () {
              setTwoPictures();
            },
            setTextTrack: () {
              setTextTrack();
            },
            setArticle: () {
              setArticle();
            },
            setImage: () {
              setImage();
            },
            addFirstImage: (url) {
              setState(() {
                newFirstImageUrl = url;
              });
            },
            addSecondImage: (url) {
              setState(() {
                newSecondImageUrl = url;
              });
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: OutlinedButton(
                child: Text(
                  'Dodaj sekcję',
                  style: TextStyle(fontSize: 14),
                ),
                onPressed: () {
                  setState(() {
                    widget.myOffer.description.sections.add(Section());
                    String doc = NotusToHTML.notusToHtml(newSectionText);
                    widget.myOffer.description.sections.last.items = [];
                    if (article) {
                      widget.myOffer.description.sections.last.items.add(
                          Items_desc(type: 'TEXT', offer_description: doc));
                    } else if (image) {
                      widget.myOffer.description.sections.last.items
                          .add(Items_desc(type: 'IMAGE', url: newFirstImageUrl));
                    } else if (artTrack) {
                      widget.myOffer.description.sections.last.items
                          .add(Items_desc(type: 'IMAGE', url: newFirstImageUrl));
                      widget.myOffer.description.sections.last.items.add(
                          Items_desc(type: 'TEXT', offer_description: doc));
                    } else if (textTrack) {
                      widget.myOffer.description.sections.last.items.add(
                          Items_desc(type: 'TEXT', offer_description: doc));
                      widget.myOffer.description.sections.last.items
                          .add(Items_desc(type: 'IMAGE', url: newSecondImageUrl));
                    } else {
                      widget.myOffer.description.sections.last.items
                          .add(Items_desc(type: 'IMAGE', url: newFirstImageUrl));
                      widget.myOffer.description.sections.last.items
                          .add(Items_desc(type: 'IMAGE', url: newSecondImageUrl));
                    }
                    newSectionText.delete(0, newSectionText.length - 1);
                  });
                  //todo zlikwidować błąd
                  setArticle();
                  newFirstImageUrl = '';
                  newSecondImageUrl = '';
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  setArtTrack() {
    setState(() {
      article = false;
      artTrack = true;
      textTrack = false;
      image = false;
      twoPictures = false;
    });
  }

  setTwoPictures() {
    setState(() {
      article = false;
      artTrack = false;
      textTrack = false;
      image = false;
      twoPictures = true;
    });
  }

  setTextTrack() {
    setState(() {
      article = false;
      artTrack = false;
      textTrack = true;
      image = false;
      twoPictures = false;
    });
  }

  setArticle() {
    setState(() {
      article = true;
      artTrack = false;
      textTrack = false;
      image = false;
      twoPictures = false;
    });
  }

  setImage() {
    setState(() {
      article = false;
      artTrack = false;
      textTrack = false;
      image = true;
      twoPictures = false;
    });
  }

}
