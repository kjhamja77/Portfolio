import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:myportfolio/utils/app_colors.dart';

/// Image frame with a slowly rotating gradient border.
class GlowRingFrame extends StatefulWidget {
  final double width;
  final double height;
  final Widget child;

  const GlowRingFrame({
    super.key,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  State<GlowRingFrame> createState() => _GlowRingFrameState();
}

class _GlowRingFrameState extends State<GlowRingFrame>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 7),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, child) => Container(
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: SweepGradient(
            transform: GradientRotation(_c.value * 2 * math.pi),
            colors: const [
              AppColors.purple,
              AppColors.blue,
              Color(0xFF030511),
              AppColors.purple,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.purple.withValues(alpha: 0.28),
              blurRadius: 45,
              spreadRadius: 2,
            ),
          ],
        ),
        child: child,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: widget.child,
      ),
    );
  }
}