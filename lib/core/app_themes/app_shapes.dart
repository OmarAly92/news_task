import 'package:flutter/material.dart';
import 'package:material_shapes/material_shapes.dart';

/// Shape tokens, mirroring how [AppMotion] holds motion and [AppTextStyle]
/// holds type: every non-rectangular or morphing shape picks from here instead
/// of constructing its own polygon.
///
/// Corner rounding for ordinary rectangles stays in `AppConstants`
/// (`radiusLg`, `radiusXl`, `radius2xl`) — this file is only for the Material 3
/// Expressive shapes, whose point is that they *morph* between states.
///
/// Each pair is (resting, active) plus a `…Border(t)` that interpolates between
/// them. Drive `t` with a spring from [AppMotion] — `pressSpring` for touch,
/// `effectsSpring` for selection — so the morph runs on physics and survives
/// being interrupted mid-flight.
sealed class AppShapes {
  /// The resting shape of avatars and the assistant orb.
  static final RoundedPolygon avatar = MaterialShapes.clover4Leaf;

  /// The pressed/active counterpart of [avatar].
  static final RoundedPolygon avatarActive = MaterialShapes.cookie7Sided;

  /// The resting shape of a selectable marker — a plain circle.
  static final RoundedPolygon marker = MaterialShapes.circle;

  /// The selected counterpart of [marker].
  static final RoundedPolygon markerActive = MaterialShapes.burst;

  /// Interpolated avatar/orb border. [t] 0 = resting, 1 = active.
  static ShapeBorder avatarBorder(double t) => _lerp(avatar, avatarActive, t);

  /// Interpolated marker border. [t] 0 = resting, 1 = selected.
  static ShapeBorder markerBorder(double t) => _lerp(marker, markerActive, t);

  static ShapeBorder _lerp(RoundedPolygon from, RoundedPolygon to, double t) {
    final double tc = t.clamp(0.0, 1.0);
    final MaterialShapeBorder start = MaterialShapeBorder(shape: from);
    if (tc <= 0) return start;
    final MaterialShapeBorder end = MaterialShapeBorder(shape: to);
    if (tc >= 1) return end;
    return start.lerpTo(end, tc)!;
  }
}
