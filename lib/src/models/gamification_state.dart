import 'package:equatable/equatable.dart';

import 'level_system.dart';
import 'theme_definition.dart';

/// Immutable gamification state.
class GamificationState extends Equatable {
  final int totalXp;
  final int level;
  final double levelProgress;
  final int xpToNext;
  final String selectedThemeId;

  const GamificationState({
    required this.totalXp,
    required this.level,
    required this.levelProgress,
    required this.xpToNext,
    this.selectedThemeId = 'classic',
  });

  factory GamificationState.fromXp(int totalXp,
      {String selectedThemeId = 'classic'}) {
    return GamificationState(
      totalXp: totalXp,
      level: LevelSystem.levelFromXp(totalXp),
      levelProgress: LevelSystem.progressInLevel(totalXp),
      xpToNext: LevelSystem.xpToNextLevel(totalXp),
      selectedThemeId: selectedThemeId,
    );
  }

  static const initial = GamificationState(
    totalXp: 0,
    level: 1,
    levelProgress: 0.0,
    xpToNext: 100,
  );

  bool isFeatureUnlocked(UnlockableFeature feature) =>
      feature.isUnlocked(level);

  /// Themes unlocked at current level.
  List<AppThemeDefinition> get unlockedThemes =>
      AppThemeDefinition.all.where((t) => t.isUnlocked(level)).toList();

  /// The currently selected theme definition.
  AppThemeDefinition get selectedTheme =>
      AppThemeDefinition.byId(selectedThemeId);

  /// Level title (e.g. "Beginner", "Expert").
  String get levelTitle => LevelSystem.titleForLevel(level);

  @override
  List<Object?> get props => [totalXp, level, selectedThemeId];
}
