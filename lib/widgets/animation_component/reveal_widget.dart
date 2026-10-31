import 'package:flutter/material.dart';
import 'package:myportfolio/widgets/animation_component/reveal_scope.dart';

/// Fades + slides its child in the first time it scrolls into view.
/// Use [Reveal.builder] when the child needs the 0..1 animation
/// (e.g. count-up numbers or growing underlines).
class Reveal extends StatefulWidget {
  final Widget? child;
  final Widget Function(BuildContext, Animation<double>)? builder;
  final Duration delay;
  final Duration duration;
  final RevealFrom from;
  final double distance;

  const Reveal({
    super.key,
    required Widget this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 800),
    this.from = RevealFrom.bottom,
    this.distance = 40,
  }) : builder = null;

  const Reveal.builder({
    super.key,
    required Widget Function(BuildContext, Animation<double>) this.builder,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 900),
    this.from = RevealFrom.bottom,
    this.distance = 40,
  }) : child = null;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _c =
  AnimationController(vsync: this, duration: widget.duration);
  late final Animation<double> _curve =
  CurvedAnimation(parent: _c, curve: Curves.easeOutCubic);
  ScrollController? _scroll;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _started = true;
      _c.value = 1;
      return;
    }
    final s = RevealScope.maybeOf(context);
    if (s != _scroll) {
      _scroll?.removeListener(_check);
      _scroll = s;
      _scroll?.addListener(_check);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (_started || !mounted) return;
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.attached || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    final h = MediaQuery.of(context).size.height;
    if (top < h * 0.92) {
      _started = true;
      _scroll?.removeListener(_check);
      Future.delayed(widget.delay, () {
        if (mounted) _c.forward();
      });
    }
  }

  @override
  void dispose() {
    _scroll?.removeListener(_check);
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inner =
    widget.builder != null ? widget.builder!(context, _c) : widget.child!;
    final off = switch (widget.from) {
      RevealFrom.bottom => Offset(0, widget.distance),
      RevealFrom.left => Offset(-widget.distance, 0),
      RevealFrom.right => Offset(widget.distance, 0),
      RevealFrom.none => Offset.zero,
    };
    return FadeTransition(
      opacity: _curve,
      child: AnimatedBuilder(
        animation: _curve,
        builder: (_, c) => Transform.translate(
          offset: Offset(
            off.dx * (1 - _curve.value),
            off.dy * (1 - _curve.value),
          ),
          child: c,
        ),
        child: inner,
      ),
    );
  }
}