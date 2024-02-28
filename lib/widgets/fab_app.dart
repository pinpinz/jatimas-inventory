import 'package:flutter/material.dart';

import '../utils/colors.dart';

class FabApp extends StatefulWidget {
  final Widget child;
  final List<FabAppItem> items;
  final void Function(bool isOpened)? onPress;

  const FabApp({
    Key? key,
    required this.child,
    this.items = const [],
    this.onPress,
  }) : super(key: key);

  @override
  State<FabApp> createState() => _FabAppState();
}

class _FabAppState extends State<FabApp> with TickerProviderStateMixin {
  AnimationController? _controller;
  bool _isOpened = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    if (_controller != null) _controller!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (_controller != null)
          ...List.generate(
            widget.items.length,
            (index) => buildFabApp(index),
          ),
        FloatingActionButton(
          backgroundColor: ColorApp.primary,
          child: widget.child,
          onPressed: () {
            if (_controller == null) return;

            if (_controller!.isDismissed) {
              _controller!.forward();
              setState(() {
                _isOpened = true;
              });
            } else {
              _controller!.reverse();
              setState(() {
                _isOpened = false;
              });
            }

            if (widget.onPress != null) {
              widget.onPress!(_isOpened);
            }
          },
        )
      ],
    );
  }

  Widget buildFabApp(int index) {
    final el = widget.items[index];

    return Container(
      height: 56,
      width: 56,
      alignment: FractionalOffset.topCenter,
      child: (_controller == null)
          ? null
          : ScaleTransition(
              scale: CurvedAnimation(
                parent: _controller!,
                curve: Interval(
                    0,
                    1 -
                        double.parse(index.toString()) /
                            widget.items.length /
                            2),
              ),
              child: FloatingActionButton(
                heroTag: 'fab-child-$index',
                backgroundColor: el.backgroundColor,
                mini: true,
                onPressed: el.onPress,
                child: el.child,
              ),
            ),
    );
  }
}

class FabAppItem {
  final Widget child;
  final Color? backgroundColor;
  final void Function() onPress;

  FabAppItem({
    required this.child,
    required this.onPress,
    this.backgroundColor = ColorApp.primary,
  });
}
