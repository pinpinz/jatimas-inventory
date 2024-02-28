import 'package:flutter/material.dart';

import '../utils/colors.dart';

Widget pagination(
  BuildContext context,
  int pages,
  int currentPage,
  void Function(int page)? onTap,
) {
  ScrollController scroll = ScrollController();
  var width = MediaQuery.of(context).size.width;
  if (pages > 5) width = MediaQuery.of(context).size.width - 160;

  if ((width / pages) > 40) {
    width = width / pages;
  } else {
    width = 40;
  }

  return Container(
    height: 30,
    alignment: Alignment.center,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (pages > 5)
          InkWell(
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 0.5,
                    color: ColorApp.dark.withOpacity(0.3),
                  ),
                ),
                color: ColorApp.dark.withOpacity(0.1),
              ),
              child: const Center(
                child:
                    Icon(Icons.skip_previous, size: 18, color: ColorApp.dark),
              ),
            ),
            onTap: () {
              onTap!(0);
              scroll.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),
        if (pages > 5)
          InkWell(
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 0.5,
                    color: ColorApp.dark.withOpacity(0.3),
                  ),
                ),
                color: ColorApp.dark.withOpacity(0.1),
              ),
              child: const Center(
                child: Icon(Icons.arrow_left, size: 22, color: ColorApp.dark),
              ),
            ),
            onTap: () {
              if (currentPage > 0) onTap!(currentPage - 1);
            },
          ),
        Expanded(
          child: ListView(
            controller: scroll,
            scrollDirection: Axis.horizontal,
            children: [
              for (var i = 0; i < pages; i++)
                InkWell(
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 0.5,
                          color: ColorApp.dark.withOpacity(0.3),
                        ),
                      ),
                      color: (i == currentPage)
                          ? ColorApp.danger.withOpacity(0.3)
                          : ColorApp.dark.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Text(
                        (i + 1).toString(),
                        style:
                            const TextStyle(color: ColorApp.dark, fontSize: 12),
                      ),
                    ),
                  ),
                  onTap: () {
                    onTap!(i);
                  },
                ),
            ],
          ),
        ),
        if (pages > 5)
          InkWell(
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 0.5,
                    color: ColorApp.dark.withOpacity(0.3),
                  ),
                ),
                color: ColorApp.dark.withOpacity(0.1),
              ),
              child: const Center(
                child: Icon(Icons.arrow_right, size: 22, color: ColorApp.dark),
              ),
            ),
            onTap: () {
              if (currentPage < (pages - 1)) onTap!(currentPage + 1);
            },
          ),
        if (pages > 5)
          InkWell(
            child: Container(
              width: 40,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 0.5,
                    color: ColorApp.dark.withOpacity(0.3),
                  ),
                ),
                color: ColorApp.dark.withOpacity(0.1),
              ),
              child: const Center(
                child: Icon(Icons.skip_next, size: 18, color: ColorApp.dark),
              ),
            ),
            onTap: () {
              onTap!(pages - 1);
              scroll.animateTo(
                (width * (pages - 1)),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),
      ],
    ),
  );
}
