import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class ImageApp extends StatelessWidget {
  final String name;
  final double? width;
  final double? height;

  const ImageApp(
    this.name, {
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(path.join('assets', 'images', name),
        width: width, height: height);
  }
}
