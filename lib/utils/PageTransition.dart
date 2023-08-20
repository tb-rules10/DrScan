import 'package:flutter/material.dart';

class SlideLeftPageRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  SlideLeftPageRoute({required this.builder})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

class SlideRightPageRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  SlideRightPageRoute({required this.builder})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

class FadePageRouteBuilder extends PageRouteBuilder {
  final WidgetBuilder builder;

  FadePageRouteBuilder({required this.builder})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var fadeTween = Tween<double>(begin: 0.0, end: 1.0);
      var fadeAnimation = fadeTween.animate(animation);

      return FadeTransition(opacity: fadeAnimation, child: child);
    },
  );
}