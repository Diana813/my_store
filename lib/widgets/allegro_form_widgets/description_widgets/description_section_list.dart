import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/products/description/description_sections_items_desc.dart';
import 'package:my_store/action_create_offer/offer_model.dart';
import 'package:my_store/notus_doc_to_html/html_to_notus.dart';
import 'package:my_store/notus_doc_to_html/notus_to_html.dart';
import 'package:my_store/utils/colors.dart';
import 'package:my_store/utils/html_parser.dart';
import 'package:my_store/widgets/allegro_form_widgets/description_widgets/section_widget.dart';
import 'package:zefyrka/zefyrka.dart';

import '../../hover_widget.dart';

class DescriptionSectionList extends StatefulWidget {
  final OfferModel myOffer;

  DescriptionSectionList({
    @required this.myOffer,
  });

  @override
  _DescriptionSectionListState createState() => _DescriptionSectionListState();
}

class _DescriptionSectionListState extends State<DescriptionSectionList> {
  bool image;
  bool twoPictures;
  bool article;
  bool textTrack;
  bool artTrack;
  int editIndex;
  NotusDocument sectionToChangeText;
  String firstImageUrl;
  String secondImageUrl;

  getNotusDocument(int index) {
    if (article || textTrack) {
      return HtmlToNotus.htmlToNotus(widget
          .myOffer.description.sections[index].items[0].offer_description);
    } else if (artTrack) {
      return HtmlToNotus.htmlToNotus(widget
          .myOffer.description.sections[index].items[1].offer_description);
    } else {
      return sectionToChangeText;
    }
  }

  getImagesToEdit(int index) {
    if (twoPictures) {
      firstImageUrl = widget.myOffer.description.sections[index].items[0].url;
      secondImageUrl = widget.myOffer.description.sections[index].items[1].url;
    } else if (image || artTrack) {
      firstImageUrl = widget.myOffer.description.sections[index].items[0].url;
    } else if (textTrack) {
      secondImageUrl = widget.myOffer.description.sections[index].items[1].url;
    }
  }

  @override
  void initState() {
    super.initState();
    editIndex = -1;
    sectionToChangeText = NotusDocument();
    sectionToChangeText.changes.listen((event) {
      print(event.change);
    });
    firstImageUrl = '';
    secondImageUrl = '';
    article = true;
    artTrack = false;
    textTrack = false;
    image = false;
    twoPictures = false;
  }

  @override
  void dispose() {
    super.dispose();
    sectionToChangeText.close();
  }

  @override
  Widget build(BuildContext context) {
    return buildSectionsListView();
  }

