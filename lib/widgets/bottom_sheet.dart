import 'package:flutter/material.dart';

showBottomSheetApp(
  BuildContext context, {
  String? title,
  bool dissmissible = true,
  bool titleSeparator = true,
  List<Widget> contents = const [],
}) {
  showModalBottomSheet(
    context: context,
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: dissmissible,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Wrap(
          children: [
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 12),
                  decoration: !titleSeparator
                      ? null
                      : BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 0.5,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (title != null)
                          ? Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            )
                          : Container(),
                      InkWell(
                        child: const Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 18,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
                ...contents
              ],
            )
          ],
        ),
      );
    },
  );
}
