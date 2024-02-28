import 'package:flutter/material.dart';

class NavigationList extends StatelessWidget {
  final String? title;
  final List<NavigationListItem> items;
  final double trailingWidth, itemHeight, itemBorder;
  final bool shrinkWrap, hideSeparator;
  final ScrollPhysics? physics;

  const NavigationList({
    Key? key,
    this.title,
    this.items = const [],
    this.trailingWidth = 20,
    this.itemHeight = 50,
    this.itemBorder = 0.5,
    this.shrinkWrap = true,
    this.hideSeparator = false,
    this.physics = const ClampingScrollPhysics(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.blueGrey.shade700,
    );

    final subTitleStyle = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: Colors.grey.shade500,
    );

    return ListView(
      padding: const EdgeInsets.all(0),
      shrinkWrap: shrinkWrap,
      physics: physics,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, bottom: 5),
            child: Text(
              title!,
              style: titleStyle,
            ),
          ),
        if (items.isNotEmpty)
          ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              var el = items[index];

              return InkWell(
                onTap: el.onRowTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: hideSeparator
                        ? null
                        : Border(
                            bottom: BorderSide(
                              width: itemBorder,
                              color: Colors.grey.shade200,
                            ),
                          ),
                  ),
                  child: Opacity(
                    opacity: el.disabled == true ? 0.3 : 1,
                    child: Row(
                      children: [
                        if (el.leading != null)
                          SizedBox(
                            width: 42,
                            child: el.leading,
                          ),
                        Expanded(
                          child: Container(
                            height: itemHeight,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (el.titleCustom == null)
                                    ? Text(
                                        el.title,
                                        style: titleStyle.copyWith(
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    : el.titleCustom!,
                                if (el.subtitle != null &&
                                    el.subtitleCustom == null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      el.subtitle ?? '-',
                                      style: subTitleStyle,
                                    ),
                                  ),
                                if (el.subtitle == null &&
                                    el.subtitleCustom != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: el.subtitleCustom,
                                  )
                              ],
                            ),
                          ),
                        ),
                        if (el.trailing != null)
                          SizedBox(
                            width: trailingWidth,
                            child: el.trailing,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
      ],
    );
  }
}

class NavigationListItem {
  final Widget? leading, trailing, titleCustom, subtitleCustom;
  final String title;
  final String? subtitle;
  final bool disabled;
  final void Function()? onRowTap;

  NavigationListItem({
    this.title = '',
    this.titleCustom,
    this.leading,
    this.trailing,
    this.subtitle,
    this.subtitleCustom,
    this.disabled = false,
    this.onRowTap,
  });
}
