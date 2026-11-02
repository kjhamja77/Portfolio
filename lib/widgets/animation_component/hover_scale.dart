import 'package:flutter/material.dart';

/// Smooth scale-up on mouse hover (buttons, icons, chips).
class HoverScale extends StatefulWidget {
  final Widget child;
  final double scale;

  const HoverScale({super.key, required this.child, this.scale = 1.08});

  @override
  State<HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<HoverScale> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: _hover ? widget.scale : 1,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutBack,
        child: widget.child,
      ),
    );
  }
}