import 'package:flutter/material.dart';

class AppBody extends StatelessWidget {
  final Widget child;
  final double horizontalPadding;

  const AppBody({super.key, required this.child, this.horizontalPadding = 24});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: child,
    );
  }
}
