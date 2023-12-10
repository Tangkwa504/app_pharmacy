import 'package:flutter/material.dart';

/// Widget that when use it will can't pop navigator  by pressing back button.
/// Need to call navigator pop by code only.
class WillNotPopScope extends StatelessWidget {
  final Widget child;

  WillNotPopScope({required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: child,
    );
  }
}
