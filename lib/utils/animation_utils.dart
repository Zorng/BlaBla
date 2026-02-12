import 'package:flutter/material.dart';

class NavigationAnimation {
  static Route<T> bottomToTopNavigation<T>(Widget screen) {
    const Offset begin = Offset(0.0, 1.0);
    const Offset end = Offset(0.0, 0.0);
    return _createAnimatedRoute(screen, begin, end);
  }

  static Route<T> leftToRightNavigation<T>(Widget screen) {
    const Offset begin = Offset(-1.0, 0);
    const Offset end = Offset(0.0, 0.0);
    return _createAnimatedRoute(screen, begin, end);
  }


  static PageRouteBuilder<T> _createAnimatedRoute<T>(
      Widget screen, Offset begin, Offset end) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

 
}
