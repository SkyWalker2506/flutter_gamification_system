import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// A theme that can be unlocked at a certain level.
class AppThemeDefinition extends Equatable {
  final String id;
  final String nameKey;
  final Color seedColor;
  final int requiredLevel;
  final IconData icon;

  const AppThemeDefinition({
    required this.id,
    required this.nameKey,
    required this.seedColor,
    required this.requiredLevel,
    required this.icon,
  });

  bool isUnlocked(int currentLevel) => currentLevel >= requiredLevel;

  @override
  List<Object?> get props => [id];

  // ─── Registry ───────────────────────────────────────────────────────────

  /// Default built-in themes, used when no custom themes are configured.
  static const List<AppThemeDefinition> defaults = [
    AppThemeDefinition(
      id: 'classic',
      nameKey: 'themeClassic',
      seedColor: Colors.teal,
      requiredLevel: 1,
      icon: Icons.eco_outlined,
    ),
    AppThemeDefinition(
      id: 'ocean',
      nameKey: 'themeOcean',
      seedColor: Colors.blue,
      requiredLevel: 3,
      icon: Icons.water_outlined,
    ),
    AppThemeDefinition(
      id: 'forest',
      nameKey: 'themeForest',
      seedColor: Colors.green,
      requiredLevel: 5,
      icon: Icons.forest_outlined,
    ),
    AppThemeDefinition(
      id: 'sunset',
      nameKey: 'themeSunset',
      seedColor: Colors.deepOrange,
      requiredLevel: 8,
      icon: Icons.wb_twilight_outlined,
    ),
    AppThemeDefinition(
      id: 'royal',
      nameKey: 'themeRoyal',
      seedColor: Colors.deepPurple,
      requiredLevel: 12,
      icon: Icons.diamond_outlined,
    ),
    AppThemeDefinition(
      id: 'rose',
      nameKey: 'themeRose',
      seedColor: Colors.pink,
      requiredLevel: 15,
      icon: Icons.local_florist_outlined,
    ),
    AppThemeDefinition(
      id: 'midnight',
      nameKey: 'themeMidnight',
      seedColor: Colors.indigo,
      requiredLevel: 20,
      icon: Icons.nightlight_outlined,
    ),
    AppThemeDefinition(
      id: 'gold',
      nameKey: 'themeGold',
      seedColor: Colors.amber,
      requiredLevel: 25,
      icon: Icons.star_outlined,
    ),
    AppThemeDefinition(
      id: 'crimson',
      nameKey: 'themeCrimson',
      seedColor: Colors.red,
      requiredLevel: 30,
      icon: Icons.whatshot_outlined,
    ),
  ];

  static List<AppThemeDefinition>? _custom;

  /// All available themes. Returns custom themes if configured, otherwise defaults.
  static List<AppThemeDefinition> get all => _custom ?? defaults;

  /// Replace the built-in theme list with a custom one.
  ///
  /// Call this before the app starts (e.g. in `main()`).
  /// The list must contain at least one theme.
  static void configure(List<AppThemeDefinition> themes) {
    assert(themes.isNotEmpty, 'At least one theme is required');
    _custom = List.unmodifiable(themes);
  }

  /// Reset to built-in defaults.
  static void resetToDefaults() {
    _custom = null;
  }

  /// Find a theme by id, defaults to the first theme.
  static AppThemeDefinition byId(String id) {
    return all.firstWhere((t) => t.id == id, orElse: () => all.first);
  }
}

/// Features that unlock at certain levels.
enum UnlockableFeature {
  voiceQuiz(requiredLevel: 2),
  competitionMode(requiredLevel: 3),
  advancedStats(requiredLevel: 5);

  const UnlockableFeature({required this.requiredLevel});
  final int requiredLevel;

  bool isUnlocked(int currentLevel) => currentLevel >= requiredLevel;
}