  ListView buildSectionsListView() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: widget.myOffer.description.sections.isEmpty
          ? 0
          : widget.myOffer.description.sections.length,
      itemBuilder: (BuildContext context, int index) {
        return editIndex != index
            ? GestureDetector(
                onTap: () {
                  print('editIndex $editIndex');
                  if (editIndex != -1) {
                    if (article) {
                      widget.myOffer.description.sections[editIndex].items[0]
                              .offer_description =
                          NotusToHTML.notusToHtml(sectionToChangeText);
                      if (widget.myOffer.description.sections[editIndex].items
                              .length ==
                          2) {
                        widget.myOffer.description.sections[editIndex].items
                            .removeAt(1);
                      }
                    } else if (image) {
                      widget.myOffer.description.sections[editIndex].items[0]
                          .url = firstImageUrl;
                      if (widget.myOffer.description.sections[editIndex].items
                              .length ==
                          2) {
                        widget.myOffer.description.sections[editIndex].items
                            .removeAt(1);
                      }
                    } else if (artTrack) {
                      widget.myOffer.description.sections[editIndex].items[0]
                          .url = firstImageUrl;
                      if (widget.myOffer.description.sections[editIndex].items
                              .length <
                          2) {
                        widget.myOffer.description.sections[editIndex].items
                            .add(Items_desc(
                                type: 'TEXT',
                                offer_description: NotusToHTML.notusToHtml(
                                    sectionToChangeText)));
                      } else {
                        widget.myOffer.description.sections[editIndex].items[1]
                                .offer_description =
                            NotusToHTML.notusToHtml(sectionToChangeText);
                      }
                    } else if (textTrack) {
                      widget.myOffer.description.sections[editIndex].items[0]
                              .offer_description =
                          NotusToHTML.notusToHtml(sectionToChangeText);
                      if (widget.myOffer.description.sections[editIndex].items
                              .length <
                          2) {
                        widget.myOffer.description.sections[editIndex].items
                            .add(
                                Items_desc(type: 'IMAGE', url: secondImageUrl));
                      } else {
                        widget.myOffer.description.sections[editIndex].items[1]
                            .url = secondImageUrl;
                      }
                    } else {
                      widget.myOffer.description.sections[editIndex].items[0]
                          .url = firstImageUrl;
                      if (widget.myOffer.description.sections[editIndex].items
                              .length <
                          2) {
                        widget.myOffer.description.sections[editIndex].items
                            .add(
                                Items_desc(type: 'IMAGE', url: secondImageUrl));
                      } else {
                        widget.myOffer.description.sections[editIndex].items[1]
                            .url = secondImageUrl;
                      }
                    }
                    setState(() {
                      editIndex = -1;
                    });
                  } else {
                    getViewType(index);
                    setState(() {
                      editIndex = index;
                      if (getNotusDocument(index) != null) {
                        final doc = getNotusDocument(index).root.toDelta();
                        sectionToChangeText = NotusDocument.fromDelta(doc);
                      }
                      getImagesToEdit(index);
                    });
                  }
                },
                child: OnHover(
                  builder: (bool isHovered) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: isHovered
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(ColorsMyStore.AccentColor),
                                      spreadRadius: 1),
                                ],
                              )
                            : null,
                        child: Column(
                          children: [
                            Visibility(
                              visible: isHovered,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      widget.myOffer.description.sections
                                          .removeAt(index);
                                    },
                                    icon: Icon(Icons.delete),
                                    color: Color(ColorsMyStore.PrimaryColor),
                                  )
                                ],
                              ),
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: widget
                                                .myOffer
                                                .description
                                                .sections[index]
                                                .items[0]
                                                .type ==
                                            'TEXT'
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: MyHtmlParser.richText(
                                                  widget
                                                      .myOffer
                                                      .description
                                                      .sections[index]
                                                      .items[0]
                                                      .offer_description),
                                            ))
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                                widget
                                                    .myOffer
                                                    .description
                                                    .sections[index]
                                                    .items[0]
                                                    .url,
                                                fit: BoxFit.fill),
                                          ),
                                  ),
                                  widget.myOffer.description.sections[index]
                                              .items.length ==
                                          2
                                      ? Expanded(
                                          child: widget
                                                      .myOffer
                                                      .description
                                                      .sections[index]
                                                      .items[1]
                                                      .type ==
                                                  'TEXT'
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: MyHtmlParser
                                                        .richText(widget
                                                            .myOffer
                                                            .description
                                                            .sections[index]
                                                            .items[1]
                                                            .offer_description),
                                                  ))
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.network(
                                                      widget
                                                          .myOffer
                                                          .description
                                                          .sections[index]
                                                          .items[1]
                                                          .url,
                                                      fit: BoxFit.fill),
                                                ),
                                        )
                                      : Container(),
                                ]),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : NewSection(
                doc: sectionToChangeText,
                offerModel: widget.myOffer,
                secondImageUrl: secondImageUrl,
                firstImageUrl: firstImageUrl,
                text_track: textTrack,
                two_pictures: twoPictures,
                art_track: artTrack,
                article: article,
                image: image,
                setArtTrack: () {
                  setArtTrack(index);
                },
                setTwoPictures: () {
                  setTwoPictures(index);
                },
                setTextTrack: () {
                  setTextTrack(index);
                },
                setArticle: () {
                  setArticle(index);
                },
                setImage: () {
                  setImage(index);
                },
                addFirstImage: (url) {
                  setState(() {
                    firstImageUrl = url;
                  });
                },
                addSecondImage: (url) {
                  setState(() {
                    secondImageUrl = url;
                  });
                },
              );
      },
    );
  }

  getViewType(int index) {
    if (widget.myOffer.description.sections[index].items.length == 1) {
      if (widget.myOffer.description.sections[index].items[0].type == 'IMAGE') {
        image = true;
        twoPictures = false;
        article = false;
        textTrack = false;
        artTrack = false;
      } else {
        article = true;
        image = false;
        twoPictures = false;
        textTrack = false;
        artTrack = false;
      }
    } else {
      if (widget.myOffer.description.sections[index].items[0].type == 'IMAGE' &&
          widget.myOffer.description.sections[index].items[1].type == 'IMAGE') {
        twoPictures = true;
        image = false;
        article = false;
        textTrack = false;
        artTrack = false;
      } else if (widget.myOffer.description.sections[index].items[0].type ==
              'IMAGE' &&
          widget.myOffer.description.sections[index].items[1].type == 'TEXT') {
        artTrack = true;
        image = false;
        twoPictures = false;
        article = false;
        textTrack = false;
      } else {
        textTrack = true;
        image = false;
        twoPictures = false;
        article = false;
        artTrack = false;
      }
    }
  }

  setArtTrack(int index) {
    setState(() {
      final doc = sectionToChangeText.root.toDelta();
      sectionToChangeText = NotusDocument.fromDelta(doc);
      editIndex = index;
      article = false;
      artTrack = true;
      textTrack = false;
      image = false;
      twoPictures = false;
    });
  }

  setTwoPictures(int index) {
    setState(() {
      editIndex = index;
      article = false;
      artTrack = false;
      textTrack = false;
      image = false;
      twoPictures = true;
    });
  }

  setTextTrack(int index) {
    setState(() {
      final doc = sectionToChangeText.root.toDelta();
      sectionToChangeText = NotusDocument.fromDelta(doc);
      editIndex = index;
      article = false;
      artTrack = false;
      textTrack = true;
      image = false;
      twoPictures = false;
    });
  }

  setArticle(int index) {
    setState(() {
      final doc = sectionToChangeText.root.toDelta();
      sectionToChangeText = NotusDocument.fromDelta(doc);
      editIndex = index;
      article = true;
      artTrack = false;
      textTrack = false;
      image = false;
      twoPictures = false;
    });
  }

  setImage(int index) {
    setState(() {
      editIndex = index;
      article = false;
      artTrack = false;
      textTrack = false;
      image = true;
      twoPictures = false;
    });
  }
}
