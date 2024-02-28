import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'text_app.dart';

class ButtonApp extends StatelessWidget {
  final String? text, imageAsset;
  final double textSize, iconSize, width, height, gap, radius;
  final IconData? icon;
  final Color color, backgroundColor, borderColor;
  final void Function()? onTap;
  final MainAxisAlignment alignment;
  final EdgeInsets? margin, padding;

  const ButtonApp({
    Key? key,
    this.text,
    this.textSize = 16,
    this.icon,
    this.iconSize = 20,
    this.imageAsset,
    this.color = ColorApp.light,
    this.backgroundColor = ColorApp.btninv,
    this.borderColor = ColorApp.btninv,
    this.width = 80,
    this.height = 50,
    this.onTap,
    this.alignment = MainAxisAlignment.center,
    this.gap = 0,
    this.margin,
    this.padding,
    this.radius = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: (onTap != null) ? borderColor : Colors.grey,
            width: 1,
          ),
          color: (onTap != null) ? backgroundColor : Colors.grey,
        ),
        child: Row(
          mainAxisAlignment: alignment,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: color,
                size: iconSize,
              ),
            SizedBox(width: gap),
            if (text != null)
              TextApp(
                text.toString(),
                color: color,
                size: textSize,
                weight: FontWeight.w500,
              ),
            SizedBox(width: gap),
            if (imageAsset != null) Image.asset(imageAsset.toString()),
          ],
        ),
      ),
    );
  }
}
