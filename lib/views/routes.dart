import 'package:jatimasinventory/views/menu/releasebarang.dart';
import 'package:jatimasinventory/views/menu/releasepicking.dart';
import 'package:jatimasinventory/views/menu/returbarang.dart';
import 'package:jatimasinventory/views/menu/picking.dart';
import 'package:flutter/material.dart';
import 'auth/login_screen.dart';

class Routes {
  Routes._();
  static const String login = '/login';
  static const String scanpicking = '/scanbebas';
  static const String releasepicking = '/scanrelease';
  static const String returpicking = '/scanretur';
  static const String cobascan = '/cobaScan';

  static final Map<String, Widget> apps = {
    scanpicking: const scanBebas(),
    cobascan: const cobaScan(),
    releasepicking: const ScanRelease(),
    returpicking: const ScanRetur(),
    login: const LoginScreen(),
  };

  static final Map<String, Widget Function(BuildContext)> routes =
      apps.map((key, value) => MapEntry(key, (BuildContext context) => value));
}
