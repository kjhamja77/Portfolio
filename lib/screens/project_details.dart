import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../utils/app_colors.dart';
import '../widgets/animation_component/auro_background.dart';
import '../widgets/animation_component/floating.dart';
import '../widgets/animation_component/hover_lift.dart';
import '../widgets/animation_component/hover_scale.dart';
import '../widgets/animation_component/reveal_scope.dart';
import '../widgets/animation_component/reveal_widget.dart';


class ProjectDetailsPage extends StatefulWidget {
  final String projectName;
  final String description;
  final String tagline;
  final String logoPath;
  final List<dynamic> screenshots;
  final List<String> techStack;
  final String? playstoreUrl; // shown only when a valid link is passed
  final String? appstoreUrl;

  const ProjectDetailsPage({
    super.key,
    required this.projectName,
    required this.tagline,
    required this.description,
    required this.logoPath,
    required this.screenshots,
    required this.techStack,
    this.playstoreUrl,
    this.appstoreUrl,
  });

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  static const double _shotW = 230;
  static const double _shotGap = 20;
  static const double _shotStep = _shotW + _shotGap;

  final ScrollController _page = ScrollController();
  final ScrollController _shots = ScrollController();
  final ValueNotifier<double> _progress = ValueNotifier(0);
  final ValueNotifier<bool> _showBarTitle = ValueNotifier(false);
  final ValueNotifier<int> _shotIndex = ValueNotifier(0);

  late final List<String> _images =
  widget.screenshots.map((e) => e.toString()).toList();
  bool _precached = false;

