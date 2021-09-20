import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/utils/colors.dart';
import 'package:zefyrka/zefyrka.dart';

class Item extends StatefulWidget {
  final NotusDocument doc;

  Item({@required this.doc});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  ZefyrController controller;
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    controller = ZefyrController(widget.doc);
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.doc.toPlainText());
    if (widget.doc.toPlainText().isEmpty) {
      setState(() {
        controller.replaceText(0, controller.document.length - 1, '');
      });
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(vertical: 8),
              height: 30,
              child: ZefyrToolbar.basic(
                controller: controller,
                hideItalicButton: true,
                hideCodeBlock: true,
                hideQuote: true,
                hideStrikeThrough: true,
                hideHorizontalRule: true,
                hideUnderLineButton: true,
                hideLink: true,
              )),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(ColorsMyStore.AccentColor), spreadRadius: 1),
                ],
              ),
              child: ZefyrEditor(
                padding: EdgeInsets.all(8),
                controller: controller,
                autofocus: true,
                focusNode: focusNode,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
