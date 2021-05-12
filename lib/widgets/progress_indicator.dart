import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_go_to_another_screen/display_popup.dart';
import 'package:my_store/utlis/colors.dart';

class ProgressIndicatorMyStore extends StatelessWidget {
  const ProgressIndicatorMyStore({
    Key key,
    @required double progress,
    @required this.ifVisible,
  }) : _progress = progress, super(key: key);

  final double _progress;
  final bool ifVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(DisplayPopUp.downloadingImages
                ? 'Pobieranie zdjęć'
                : 'Zapisywanie tabeli'),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: LinearProgressIndicator(
              backgroundColor: Color(ColorsMyStore.AccentColor),
              value: _progress,
            ),
          ),
        ],
      ),
      visible: ifVisible,
    );
  }
}
