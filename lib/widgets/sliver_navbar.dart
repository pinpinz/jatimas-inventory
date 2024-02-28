import 'package:flutter/material.dart';

import '../utils/colors.dart';

class SliverNavBar extends StatelessWidget {
  final dynamic title, titleCollapsed;
  final Color color, colorOffset, bgColor, bgColorOffset;
  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? actions;
  final double? expandedHeight, collapsedHeight;
  final Widget? background;
  final bool snap;
  final PreferredSizeWidget? bottom;
  final bool automaticallyImplyLeading;

  const SliverNavBar({
    Key? key,
    this.title,
    this.titleCollapsed,
    this.color = Colors.white,
    this.colorOffset = Colors.white,
    this.bgColor = ColorApp.info,
    this.bgColorOffset = ColorApp.info,
    this.leading,
    this.leadingWidth,
    this.actions,
    this.expandedHeight = 56,
    this.collapsedHeight = 56,
    this.background,
    this.snap = false,
    this.bottom,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (BuildContext context, constraints) {
        final offset = constraints.scrollOffset > 0;

        return SliverAppBar(
          title: (title is String)
              ? AnimatedSwitcher(
                  duration: const Duration(milliseconds: 0),
                  child: Text(
                    title.toString(),
                    style: TextStyle(
                      color: offset ? colorOffset : color,
                      fontSize: 18,
                    ),
                  ),
                )
              : title,
          backgroundColor: offset ? bgColorOffset : bgColor,
          elevation: 0,
          iconTheme: IconThemeData(color: offset ? colorOffset : color),
          leading: leading,
          leadingWidth: leadingWidth,
          actions: actions,
          pinned: true,
          snap: snap,
          floating: false,
          expandedHeight: expandedHeight,
          collapsedHeight: collapsedHeight,
          flexibleSpace: FlexibleSpaceBar(
            title: (titleCollapsed is String)
                ? Text(titleCollapsed.toString())
                : titleCollapsed,
            background: background,
          ),
          bottom: bottom,
          automaticallyImplyLeading: automaticallyImplyLeading,
        );
      },
    );
  }
}
