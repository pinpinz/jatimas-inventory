import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TextApp extends StatelessWidget {
  final String text;
  final TextAlign align;
  final double size;
  final Color color;
  final FontWeight weight;
  final FontStyle style;
  final bool softWrap;
  final int? maxLines;
  final TextOverflow? overflow;

  const TextApp(
    this.text, {
    Key? key,
    this.align = TextAlign.start,
    this.size = 14,
    this.color = ColorApp.dark,
    this.weight = FontWeight.normal,
    this.style = FontStyle.normal,
    this.softWrap = true,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
      ),
      textAlign: align,
      softWrap: softWrap,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
