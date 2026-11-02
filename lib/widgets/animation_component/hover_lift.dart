import 'package:flutter/material.dart';
import 'package:myportfolio/utils/app_colors.dart';

/// Card that lifts and glows on hover.
class HoverLift extends StatefulWidget {
  final Widget child;
  final BorderRadius borderRadius;
  final Color glow;
  final Color color;

  const HoverLift({
    super.key,
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.glow = AppColors.blue,
    this.color = const Color(0x0DFFFFFF),
  });

  @override
  State<HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<HoverLift> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        transformAlignment: Alignment.center,
        transform: Matrix4.translationValues(0, _hover ? -6 : 0, 0),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: widget.borderRadius,
          border: Border.all(
            color: _hover
                ? widget.glow.withValues(alpha: 0.7)
                : Colors.white12,
          ),
          boxShadow: [
            BoxShadow(
              color: _hover
                  ? widget.glow.withValues(alpha: 0.3)
                  : Colors.black26,
              blurRadius: _hover ? 28 : 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}