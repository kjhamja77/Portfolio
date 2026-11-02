import 'package:flutter/material.dart';

/// Subtle 3D tilt that follows the cursor (desktop).
class TiltOnHover extends StatefulWidget {
  final Widget child;
  final double maxAngle;

  const TiltOnHover({super.key, required this.child, this.maxAngle = 0.06});

  @override
  State<TiltOnHover> createState() => _TiltOnHoverState();
}

class _TiltOnHoverState extends State<TiltOnHover> {
  Offset _tilt = Offset.zero;

  void _onHover(PointerEvent e) {
    final size = context.size;
    if (size == null || size.width == 0 || size.height == 0) return;
    setState(() {
      _tilt = Offset(
        ((e.localPosition.dx / size.width) * 2 - 1).clamp(-1.0, 1.0),
        ((e.localPosition.dy / size.height) * 2 - 1).clamp(-1.0, 1.0),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: (_) => setState(() => _tilt = Offset.zero),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transformAlignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(-_tilt.dy * widget.maxAngle)
          ..rotateY(_tilt.dx * widget.maxAngle),
        child: widget.child,
      ),
    );
  }
}