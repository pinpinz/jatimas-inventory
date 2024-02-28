import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/helpers.dart';
import 'button_app.dart';

class ButtonYesNo extends StatelessWidget {
  final String titleYes, titleNo;
  final void Function()? onPressYes, onPressNo;
  final Color colorYes, colorNo;
  final Color bgColorYes, bgColorNo;
  final bool hideYes, hideNo;
  final int outline;
  final double textSize, height;

  const ButtonYesNo({
    Key? key,
    this.titleYes = 'Yes',
    this.titleNo = 'No',
    this.onPressYes,
    this.onPressNo,
    this.colorYes = ColorApp.light,
    this.colorNo = ColorApp.light,
    this.bgColorYes = ColorApp.primary,
    this.bgColorNo = ColorApp.danger,
    this.hideYes = false,
    this.hideNo = false,
    this.outline = 0,
    this.textSize = 12,
    this.height = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: (!hideNo && !hideYes)
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center,
      children: [
        if (!hideNo)
          ButtonApp(
            color: ([1, 3].contains(outline)) ? bgColorNo : colorNo,
            backgroundColor:
                ([1, 3].contains(outline)) ? Colors.transparent : bgColorNo,
            borderColor: bgColorNo,
            text: titleNo,
            textSize: textSize,
            width: screenWidth(context) * (hideYes ? 0.85 : 0.425),
            height: height,
            onTap: onPressNo,
          ),
        if (!hideYes)
          ButtonApp(
            color: ([2, 3].contains(outline)) ? bgColorYes : colorYes,
            backgroundColor:
                ([2, 3].contains(outline)) ? Colors.transparent : bgColorYes,
            borderColor: bgColorYes,
            text: titleYes,
            textSize: textSize,
            width: screenWidth(context) * (hideNo ? 0.85 : 0.425),
            height: height,
            onTap: onPressYes,
          ),
      ],
    );
  }
}
