import 'package:flutter/material.dart';

sealed class TopicIcons {
  static const Map<String, IconData> _byName = {
    'devices': Icons.devices_rounded,
    'business': Icons.business_center_rounded,
    'sports_soccer': Icons.sports_soccer_rounded,
    'science': Icons.science_rounded,
    'health_and_safety': Icons.health_and_safety_rounded,
    'palette': Icons.palette_rounded,
  };

  static IconData resolve(String? name) =>
      _byName[name] ?? Icons.newspaper_rounded;
}
