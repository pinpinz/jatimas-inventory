import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart' as path;

class SvgIcon extends StatelessWidget {
  final String name;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  const SvgIcon(
    this.name, {
    Key? key,
    this.color,
    this.margin,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);

    return Container(
      padding: margin,
      child: SvgPicture.asset(
        path.join('assets', 'icons', '$name.svg'),
        color: color ?? iconTheme.color,
        width: width,
        height: height,
      ),
    );
  }
}
