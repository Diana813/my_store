import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/utils/colors.dart';
import 'package:my_store/widgets/raised_button_my_store.dart';

class PublishingPart extends StatelessWidget {
  final bool draftDoneVisibility;
  final Function publishDraft;
  final bool activeOfferDoneVisibility;
  final Function publishOffer;

  PublishingPart({
    @required this.draftDoneVisibility,
    @required this.publishDraft,
    @required this.activeOfferDoneVisibility,
    @required this.publishOffer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Visibility(
                child: Row(
                  children: [
                    Text('Utworzono draft', style: TextStyle(fontSize: 14)),
                    Icon(
                      Icons.done,
                      color: Color(ColorsMyStore.AccentColor),
                      size: 20,
                    ),
                  ],
                ),
                visible: draftDoneVisibility,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButtonMyStore(
                  paddingHorizontal: 50,
                  paddingVertical: 20,
                  onClick: publishDraft,
                  childWidget: Text(
                    'Utwórz szkic oferty',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  color: Color(ColorsMyStore.PrimaryColor),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Visibility(
                child: Row(
                  children: [
                    Text('Utworzono aktywną ofertę',
                        style: TextStyle(fontSize: 14)),
                    Icon(
                      Icons.done,
                      color: Color(ColorsMyStore.AccentColor),
                      size: 20,
                    ),
                  ],
                ),
                visible: activeOfferDoneVisibility,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButtonMyStore(
                  paddingHorizontal: 50,
                  paddingVertical: 20,
                  onClick: null/*publishOffer*/,
                  childWidget: Text(
                    'Wystaw aktywną ofertę',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  color: Color(ColorsMyStore.PrimaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
