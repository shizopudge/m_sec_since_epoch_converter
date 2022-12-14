import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  const Responsive({
    Key? key,
    required this.child,
    required this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
        ),
        child: child,
      ),
    );
  }
}
