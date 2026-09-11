import 'package:edut3c/models/achievement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Achievement models', () {
    test('creates achievement items from data', () {
      final achievement = AchievementItem(
        icon: Icons.star,
        label: 'Top 100',
        category: AchievementCategory.general,
      );

      expect(achievement.icon, Icons.star);
      expect(achievement.label, 'Top 100');
      expect(achievement.category, AchievementCategory.general);
    });

    test('creates inventory items with unlock state', () {
      final item = InventoryItem(
        icon: Icons.code,
        label: 'Dev',
        unlocked: false,
      );

      expect(item.unlocked, isFalse);
      expect(item.label, 'Dev');
    });
  });
}
