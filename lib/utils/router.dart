import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/app/app.dart';
import 'package:task/screens/details/details_screen.dart';
import 'package:task/screens/screens.dart';
class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      case OtpPage.routeName:
        return MaterialPageRoute(
          builder: (context) => OtpPage(),
        );
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}
