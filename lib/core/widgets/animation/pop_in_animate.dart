import 'package:flutter/material.dart';
import 'package:news_task/core/app_themes/app_motion.dart';

class PopInAnimate extends StatefulWidget {
  const PopInAnimate({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = AppMotion.slow,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;

  @override
  State<PopInAnimate> createState() => _PopInAnimateState();
}

class _PopInAnimateState extends State<PopInAnimate>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scale = Tween(
      begin: AppMotion.popScale,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: AppMotion.spring));
    _fade = CurvedAnimation(parent: _controller, curve: AppMotion.easeOut);
    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
