import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

final DateTime initDateTime = DateTime.now();
final DateTime firstDateTime = DateTime(1950);
final DateTime lastDateTime = DateTime(initDateTime.year + 10);

final emailMaskRegExp = RegExp('^(.)(.*?)([^@]?)(?=@[^@]+\$)');

final String noImage = getImage('no-image.jpg');
final String profilePicture = getImage('user.png');

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenWidth(BuildContext context) {
  return screenSize(context).width;
}

double screenHeight(BuildContext context) {
  return screenSize(context).height;
}

String getImage(String name) {
  return path.join('assets', 'images', name);
}

Object? getPayload(BuildContext context) {
  return ModalRoute.of(context)!.settings.arguments;
}

String formatDate(DateTime dateTime, String format, {String? locale}) {
  return DateFormat(format, locale ?? 'id').format(dateTime);
}

String formatCurrency(double amount,
    {String? locale, String? symbol = '', int? decimalDigits = 0}) {
  var nf = NumberFormat.currency(
      locale: locale, decimalDigits: decimalDigits, symbol: symbol);

  return nf.format(amount);
}

String emailMasking(String input, [int minFill = 4, String fillChar = '*']) {
  return input.replaceFirstMapped(emailMaskRegExp, (m) {
    var start = m.group(1);
    var middle = fillChar * max(minFill, m.group(2)!.length);
    var end = m.groupCount >= 3 ? m.group(3) : start;
    return start! + middle + end!;
  });
}

String emailMasking2(String input) {
  var start = input.substring(0, 1);
  var middle =
      input.substring(1, input.length - 3).replaceAll(RegExp('[^@]'), '*');
  var end = input.substring(input.length - 3);
  return start + middle + end;
}

String uint8ListToBase64(Uint8List uint8List) {
  return base64Encode(uint8List);
}

Uint8List base64ToUint8List(String base64String) {
  return base64Decode(base64String);
}

Future<ui.Image> bytesToImage(Uint8List imgBytes) async {
  ui.Codec codec = await ui.instantiateImageCodec(imgBytes);
  ui.FrameInfo frame = await codec.getNextFrame();
  return frame.image;
}

Future<ui.Image> parseImage(Uint8List image, int width, int height) async {
  final ui.ImageDescriptor descriptor = ui.ImageDescriptor.raw(
    await ui.ImmutableBuffer.fromUint8List(image),
    width: width,
    height: height,
    pixelFormat: ui.PixelFormat.rgba8888,
  );

  return (await (await descriptor.instantiateCodec()).getNextFrame()).image;
}
