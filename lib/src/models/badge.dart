import 'package:equatable/equatable.dart';

/// Conditions that trigger a badge award.
enum BadgeCondition {
  // Words / quiz
  firstQuiz,
  words50,
  words100,
  words500,
  perfectQuiz,
  // Level
  level5,
  level10,
  level20,
  level50,
  level100,
  // Social
  firstShare,
  share5,
  firstFeedback,
  // Voice / TTS
  firstListen,
  listen50,
  listen200,
  // Flashcard / SRS
  firstFlashcard,
  flashcard10,
  flashcard100,
  flashcard500,
}

/// An immutable badge that can be earned by the user.
class Badge extends Equatable {
  final String id;
  final String title;

  /// Emoji icon displayed in the badge grid.
  final String icon;
  final BadgeCondition condition;
  final DateTime? earnedAt;

  const Badge({
    required this.id,
    required this.title,
    required this.icon,
    required this.condition,
    this.earnedAt,
  });

  bool get isEarned => earnedAt != null;

  Badge copyWith({DateTime? earnedAt}) {
    return Badge(
      id: id,
      title: title,
      icon: icon,
      condition: condition,
      earnedAt: earnedAt ?? this.earnedAt,
    );
  }

  @override
  List<Object?> get props => [id, earnedAt];
}

/// All badges available in the app, ordered by condition difficulty.
const List<Badge> kBadges = [
  Badge(
    id: 'first_quiz',
    title: 'First Quiz',
    icon: '🎉',
    condition: BadgeCondition.firstQuiz,
  ),
  Badge(
    id: 'words_50',
    title: 'Word Collector',
    icon: '📚',
    condition: BadgeCondition.words50,
  ),
  Badge(
    id: 'words_100',
    title: 'Century Club',
    icon: '💯',
    condition: BadgeCondition.words100,
  ),
  Badge(
    id: 'words_500',
    title: 'Vocabulary Master',
    icon: '🏆',
    condition: BadgeCondition.words500,
  ),
  Badge(
    id: 'perfect_quiz',
    title: 'Perfectionist',
    icon: '⭐',
    condition: BadgeCondition.perfectQuiz,
  ),
  Badge(
    id: 'level_5',
    title: 'Rising Star',
    icon: '🌟',
    condition: BadgeCondition.level5,
  ),
  Badge(
    id: 'level_10',
    title: 'Apprentice Sage',
    icon: '🎓',
    condition: BadgeCondition.level10,
  ),
  Badge(
    id: 'level_20',
    title: 'Word Warrior',
    icon: '⚔️',
    condition: BadgeCondition.level20,
  ),
  Badge(
    id: 'level_50',
    title: 'Lexicon Lord',
    icon: '🔮',
    condition: BadgeCondition.level50,
  ),
  Badge(
    id: 'level_100',
    title: 'Grand Master',
    icon: '👑',
    condition: BadgeCondition.level100,
  ),

  // --- Social badges ---
  Badge(
    id: 'first_share',
    title: 'Social Butterfly',
    icon: '📣',
    condition: BadgeCondition.firstShare,
  ),
  Badge(
    id: 'share_5',
    title: 'Influencer',
    icon: '📲',
    condition: BadgeCondition.share5,
  ),
  Badge(
    id: 'first_feedback',
    title: 'Community Helper',
    icon: '💬',
    condition: BadgeCondition.firstFeedback,
  ),

  // --- Voice / TTS badges ---
  Badge(
    id: 'first_listen',
    title: 'Listener',
    icon: '🔊',
    condition: BadgeCondition.firstListen,
  ),
  Badge(
    id: 'listen_50',
    title: 'Phonetic Fan',
    icon: '🎙️',
    condition: BadgeCondition.listen50,
  ),
  Badge(
    id: 'listen_200',
    title: 'Sound Scholar',
    icon: '🎧',
    condition: BadgeCondition.listen200,
  ),

  // --- Flashcard / SRS badges ---
  Badge(
    id: 'first_flashcard',
    title: 'Card Player',
    icon: '🃏',
    condition: BadgeCondition.firstFlashcard,
  ),
  Badge(
    id: 'flashcard_10',
    title: 'Card Collector',
    icon: '🗃️',
    condition: BadgeCondition.flashcard10,
  ),
  Badge(
    id: 'flashcard_100',
    title: 'Card Master',
    icon: '🎴',
    condition: BadgeCondition.flashcard100,
  ),
  Badge(
    id: 'flashcard_500',
    title: 'Flash Champion',
    icon: '⚡',
    condition: BadgeCondition.flashcard500,
  ),
];

/// Pure condition-check logic — no state, no I/O.
///
/// Used both in [BadgeNotifier] and in unit tests.
class BadgeConditionEngine {
  /// Returns true when [condition] is satisfied by the given stats.
  ///
  /// New social/voice/flashcard parameters are optional and default to 0/false
  /// so that existing callers do not need to be updated immediately.
  static bool isMet(
    BadgeCondition condition, {
    required int totalQuestions,
    required bool hasPerfectQuiz,
    int currentLevel = 1,
    // Social
    int totalShares = 0,
    bool hasFeedback = false,
    // Voice / TTS
    int totalListens = 0,
    // Flashcard / SRS
    int totalFlashcards = 0,
  }) {
    switch (condition) {
      case BadgeCondition.firstQuiz:
        return totalQuestions > 0;
      case BadgeCondition.words50:
        return totalQuestions >= 50;
      case BadgeCondition.words100:
        return totalQuestions >= 100;
      case BadgeCondition.words500:
        return totalQuestions >= 500;
      case BadgeCondition.perfectQuiz:
        return hasPerfectQuiz;
      case BadgeCondition.level5:
        return currentLevel >= 5;
      case BadgeCondition.level10:
        return currentLevel >= 10;
      case BadgeCondition.level20:
        return currentLevel >= 20;
      case BadgeCondition.level50:
        return currentLevel >= 50;
      case BadgeCondition.level100:
        return currentLevel >= 100;
      // Social
      case BadgeCondition.firstShare:
        return totalShares >= 1;
      case BadgeCondition.share5:
        return totalShares >= 5;
      case BadgeCondition.firstFeedback:
        return hasFeedback;
      // Voice / TTS
      case BadgeCondition.firstListen:
        return totalListens >= 1;
      case BadgeCondition.listen50:
        return totalListens >= 50;
      case BadgeCondition.listen200:
        return totalListens >= 200;
      // Flashcard / SRS
      case BadgeCondition.firstFlashcard:
        return totalFlashcards >= 1;
      case BadgeCondition.flashcard10:
        return totalFlashcards >= 10;
      case BadgeCondition.flashcard100:
        return totalFlashcards >= 100;
      case BadgeCondition.flashcard500:
        return totalFlashcards >= 500;
    }
  }

  /// Evaluates all [kBadges] and returns the subset whose conditions are met
  /// but that have not yet been earned (i.e. [Badge.isEarned] == false).
  static List<Badge> evaluate({
    required List<Badge> current,
    required int totalQuestions,
    required bool hasPerfectQuiz,
    int currentLevel = 1,
    int totalShares = 0,
    bool hasFeedback = false,
    int totalListens = 0,
    int totalFlashcards = 0,
  }) {
    return [
      for (final b in current)
        if (!b.isEarned &&
            isMet(
              b.condition,
              totalQuestions: totalQuestions,
              hasPerfectQuiz: hasPerfectQuiz,
              currentLevel: currentLevel,
              totalShares: totalShares,
              hasFeedback: hasFeedback,
              totalListens: totalListens,
              totalFlashcards: totalFlashcards,
            ))
          b,
    ];
  }
}
