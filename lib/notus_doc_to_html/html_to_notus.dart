import 'package:html/parser.dart';
import 'package:zefyrka/zefyrka.dart';

class HtmlToNotus {
  static NotusDocument htmlToNotus(var text) {
    var data = parse(text.toString()).body;
    if (data.nodes.isEmpty) return null;
    final document = NotusDocument();
    document.replace(0, document.length, '');
    for (int i = 0; i < data.nodes.length; i++) {
      if (itsGivenNode(data.nodes[i].toString(), '<html h1>')) {
        LineNode line = LineNode();
        line.add(LeafNode(data.nodes[i].text.replaceAll('\n', '')));
        line.applyAttribute(NotusAttribute.h1);
        document.root.add(line);
      } else if (itsGivenNode(data.nodes[i].toString(), '<html h2>')) {
        LineNode line = LineNode();
        line.add(LeafNode(data.nodes[i].text.replaceAll('\n', '')));
        line.applyAttribute(NotusAttribute.h2);
        document.root.add(line);
      } else if (itsGivenNode(data.nodes[i].toString(), '<html p>')) {
        LineNode line = LineNode();
        line = _formatParagraph(data.nodes[i]);
        document.root.add(line);
      } else if (itsGivenNode(data.nodes[i].toString(), '<html ul>')) {
        BlockNode block = BlockNode();
        block = _formatBlock(data.nodes[i], NotusAttribute.block.bulletList);
        document.root.add(block);
      } else if (itsGivenNode(data.nodes[i].toString(), '<html ol>')) {
        BlockNode block = BlockNode();
        block = _formatBlock(data.nodes[i], NotusAttribute.block.numberList);
        document.root.add(block);
      }
    }
    return document;
  }

  static bool itsGivenNode(String text, String pattern) {
    if (text.contains(pattern)) {
      return true;
    }
    return false;
  }

  static _formatParagraph(var line) {
    LineNode lineNode = LineNode();
    for (int j = 0; j < line.nodes.length; j++) {
      LeafNode leaf = LeafNode(line.nodes[j].text.replaceAll('\n', ''));
      if (itsGivenNode(line.nodes[j].toString(), '<html b>')) {
        leaf.applyAttribute(NotusAttribute.bold);
        lineNode.add(leaf);
      } else {
        lineNode.add(leaf);
      }
    }
    return lineNode;
  }

  static _formatBlock(var line, NotusAttribute attribute) {
    BlockNode block = BlockNode();
    block.applyAttribute(attribute);
    for (int j = 0; j < line.nodes.length; j++) {
      if (itsGivenNode(line.nodes[j].toString(), '<html li>')) {
        LineNode lineNode = LineNode();
        lineNode = _formatParagraph(line.nodes[j]);
        block.add(lineNode);
      }
    }
    return block;
  }
}
