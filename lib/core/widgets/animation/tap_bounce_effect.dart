import 'package:flutter/material.dart';
import 'package:motor/motor.dart';
import 'package:news_task/core/app_themes/app_motion.dart';

/// Scales its child down briefly on tap.
///
/// Spring-driven rather than curve-driven: a second tap while the first bounce
/// is still settling continues from the current scale instead of snapping back
/// to full size first.
class TapBounceEffect extends StatefulWidget {
  const TapBounceEffect({super.key, required this.child});

  final Widget child;

  @override
  State<TapBounceEffect> createState() => _TapBounceEffectState();
}

class _TapBounceEffectState extends State<TapBounceEffect>
    with SingleTickerProviderStateMixin {
  static const double _pressedScale = .97;

  late final SingleMotionController _scale = SingleMotionController(
    motion: AppMotion.pressSpring,
    vsync: this,
    initialValue: 1,
  );

  @override
  void dispose() {
    _scale.dispose();
    super.dispose();
  }

  Future<void> _bounce() async {
    await _scale.animateTo(_pressedScale);
    if (mounted) _scale.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapInside: (_) => _bounce(),
      onTapUpInside: (_) {},
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: widget.child,
      ),
    );
  }
}
