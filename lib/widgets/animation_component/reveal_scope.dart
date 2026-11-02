import 'package:flutter/material.dart';

/// Gives every [Reveal] below it access to the page scroll controller.
class RevealScope extends InheritedWidget {
  final ScrollController controller;

  const RevealScope({
    super.key,
    required this.controller,
    required super.child,
  });

  static ScrollController? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<RevealScope>()?.controller;

  @override
  bool updateShouldNotify(RevealScope oldWidget) =>
      controller != oldWidget.controller;
}

enum RevealFrom { bottom, left, right, none }