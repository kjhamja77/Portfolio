import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:myportfolio/utils/app_colors.dart';

/// Soft colour orbs drifting behind the hero.
class AuroraBackground extends StatefulWidget {
  const AuroraBackground({super.key});

  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 14),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget _orb(Color color, double size, double t, double phase) {
    final a = t * 2 * math.pi + phase;
    return Align(
      alignment: Alignment(math.sin(a) * 0.9, math.cos(a * 0.8) * 0.7),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withValues(alpha: 0.28), Colors.transparent],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ClipRect(
        child: AnimatedBuilder(
          animation: _c,
          builder: (_, __) => Stack(
            children: [
              Positioned.fill(child: _orb(AppColors.purple, 520, _c.value, 0)),
              Positioned.fill(child: _orb(AppColors.blue, 460, _c.value, 2.1)),
              Positioned.fill(
                child: _orb(const Color(0xFF3AA0FF), 380, _c.value, 4.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}