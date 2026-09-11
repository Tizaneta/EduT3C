import 'package:flutter/material.dart';

enum AchievementCategory {
  general,
  hardware,
  software,
  net,
  social,
  progress,
  time,
}

class AchievementItem {
  final IconData icon;
  final String label;
  final AchievementCategory category;

  const AchievementItem({
    required this.icon,
    required this.label,
    this.category = AchievementCategory.general,
  });
}

class InventoryItem {
  final IconData icon;
  final String label;
  final bool unlocked;

  const InventoryItem({
    required this.icon,
    required this.label,
    required this.unlocked,
  });
}