  @override
  void initState() {
    super.initState();
    _page.addListener(_onPage);
    _shots.addListener(_onShots);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_precached) return;
    _precached = true;
    for (final path in _images) {
      precacheImage(AssetImage(path), context);
    }
  }

  @override
  void dispose() {
    _page.removeListener(_onPage);
    _shots.removeListener(_onShots);
    _page.dispose();
    _shots.dispose();
    _progress.dispose();
    _showBarTitle.dispose();
    _shotIndex.dispose();
    super.dispose();
  }

  void _onPage() {
    if (!_page.hasClients) return;
    final p = _page.position;
    _progress.value =
    p.maxScrollExtent > 0 ? (p.pixels / p.maxScrollExtent) : 0;
    _showBarTitle.value = p.pixels > 200;
  }

  void _onShots() {
    if (!_shots.hasClients || _images.isEmpty) return;
    _shotIndex.value =
        (_shots.offset / _shotStep).round().clamp(0, _images.length - 1);
  }

  void _scrollShots(int dir) {
    if (!_shots.hasClients) return;
    final max = _shots.position.maxScrollExtent;
    _shots.animateTo(
      (_shots.offset + dir * 2 * _shotStep).clamp(0.0, max),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  void _jumpToShot(int i) {
    if (!_shots.hasClients) return;
    final max = _shots.position.maxScrollExtent;
    _shots.animateTo(
      (i * _shotStep).clamp(0.0, max),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  void _openViewer(int index) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Screenshot',
      barrierColor: Colors.black87,
      transitionDuration: const Duration(milliseconds: 350),
      transitionBuilder: (ctx, anim, _, child) => FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1).animate(
            CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
          ),
          child: child,
        ),
      ),
      pageBuilder: (ctx, _, __) =>
          _ScreenshotViewer(images: _images, initial: index),
    );
  }

  bool get _hasPlay => (widget.playstoreUrl ?? '').isNotEmpty;
  bool get _hasApple => (widget.appstoreUrl ?? '').isNotEmpty;

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Widget _storeButton({
    required IconData icon,
    required Color iconColor,
    required String small,
    required String big,
    required String url,
  }) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: const BorderSide(color: Colors.white38),
    );
    return Tooltip(
      message: big,
      child: HoverScale(
        scale: 1.06,
        child: Material(
          color: Colors.black,
          shape: shape,
          child: InkWell(
            customBorder: shape,
            onTap: () => _openUrl(url),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: iconColor, size: 32),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        small,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          letterSpacing: 0.6,
                        ),
                      ),
                      Text(
                        big,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────────── BUILD ─────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A23),
      body: LayoutBuilder(
        builder: (context, c) {
          final mobile = c.maxWidth < 700;
          final hPad = mobile ? 20.0 : 40.0;
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Color(0xFF0A0A23)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              const Positioned.fill(child: AuroraBackground()),
              RevealScope(
                controller: _page,
                child: SingleChildScrollView(
                  controller: _page,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(hPad, 110, hPad, 60),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _header(mobile),
                            if (_images.isNotEmpty) ...[
                              const SizedBox(height: 56),
                              _heading('Screenshots'),
                              const SizedBox(height: 12),
                              _carousel(c.maxWidth),
                            ],
                            const SizedBox(height: 48),
                            _heading('About this project'),
                            const SizedBox(height: 22),
                            _overview(c.maxWidth - hPad * 2),
                            if (widget.techStack.isNotEmpty) ...[
                              const SizedBox(height: 56),
                              _heading('Technologies & Tools'),
                              const SizedBox(height: 24),
                              _techGrid(),
                            ],
                            const SizedBox(height: 70),
                            _footerCta(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _topBar(mobile),
            ],
          );
        },
      ),
    );
  }

  // ───────────────────────── TOP BAR ─────────────────────────
  Widget _topBar(bool mobile) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            color: Colors.black.withValues(alpha: 0.4),
            child: SafeArea(
              bottom: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        HoverScale(
                          scale: 1.05,
                          child: Material(
                            color: Colors.white.withValues(alpha: 0.08),
                            shape: const StadiumBorder(
                              side: BorderSide(color: Colors.white24),
                            ),
                            child: InkWell(
                              customBorder: const StadiumBorder(),
                              onTap: () => Navigator.pop(context),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: mobile ? 12 : 18,
                                  vertical: 10,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.arrow_back_rounded,
                                        color: Colors.white, size: 20),
                                    if (!mobile) ...[
                                      const SizedBox(width: 8),
                                      const Text('Back to projects',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ValueListenableBuilder<bool>(
                            valueListenable: _showBarTitle,
                            builder: (_, show, __) => AnimatedSlide(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              offset: Offset(0, show ? 0 : 0.6),
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: show ? 1 : 0,
                                child: Text(
                                  widget.projectName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder<double>(
                    valueListenable: _progress,
                    builder: (_, p, __) => Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: p.clamp(0.0, 1.0),
                        child: Container(
                          height: 3,
                          decoration:
                          const BoxDecoration(gradient: kBrandGradient),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────────── HEADER ─────────────────────────
  Widget _header(bool mobile) {
    final logoSize = mobile ? 120.0 : 160.0;

    final logo = Reveal(
      from: RevealFrom.none,
      duration: const Duration(milliseconds: 1000),
      child: Floating(
        amplitude: 7,
        child: Container(
          width: logoSize,
          height: logoSize,
          padding: EdgeInsets.all(mobile ? 14 : 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: AppColors.purple.withValues(alpha: 0.45),
                blurRadius: 50,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Image.asset(widget.logoPath, fit: BoxFit.contain),
        ),
      ),
    );

    final info = Column(
      crossAxisAlignment:
      mobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Reveal(
          delay: const Duration(milliseconds: 150),
          child: ShaderMask(
            shaderCallback: (r) => const LinearGradient(
              colors: [Colors.white, Color(0xFFB9C3FF)],
            ).createShader(r),
            child: Text(
              widget.projectName,
              textAlign: mobile ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: mobile ? 34 : 54,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
                height: 1.1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Reveal(
          delay: const Duration(milliseconds: 300),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              widget.tagline,
              textAlign: mobile ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                color: AppColors.muted,
                fontSize: mobile ? 16 : 19,
                height: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 22),
        Reveal(
          delay: const Duration(milliseconds: 450),
          child: Wrap(
            alignment: mobile ? WrapAlignment.center : WrapAlignment.start,
            spacing: 12,
            runSpacing: 12,
            children: [
              if (_images.isNotEmpty)
                _miniStat(Icons.phone_android_rounded, _images.length, 'Screens'),
              _miniStat(Icons.layers_rounded, widget.techStack.length,
                  'Technologies'),
              _miniStat(Icons.flutter_dash, 1, 'Flutter build'),
            ],
          ),
        ),
        if (_hasPlay || _hasApple) ...[
          const SizedBox(height: 22),
          Reveal(
            delay: const Duration(milliseconds: 600),
            child: Wrap(
              alignment: mobile ? WrapAlignment.center : WrapAlignment.start,
              spacing: 14,
              runSpacing: 12,
              children: [
                if (_hasPlay)
                  _storeButton(
                    icon: Icons.play_arrow_rounded,
                    iconColor: const Color(0xFF3DDC84),
                    small: 'GET IT ON',
                    big: 'Google Play',
                    url: widget.playstoreUrl!,
                  ),
                if (_hasApple)
                  _storeButton(
                    icon: Icons.apple,
                    iconColor: Colors.white,
                    small: 'DOWNLOAD ON THE',
                    big: 'App Store',
                    url: widget.appstoreUrl!,
                  ),
              ],
            ),
          ),
        ],
      ],
    );

    return mobile
        ? Column(children: [logo, const SizedBox(height: 26), info])
        : Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [logo, const SizedBox(width: 40), Expanded(child: info)],
    );
  }

  Widget _miniStat(IconData icon, int target, String label) {
    return Reveal.builder(
      from: RevealFrom.none,
      builder: (context, anim) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: AppColors.blue),
            const SizedBox(width: 8),
            AnimatedBuilder(
              animation: anim,
              builder: (_, __) => Text(
                '${(target * Curves.easeOutCubic.transform(anim.value)).round()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  // ───────────────────────── SECTION HEADING ─────────────────────────
  Widget _heading(String title) {
    return Reveal.builder(
      from: RevealFrom.left,
      distance: 30,
      builder: (context, anim) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          AnimatedBuilder(
            animation: anim,
            builder: (_, __) => Container(
              height: 3,
              width: 70 * Curves.easeOut.transform(anim.value),
              decoration: BoxDecoration(
                gradient: kBrandGradient,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── SCREENSHOTS ─────────────────────────
  Widget _carousel(double screenW) {
    final showArrows = screenW >= 700 && _images.length > 1;
    return Column(
      children: [
        SizedBox(
          height: 530,
          child: Stack(
            children: [
              ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  scrollbars: false,
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.trackpad,
                  },
                ),
                child: ListView.builder(
                  controller: _shots,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  itemCount: _images.length,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.only(right: _shotGap),
                    child: Reveal(
                      delay: Duration(milliseconds: (i < 5 ? i : 5) * 110),
                      distance: 50,
                      child: _ShotCard(
                        path: _images[i],
                        width: _shotW,
                        onTap: () => _openViewer(i),
                      ),
                    ),
                  ),
                ),
              ),
              if (showArrows) _arrow(left: true),
              if (showArrows) _arrow(left: false),
            ],
          ),
        ),
        const SizedBox(height: 6),
        _dots(),
      ],
    );
  }

  Widget _arrow({required bool left}) {
    return AnimatedBuilder(
      animation: _shots,
      builder: (_, __) {
        bool show;
        if (_shots.hasClients && _shots.position.hasContentDimensions) {
          final p = _shots.position;
          show = left ? p.pixels > 4 : p.pixels < p.maxScrollExtent - 4;
        } else {
          show = !left;
        }
        return Positioned(
          left: left ? 0 : null,
          right: left ? null : 0,
          top: 0,
          bottom: 0,
          child: Center(
            child: IgnorePointer(
              ignoring: !show,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: show ? 1 : 0,
                child: HoverScale(
                  child: Material(
                    color: Colors.black.withValues(alpha: 0.65),
                    shape: const CircleBorder(
                      side: BorderSide(color: Colors.white24),
                    ),
                    child: IconButton(
                      icon: Icon(
                        left
                            ? Icons.chevron_left_rounded
                            : Icons.chevron_right_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () => _scrollShots(left ? -1 : 1),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _dots() {
    if (_images.length < 2) return const SizedBox.shrink();
    return ValueListenableBuilder<int>(
      valueListenable: _shotIndex,
      builder: (_, current, __) => Column(
        children: [
          if (_images.length <= 12)
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                for (int i = 0; i < _images.length; i++)
                  GestureDetector(
                    onTap: () => _jumpToShot(i),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        height: 8,
                        width: i == current ? 26 : 8,
                        decoration: BoxDecoration(
                          gradient: i == current ? kBrandGradient : null,
                          color: i == current ? null : Colors.white24,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 10),
          Text(
            '${current + 1} / ${_images.length}  •  Click a screen to enlarge',
            style: const TextStyle(color: Colors.white54, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── OVERVIEW ─────────────────────────
  Widget _overview(double availableW) {
    final sentences = widget.description
        .split(RegExp(r'(?<=[.!?])\s+'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final lead = sentences.length >= 3 ? sentences.first : widget.description;
    final rest = sentences.length >= 3 ? sentences.sublist(1) : <String>[];

    const icons = [
      Icons.bolt_rounded,
      Icons.devices_rounded,
      Icons.sync_rounded,
      Icons.speed_rounded,
      Icons.verified_rounded,
      Icons.auto_awesome_rounded,
    ];

    final twoCols = availableW >= 800;
    final cardW = twoCols ? (availableW - 20) / 2 : availableW;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white.withValues(alpha: 0.05),
              border: Border.all(color: Colors.white12),
              gradient: LinearGradient(
                colors: [
                  AppColors.purple.withValues(alpha: 0.18),
                  AppColors.blue.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: 64,
                  margin: const EdgeInsets.only(right: 18, top: 4),
                  decoration: BoxDecoration(
                    gradient: kBrandGradient,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Expanded(
                  child: Text(
                    lead,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      height: 1.65,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (rest.isNotEmpty) ...[
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              for (int i = 0; i < rest.length; i++)
                SizedBox(
                  width: cardW,
                  child: Reveal(
                    delay: Duration(milliseconds: twoCols ? (i % 2) * 120 : 0),
                    from: twoCols
                        ? (i.isEven ? RevealFrom.left : RevealFrom.right)
                        : RevealFrom.bottom,
                    child: HoverLift(
                      borderRadius: BorderRadius.circular(18),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: kBrandGradient,
                              ),
                              child: Icon(icons[i % icons.length],
                                  color: Colors.white, size: 24),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                rest[i],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                  height: 1.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }

  // ───────────────────────── TECH STACK ─────────────────────────
  String _techName(String path) {
    final parts = path.split(RegExp(r'[/.]'));
    final raw = parts.length >= 2 ? parts[parts.length - 2] : path;
    const names = {
      'RestAPI': 'REST API',
      'IsarDb': 'Isar DB',
      'androidStudio': 'Android Studio',
      'vscode': 'VS Code',
      'gitHub': 'GitHub',
      'xcode': 'Xcode',
      'git': 'Git',
    };
    if (names.containsKey(raw)) return names[raw]!;
    if (raw.isEmpty) return '';
    return raw[0].toUpperCase() + raw.substring(1);
  }

  Widget _techGrid() {
    return Wrap(
      spacing: 18,
      runSpacing: 18,
      children: [
        for (int i = 0; i < widget.techStack.length; i++)
          Reveal(
            delay: Duration(milliseconds: i * 90),
            distance: 30,
            child: SizedBox(
              width: 150,
              child: HoverLift(
                borderRadius: BorderRadius.circular(18),
                glow: AppColors.purple,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HoverScale(
                        scale: 1.15,
                        child: Container(
                          width: 66,
                          height: 66,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[900],
                            border: Border.all(color: Colors.indigoAccent),
                          ),
                          child: Image.asset(
                            widget.techStack[i],
                            fit: BoxFit.contain,
                            errorBuilder: (c, e, s) => const Icon(
                                Icons.code, color: Colors.white54),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _techName(widget.techStack[i]),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  // ───────────────────────── FOOTER CTA ─────────────────────────
  Widget _footerCta() {
    return Reveal(
      child: Center(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 760),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: AppColors.purple.withValues(alpha: 0.4)),
            gradient: LinearGradient(
              colors: [
                AppColors.purple.withValues(alpha: 0.2),
                AppColors.blue.withValues(alpha: 0.06),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Like what you see?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Explore more of my work or get in touch.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              const SizedBox(height: 24),
              HoverScale(
                scale: 1.07,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: kBrandGradient,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blue.withValues(alpha: 0.35),
                        blurRadius: 24,
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 18),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    icon: const Icon(Icons.apps_rounded, color: Colors.white),
                    label: const Text(
                      'Back to all projects',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SCREENSHOT CARD (phone frame, hover lift, zoom hint)
// ─────────────────────────────────────────────────────────────────────────────
class _ShotCard extends StatefulWidget {
  final String path;
  final double width;
  final VoidCallback onTap;

  const _ShotCard({
    required this.path,
    required this.width,
    required this.onTap,
  });

  @override
  State<_ShotCard> createState() => _ShotCardState();
}

class _ShotCardState extends State<_ShotCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          transformAlignment: Alignment.center,
          transform: Matrix4.translationValues(0, _hover ? -10 : 0, 0) *
              Matrix4.diagonal3Values(
                  _hover ? 1.04 : 1, _hover ? 1.04 : 1, 1),
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: _hover
                  ? AppColors.blue.withValues(alpha: 0.9)
                  : Colors.white24,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: _hover
                    ? AppColors.purple.withValues(alpha: 0.45)
                    : Colors.black54,
                blurRadius: _hover ? 40 : 16,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: const Color(0xFF0B0B1E)),
                Image.asset(
                  widget.path,
                  fit: BoxFit.contain,
                  gaplessPlayback: true,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[900],
                    child: const Icon(Icons.broken_image,
                        color: Colors.red, size: 48),
                  ),
                ),
                Positioned.fill(
                  child: IgnorePointer(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: _hover ? 1 : 0,
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.4),
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: kBrandGradient,
                          ),
                          child: const Icon(Icons.zoom_in_rounded,
                              color: Colors.white, size: 30),
                        ),
                      ),
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

// ─────────────────────────────────────────────────────────────────────────────
// FULL-SCREEN SCREENSHOT VIEWER (swipe, arrows, keyboard, pinch-zoom)
// ─────────────────────────────────────────────────────────────────────────────
class _ScreenshotViewer extends StatefulWidget {
  final List<String> images;
  final int initial;

  const _ScreenshotViewer({required this.images, required this.initial});

  @override
  State<_ScreenshotViewer> createState() => _ScreenshotViewerState();
}

class _ScreenshotViewerState extends State<_ScreenshotViewer> {
  late final PageController _pc =
  PageController(initialPage: widget.initial);
  late int _i = widget.initial;

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  void _go(int dir) {
    final next = (_i + dir).clamp(0, widget.images.length - 1);
    _pc.animateToPage(
      next,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.images.length;
    return Focus(
      autofocus: true,
      onKeyEvent: (_, e) {
        if (e is KeyDownEvent) {
          if (e.logicalKey == LogicalKeyboardKey.arrowRight) {
            _go(1);
            return KeyEventResult.handled;
          }
          if (e.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _go(-1);
            return KeyEventResult.handled;
          }
          if (e.logicalKey == LogicalKeyboardKey.escape) {
            Navigator.of(context).pop();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pc,
              itemCount: n,
              onPageChanged: (i) => setState(() => _i = i),
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 70, vertical: 70),
                child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(widget.images[i],
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      '${_i + 1} / $n',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: SafeArea(
                child: HoverScale(
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.15),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                  ),
                ),
              ),
            ),
            if (n > 1 && _i > 0)
              Positioned(
                left: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: HoverScale(
                    child: IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                      ),
                      onPressed: () => _go(-1),
                      icon: const Icon(Icons.chevron_left_rounded,
                          color: Colors.white, size: 30),
                    ),
                  ),
                ),
              ),
            if (n > 1 && _i < n - 1)
              Positioned(
                right: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: HoverScale(
                    child: IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.15),
                      ),
                      onPressed: () => _go(1),
                      icon: const Icon(Icons.chevron_right_rounded,
                          color: Colors.white, size: 30),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
