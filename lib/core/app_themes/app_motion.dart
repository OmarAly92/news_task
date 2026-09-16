import 'package:flutter/animation.dart';
import 'package:motor/motor.dart';

/// Motion tokens mirroring the design's durations, easing curves, and
/// animation distances. Every animated widget should pick from here
/// instead of inventing its own timing.
sealed class AppMotion {
  /// Micro interactions: press states, border and color flips on chips
  /// and inputs. Example: a suggestion chip's border darkening on tap.
  static const Duration fast = Duration(milliseconds: 120);

  /// Standard transitions: fades, background shifts, tab label color.
  /// Example: the nav tab tint when switching tabs.
  static const Duration base = Duration(milliseconds: 180);

  /// Entrances of content blocks. Example: a wizard step's fields popping
  /// in, a chat bubble appearing.
  static const Duration slow = Duration(milliseconds: 260);

  /// Full-screen transitions between tabs/pages in the carousel and depth
  /// styles. Example: Today sliding up while Chat slides away.
  static const Duration screen = Duration(milliseconds: 380);

  /// The exit half of the flip screen transition.
  static const Duration flipExit = Duration(milliseconds: 180);

  /// The enter half of the flip screen transition, started after
  /// [flipEnterDelay].
  static const Duration flipEnter = Duration(milliseconds: 260);

  /// Gap between the flip exit finishing and the enter starting.
  static const Duration flipEnterDelay = Duration(milliseconds: 150);

  /// Big springy morphs. Example: the composer growing while typing a
  /// long message, the segmented thumb sliding between filters.
  static const Duration emphasis = Duration(milliseconds: 450);

  /// Staggered entrances of a group of cards. Example: the onboarding
  /// slide's task and schedule cards popping in one after another.
  static const Duration entrance = Duration(milliseconds: 600);

  /// One full cycle of the typing indicator's three bouncing dots.
  static const Duration typingLoop = Duration(milliseconds: 1200);

  /// One full cycle of the assistant orb's idle float.
  static const Duration orbFloatLoop = Duration(milliseconds: 2500);

  /// The default deceleration curve — fast start, gentle stop. Pairs with
  /// [fast]/[base] for most transitions.
  static const Curve easeOut = Cubic(0.22, 0.61, 0.36, 1);

  /// The symmetric curve for looping animations. Pairs with [typingLoop]
  /// and [orbFloatLoop].
  static const Curve easeInOut = Cubic(0.65, 0, 0.35, 1);

  /// The overshoot curve giving entrances a playful bounce. Pairs with
  /// [slow]/[emphasis] for pops, sheets, and the segmented thumb.
  static const Curve spring = Cubic(0.34, 1.4, 0.64, 1);

  /// How far a fade-up entrance starts below its resting spot. Example:
  /// a wizard step's content rising 10 into place.
  static const double fadeUpOffset = 10;

  /// How far a sheet-like entrance starts below its resting spot.
  /// Example: the add-task sheet rising 60 into place.
  static const double slideUpOffset = 60;

  /// The starting scale of a pop entrance. Example: the orb scaling from
  /// 0.94 to full size on the wizard's final step.
  static const double popScale = 0.94;

  /// How far each typing-indicator dot lifts at the top of its bounce.
  static const double typingBounceOffset = 4;

  /// How far the orb rises at the top of its idle float.
  static const double orbFloatOffset = 10;

  /// The lead-in before a single element's entrance, so it lands after the
  /// screen itself has settled. Example: the wizard step title.
  static const Duration entranceLeadIn = Duration(milliseconds: 60);

  /// The delay before the first item of a staggered group starts. Example:
  /// the wizard's option cards waiting on the step title.
  static const Duration staggerBase = Duration(milliseconds: 120);

  /// The gap between consecutive items of a staggered group. Example: the
  /// offset between task cards popping in on Today.
  static const Duration staggerStep = Duration(milliseconds: 40);

  /// The entrance delay for item [index] of a staggered group. Pass
  /// `leadIn: false` for groups that should start immediately — a list the
  /// user is already looking at, rather than a step they just navigated to.
  static Duration staggerAt(int index, {bool leadIn = true}) =>
      (leadIn ? staggerBase : Duration.zero) + staggerStep * index;

  /// The gap between beats of a decorative reveal — illustration layers
  /// composing themselves, rather than list items appearing. Deliberately
  /// slower than [staggerStep]: the eye is meant to follow each beat.
  static const Duration revealStep = Duration(milliseconds: 180);

  /// The delay for beat [index] of a decorative reveal. Example: the
  /// onboarding illustration's layers landing one after another.
  static Duration revealAt(int index) => revealStep * index;

  // ---------------------------------------------------------------------------
  // Springs
  //
  // The tokens above are duration + curve: correct for motion that runs to a
  // fixed length and is never interrupted. The tokens below are physics
  // simulations, and differ in behaviour, not looks — a spring carries release
  // velocity and continues from wherever it is when retargeted, while a curve
  // restarts. Reach for a spring whenever a finger is involved (drag, fling,
  // press, a value that can change mid-flight); keep the curves for looping and
  // staggered entrances.
  // ---------------------------------------------------------------------------

  /// Small components reacting to touch: chips, buttons, the segmented thumb,
  /// snack pills. Example: a task card's press morph.
  static const Motion pressSpring =
      MaterialSpringMotion.expressiveSpatialFast();

  /// Large surfaces entering. Example: a bottom sheet springing up.
  static const Motion surfaceSpring =
      MaterialSpringMotion.expressiveSpatialDefault();

  /// Exits and dismissals — quieter, so the overshoot doesn't fight the
  /// gesture that dismissed it. Example: a sheet flung closed.
  static const Motion exitSpring = MaterialSpringMotion.standardSpatialFast();

  /// Non-spatial changes: colour, opacity, elevation. Example: a selection
  /// tint settling after a tap.
  static const Motion effectsSpring =
      MaterialSpringMotion.standardEffectsDefault();
}
