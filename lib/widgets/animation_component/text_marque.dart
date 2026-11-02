import 'package:flutter/material.dart';

import '../../main.dart';

/// Endless scrolling band of technologies.
class TechMarquee extends StatefulWidget {
  const TechMarquee({super.key});

  @override
  State<TechMarquee> createState() => _TechMarqueeState();
}

class _TechMarqueeState extends State<TechMarquee>
    with SingleTickerProviderStateMixin {
  static const _labels = [
    'Flutter', 'Kotlin', 'Firebase', 'REST APIs', 'Isar DB',
    'Bloc', 'Syncfusion', 'Stripe', 'Paytm', 'Crashlytics',
  ];
  static const double _itemW = 170;
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 28),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loop = _labels.length * _itemW;
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.white10),
        ),
      ),
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.centerLeft,
          minWidth: 0,
          maxWidth: double.infinity,
          child: AnimatedBuilder(
            animation: _c,
            builder: (_, child) => Transform.translate(
              offset: Offset(-_c.value * loop, 0),
              child: child,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int set = 0; set < 4; set++)
                  for (final l in _labels)
                    SizedBox(
                      width: _itemW,
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: kBrandGradient,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              l,
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}