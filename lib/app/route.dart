import 'package:aplikasi_catatan/view/home.dart';
import 'package:aplikasi_catatan/view/login.dart';
import 'package:aplikasi_catatan/view/register.dart';
import 'package:aplikasi_catatan/view/note/write_note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AppRoute {
  static Route<dynamic> routes(RouteSettings settings) {
    // final args = (settings.arguments as Map?) ?? {};
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      case RegisterPage.routeName:
        return CupertinoPageRoute(
          builder: (_) => const RegisterPage(),
          settings: settings,
        );
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case WriteNote.routeName:
        return CupertinoPageRoute(
          builder: (_) => const WriteNote(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(child: Text('Page not found :(')),
            );
          },
        );
    }
  }
}
