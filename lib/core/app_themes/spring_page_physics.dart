import 'package:flutter/material.dart';
import 'package:motor/motor.dart';

/// [PageScrollPhysics] with the Material 3 Expressive spring, so a page
/// settling after a swipe matches the springs used by sheets, snacks, and
/// press morphs.
///
/// Only the settle simulation changes — paging behaviour, thresholds, and
/// gesture handling stay exactly as [PageScrollPhysics] defines them.
class SpringPagePhysics extends PageScrollPhysics {
  const SpringPagePhysics({super.parent});

  @override
  SpringPagePhysics applyTo(ScrollPhysics? ancestor) =>
      SpringPagePhysics(parent: buildParent(ancestor));

  @override
  SpringDescription get spring =>
      const MaterialSpringMotion.standardSpatialDefault().description;
}
