import 'package:equatable/equatable.dart';

/// Conditions that trigger a badge award.
enum BadgeCondition {
  firstQuiz,
  words50,
  words100,
  words500,
  perfectQuiz,
  level5,
  level10,
  level20,
  level50,
  level100,
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
];

/// Pure condition-check logic — no state, no I/O.
///
/// Used both in [BadgeNotifier] and in unit tests.
class BadgeConditionEngine {
  /// Returns true when [condition] is satisfied by the given stats.
  static bool isMet(
    BadgeCondition condition, {
    required int totalQuestions,
    required bool hasPerfectQuiz,
    int currentLevel = 1,
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
    }
  }

  /// Evaluates all [kBadges] and returns the subset whose conditions are met
  /// but that have not yet been earned (i.e. [Badge.isEarned] == false).
  static List<Badge> evaluate({
    required List<Badge> current,
    required int totalQuestions,
    required bool hasPerfectQuiz,
    int currentLevel = 1,
  }) {
    return [
      for (final b in current)
        if (!b.isEarned &&
            isMet(b.condition,
                totalQuestions: totalQuestions,
                hasPerfectQuiz: hasPerfectQuiz,
                currentLevel: currentLevel))
          b,
    ];
  }
}
