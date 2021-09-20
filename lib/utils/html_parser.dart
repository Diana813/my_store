import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:flutter/cupertino.dart';

class MyHtmlParser {
  static List<Widget> richText(var text) {
    var data = parse(text.toString()).body;
    List<Widget> richTexts = [];
    if (data.nodes.isEmpty) return [];

    for (int i = 0; i < data.nodes.length; i++) {
      if (itsGivenNode(data.nodes[i].toString(), '<html h1>')) {
        richTexts.add(titleWidget(data.nodes[i].text));
      } else if (itsGivenNode(data.nodes[i].toString(), '<html h2>')) {
        richTexts.add(subtitleWidget(data.nodes[i].text));
      } else if (itsGivenNode(data.nodes[i].toString(), '<html p>')) {
        richTexts.add(paragraphWidget(data.nodes[i], data.nodes[i].text));
      } else if (itsGivenNode(data.nodes[i].toString(), '<html ol>')) {
        richTexts.add(numberedListWidget(data.nodes[i].nodes));
      } else if (itsGivenNode(data.nodes[i].toString(), '<html ul>')) {
        richTexts.add(bulletListWidget(data.nodes[i].nodes));
      } else if (itsGivenNode(data.nodes[i].toString(), '<html b>')) {
        richTexts.add(boldWidget(data.nodes[i].text));
      }
    }
    return richTexts;
  }

  static bool itsGivenNode(String text, String pattern) {
    if (text.contains(pattern)) {
      return true;
    }
    return false;
  }

  static Widget titleWidget(String title) {
    return Text(title,
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold));
  }

  static Widget subtitleWidget(String subtitle) {
    return Text(subtitle,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  }

  static Widget boldWidget(String text) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.bold));
  }

  static Widget paragraphWidget(var nodesList, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: nodesList.nodes.isEmpty
          ? Text(text)
          : RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                children: textSpanList(nodesList.nodes),
              ),
            ),
    );
  }

  static Widget bulletListWidget(var bulletPoints) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: bulletPoints.length,
        itemBuilder: (BuildContext context, int index) {
          return bulletPoints[index].nodes.isEmpty
              ? Text('• ' + bulletPoints[index].text)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('• '),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: textSpanList(bulletPoints[index].nodes),
                        ),
                      ),
                    ),
                  ],
                );
        });
  }

  static Widget numberedListWidget(var numberedPoints) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: numberedPoints.length,
        itemBuilder: (BuildContext context, int index) {
          return numberedPoints[index].nodes.isEmpty
              ? Text('• ' + numberedPoints[index])
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(index.toString() + '. '),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: textSpanList(numberedPoints[index].nodes),
                        ),
                      ),
                    ),
                  ],
                );
        });
  }

  static textSpanList(var pointsNodes) {
    List<TextSpan> list = [];
    for (int i = 0; i < pointsNodes.length; i++) {
      if (itsGivenNode(pointsNodes[i].toString(), '<html b>')) {
        list.add(TextSpan(
            text: pointsNodes[i].text,
            style: TextStyle(fontWeight: FontWeight.bold)));
      } else {
        list.add(TextSpan(text: pointsNodes[i].text));
      }
    }
    return list;
  }
}
