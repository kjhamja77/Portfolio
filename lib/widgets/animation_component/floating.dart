import 'package:flutter/material.dart';

/// Slow up/down floating motion.
class Floating extends StatefulWidget {
  final Widget child;
  final double amplitude;

  const Floating({super.key, required this.child, this.amplitude = 10});

  @override
  State<Floating> createState() => _FloatingState();
}

class _FloatingState extends State<Floating>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, child) => Transform.translate(
        offset: Offset(
          0,
          (Curves.easeInOut.transform(_c.value) - 0.5) * 2 * widget.amplitude,
        ),
        child: child,
      ),
      child: widget.child,
    );
  }
}