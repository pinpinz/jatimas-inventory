import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widgets/svg_icon.dart';
import '../utils/enums.dart';

PreferredSizeWidget? stepperDocs(
    BuildContext context, SignType type, int step) {
  if (type == SignType.single) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: ColorApp.light),
              alignment: Alignment.center,
              child: SvgIcon(
                'Paper',
                color: step == 1
                    ? ColorApp.primary
                    : ColorApp.dark.withOpacity(0.8),
              ),
            ),
            Icon(Icons.chevron_right, color: ColorApp.light.withOpacity(0.5)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: ColorApp.light),
              alignment: Alignment.center,
              child: SvgIcon(
                'Edit',
                color: step == 3
                    ? ColorApp.primary
                    : ColorApp.dark.withOpacity(0.8),
              ),
            ),
            Icon(Icons.chevron_right, color: ColorApp.light.withOpacity(0.5)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: ColorApp.light),
              alignment: Alignment.center,
              child: SvgIcon(
                'Tick Square',
                color: step == 4
                    ? ColorApp.primary
                    : ColorApp.dark.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return PreferredSize(
    preferredSize: const Size.fromHeight(70),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorApp.light),
            alignment: Alignment.center,
            child: SvgIcon(
              'Paper',
              color:
                  step == 1 ? ColorApp.primary : ColorApp.dark.withOpacity(0.8),
            ),
          ),
          Icon(Icons.chevron_right, color: ColorApp.light.withOpacity(0.5)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorApp.light),
            alignment: Alignment.center,
            child: SvgIcon(
              'Add User',
              color:
                  step == 2 ? ColorApp.primary : ColorApp.dark.withOpacity(0.8),
            ),
          ),
          Icon(Icons.chevron_right, color: ColorApp.light.withOpacity(0.5)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorApp.light),
            alignment: Alignment.center,
            child: SvgIcon(
              'Edit',
              color:
                  step == 3 ? ColorApp.primary : ColorApp.dark.withOpacity(0.8),
            ),
          ),
          Icon(Icons.chevron_right, color: ColorApp.light.withOpacity(0.5)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ColorApp.light),
            alignment: Alignment.center,
            child: SvgIcon(
              'Tick Square',
              color:
                  step == 4 ? ColorApp.primary : ColorApp.dark.withOpacity(0.8),
            ),
          ),
        ],
      ),
    ),
  );
}
