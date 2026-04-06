/// XP multiplier tiers applied when calculating earned XP.
enum XpDifficulty {
  easy(multiplier: 0.8, label: 'Easy'),
  normal(multiplier: 1.0, label: 'Normal'),
  hard(multiplier: 1.5, label: 'Hard'),
  expert(multiplier: 2.0, label: 'Expert');

  const XpDifficulty({required this.multiplier, required this.label});
  final double multiplier;
  final String label;
}

/// XP rewards for different activities.
class XpReward {
  static const int quizCorrect = 10;
  static const int voiceQuizCorrect = 15;
  static const int flashcardWordViewed = 5;
  static const int perfectQuizBonus = 20;

  /// Returns the streak XP multiplier for the given streak count.
  ///
  /// Tiers:
  ///   streak == 0        → 1.0× (no bonus)
  ///   1 – 6 days         → 1.0× + 5% per day  (max 1.30× at day 6)
  ///   7 – 29 days        → 1.5× (fixed)
  ///   30+ days           → 2.0× (fixed)
  static double streakMultiplier(int streak) {
    if (streak <= 0) return 1.0;
    if (streak >= 30) return 2.0;
    if (streak >= 7) return 1.5;
    return 1.0 + streak * 0.05;
  }

  /// Calculate XP for a quiz result.
  static int forQuiz({
    required int correctCount,
    required int totalCount,
    required bool isVoiceQuiz,
    required int streak,
    XpDifficulty difficulty = XpDifficulty.normal,
  }) {
    final basePerCorrect = isVoiceQuiz ? voiceQuizCorrect : quizCorrect;
    int xp = correctCount * basePerCorrect;
    if (correctCount == totalCount && totalCount > 0) {
      xp += perfectQuizBonus;
    }
    xp = (xp * difficulty.multiplier).round();
    xp = (xp * streakMultiplier(streak)).round();
    return xp;
  }

  /// Calculate XP for completing a flashcard page.
  static int forFlashcardPage({required int wordCount, required int streak}) {
    int xp = wordCount * flashcardWordViewed;
    xp = (xp * streakMultiplier(streak)).round();
    return xp;
  }
}
