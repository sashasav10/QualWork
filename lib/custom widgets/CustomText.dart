import 'package:flutter/material.dart';

// Custom text widget
class CustomText extends StatelessWidget {
  String title;
  double fontSize;
  FontWeight fontWeight;
  Color color;
  int maxLines;
  TextAlign textAlign;
  CustomText({
    Key? key,
    this.title = '',
    this.fontSize = 15,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w400,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      textAlign: textAlign,
      textScaleFactor: 1.0,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: 1.15,
      ),
    );
  }
}
