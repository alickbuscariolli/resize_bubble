import 'package:flutter/cupertino.dart';

class BubbleController {
  double height = 72; // FIGURE OUT THIS VALUE
  double width = 72; // FIGURE OUT THIS VALUE
  int maxLines = 3; // FIGURE OUT THIS VALUE

  bool hasAddedACharacter = false;

  final bubbleText = ValueNotifier<String>('Lorem');

  String get getBubbleText => bubbleText.value;

  void setBubbleText(String newBubbleText) => bubbleText.value = newBubbleText;

  /// To resize buble when input changes
  void resizeBubble(String newBubbleText) {
    hasAddedACharacter = newBubbleText.length > getBubbleText.length;
    setBubbleText(newBubbleText);

    // each letter occupies 8px of the width
    final textSpaceWithPadding =
        getBubbleText.length * 8 + 16; // 16 pixels for vertical padding

    // For the text to overflow (start growing width) 2 lines with 72px each we need 16 characteres
    // (8 each line). 16 * 8 + 16 = 144px
    if (textSpaceWithPadding >= 144 && width < 90 && height == 72) {
      if (hasAddedACharacter) {
        width = 90;
      } else {
        width = 72;
      }
    }
    // For the text to overflow 2 lines with 90px each (start growing width) we need 16 characteres
    // (8 each line). 18 * 8 + 16 = 196px
    else if (textSpaceWithPadding >= 196 &&
        width >= 90 &&
        height < 90 &&
        height >= 72) {
      if (hasAddedACharacter) {
        height = 90;
      } else {
        height = 72;
      }
    } else if (textSpaceWithPadding >= 320) {
      if (hasAddedACharacter) {
        if (width <= 194) {
          width += 4;
        }
      } else {
        if (width >= 90) {
          width -= 4;
          if (width < 90) {
            width = 90;
            height = 89;
          }
        }
      }
    }
  }
}
