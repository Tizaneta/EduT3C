import 'package:flutter/material.dart';

import '../models/achievement.dart';

class AchievementRepository {
  const AchievementRepository();

  List<AchievementItem> getAchievements() {
    return const [
      AchievementItem(icon: Icons.construction, label: 'Constructor\nNovato', category: AchievementCategory.progress),
      AchievementItem(icon: Icons.memory, label: 'Experto en\nHardware', category: AchievementCategory.hardware),
      AchievementItem(icon: Icons.wifi, label: 'Comunidad\nActiva', category: AchievementCategory.social),
      AchievementItem(icon: Icons.computer, label: 'Maestro PC', category: AchievementCategory.hardware),
      AchievementItem(icon: Icons.terminal, label: 'Coder', category: AchievementCategory.progress),
      AchievementItem(icon: Icons.shield, label: 'Seguridad', category: AchievementCategory.general),
      AchievementItem(icon: Icons.speed, label: 'Veloz', category: AchievementCategory.progress),
      AchievementItem(icon: Icons.star, label: 'Top 100', category: AchievementCategory.general),
    ];
  }

  List<InventoryItem> getInventory() {
    return const [
      InventoryItem(icon: Icons.calculate, label: 'Calculador', unlocked: true),
      InventoryItem(icon: Icons.pin_drop, label: 'Pin Año', unlocked: true),
      InventoryItem(icon: Icons.android, label: 'MaduAnim', unlocked: true),
      InventoryItem(icon: Icons.bookmark, label: 'logro random', unlocked: false),
      InventoryItem(icon: Icons.wifi, label: 'NetPro', unlocked: false),
      InventoryItem(icon: Icons.code, label: 'Dev', unlocked: false),
    ];
  }
}
