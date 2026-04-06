/// Level thresholds: level N requires N*(N-1)*50 total XP.
class LevelSystem {
  /// Maximum supported level.
  static const int maxLevel = 100;

  /// XP required to reach [level].
  static int xpForLevel(int level) {
    if (level <= 1) return 0;
    return level * (level - 1) * 50;
  }

  /// Current level from total XP.
  static int levelFromXp(int totalXp) {
    int level = 1;
    while (level < maxLevel && xpForLevel(level + 1) <= totalXp) {
      level++;
    }
    return level;
  }

  /// XP progress within current level (0.0 - 1.0).
  static double progressInLevel(int totalXp) {
    final level = levelFromXp(totalXp);
    if (level >= maxLevel) return 1.0;
    final currentThreshold = xpForLevel(level);
    final nextThreshold = xpForLevel(level + 1);
    final range = nextThreshold - currentThreshold;
    if (range <= 0) return 1.0;
    return ((totalXp - currentThreshold) / range).clamp(0.0, 1.0);
  }

  /// XP needed to reach the next level.
  static int xpToNextLevel(int totalXp) {
    final level = levelFromXp(totalXp);
    if (level >= maxLevel) return 0;
    return xpForLevel(level + 1) - totalXp;
  }

  /// Human-readable title for a given level (1-50+ progression).
  static String titleForLevel(int level) {
    if (level >= 75) return 'Grand Master';
    if (level >= 50) return 'Master';
    if (level >= 40) return 'Champion';
    if (level >= 30) return 'Expert';
    if (level >= 25) return 'Adept';
    if (level >= 20) return 'Advanced';
    if (level >= 15) return 'Scholar';
    if (level >= 10) return 'Intermediate';
    if (level >= 7) return 'Apprentice';
    if (level >= 5) return 'Learner';
    if (level >= 3) return 'Novice';
    return 'Beginner';
  }
}
