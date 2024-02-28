import 'package:flutter/material.dart';

import '../utils/colors.dart';

class BackgroundShape extends StatelessWidget {
  final double height;
  final Color? shapeColor;

  const BackgroundShape({
    Key? key,
    this.height = 400,
    this.shapeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 1,
          child: ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: height,
              color: (shapeColor != null)
                  ? shapeColor
                  : const Color.fromARGB(255, 14, 15, 15),
            ),
          ),
        ),
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: height + 30,
              color: (shapeColor != null) ? shapeColor : ColorApp.info,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height - 170);
    path.quadraticBezierTo(width / 2, height, width, height - 170);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
