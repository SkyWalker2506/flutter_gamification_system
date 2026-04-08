import 'package:equatable/equatable.dart';

enum AchievementCategory { words, streak, quiz, daily, social, voice, flashcard, level }

class Achievement extends Equatable {
  final String id;
  final String title;
  final String description;
  final String icon;
  final AchievementCategory category;
  final int target;
  final int progress;
  final DateTime? unlockedAt;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.category,
    required this.target,
    this.progress = 0,
    this.unlockedAt,
  });

  bool get isUnlocked => unlockedAt != null;
  double get progressFraction => (progress / target).clamp(0.0, 1.0);

  Achievement copyWith({
    int? progress,
    DateTime? unlockedAt,
  }) {
    return Achievement(
      id: id,
      title: title,
      description: description,
      icon: icon,
      category: category,
      target: target,
      progress: progress ?? this.progress,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  @override
  List<Object?> get props => [id, progress, unlockedAt];
}

/// All achievements defined in the app.
const List<Achievement> kAchievements = [
  Achievement(
    id: 'first_word',
    title: 'First Step',
    description: 'Complete your first quiz',
    icon: '🌱',
    category: AchievementCategory.words,
    target: 1,
  ),
  Achievement(
    id: 'words_10',
    title: 'Getting Started',
    description: 'Answer 10 quiz questions',
    icon: '📖',
    category: AchievementCategory.words,
    target: 10,
  ),
  Achievement(
    id: 'words_50',
    title: 'Word Collector',
    description: 'Answer 50 quiz questions',
    icon: '📚',
    category: AchievementCategory.words,
    target: 50,
  ),
  Achievement(
    id: 'words_100',
    title: 'Century Club',
    description: 'Answer 100 quiz questions',
    icon: '💯',
    category: AchievementCategory.words,
    target: 100,
  ),
  Achievement(
    id: 'words_500',
    title: 'Vocabulary Master',
    description: 'Answer 500 quiz questions',
    icon: '🏆',
    category: AchievementCategory.words,
    target: 500,
  ),
  Achievement(
    id: 'streak_3',
    title: 'On a Roll',
    description: 'Study 3 days in a row',
    icon: '🔥',
    category: AchievementCategory.streak,
    target: 3,
  ),
  Achievement(
    id: 'streak_7',
    title: 'Week Warrior',
    description: 'Study 7 days in a row',
    icon: '⚡',
    category: AchievementCategory.streak,
    target: 7,
  ),
  Achievement(
    id: 'streak_30',
    title: 'Iron Will',
    description: 'Study 30 days in a row',
    icon: '💎',
    category: AchievementCategory.streak,
    target: 30,
  ),
  Achievement(
    id: 'streak_100',
    title: 'Centurion',
    description: 'Study 100 days in a row',
    icon: '🏅',
    category: AchievementCategory.streak,
    target: 100,
  ),
  Achievement(
    id: 'streak_365',
    title: 'Eternal Flame',
    description: 'Study 365 days in a row',
    icon: '👑',
    category: AchievementCategory.streak,
    target: 365,
  ),
  Achievement(
    id: 'quiz_first',
    title: 'Quiz Taker',
    description: 'Complete your first quiz',
    icon: '✏️',
    category: AchievementCategory.quiz,
    target: 1,
  ),
  Achievement(
    id: 'quiz_perfect_1',
    title: 'Perfectionist',
    description: 'Get 100% on a quiz',
    icon: '⭐',
    category: AchievementCategory.quiz,
    target: 1,
  ),
  Achievement(
    id: 'quiz_perfect_5',
    title: 'All-Star',
    description: 'Get 100% on 5 quizzes',
    icon: '🌟',
    category: AchievementCategory.quiz,
    target: 5,
  ),
  Achievement(
    id: 'daily_goal',
    title: 'Daily Goal',
    description: 'Answer 5 questions in one day',
    icon: '🎯',
    category: AchievementCategory.daily,
    target: 5,
  ),

  // --- Social Achievements ---
  Achievement(
    id: 'social_first_share',
    title: 'Social Butterfly',
    description: 'Share your progress for the first time',
    icon: '📣',
    category: AchievementCategory.social,
    target: 1,
  ),
  Achievement(
    id: 'social_share_5',
    title: 'Influencer',
    description: 'Share your progress 5 times',
    icon: '📲',
    category: AchievementCategory.social,
    target: 5,
  ),
  Achievement(
    id: 'social_feedback',
    title: 'Community Helper',
    description: 'Submit your first feedback',
    icon: '💬',
    category: AchievementCategory.social,
    target: 1,
  ),

  // --- Voice Achievements ---
  Achievement(
    id: 'voice_first_listen',
    title: 'Listener',
    description: 'Listen to a word pronunciation for the first time',
    icon: '🔊',
    category: AchievementCategory.voice,
    target: 1,
  ),
  Achievement(
    id: 'voice_listen_50',
    title: 'Phonetic Fan',
    description: 'Listen to 50 word pronunciations',
    icon: '🎙️',
    category: AchievementCategory.voice,
    target: 50,
  ),
  Achievement(
    id: 'voice_listen_200',
    title: 'Sound Scholar',
    description: 'Listen to 200 word pronunciations',
    icon: '🎧',
    category: AchievementCategory.voice,
    target: 200,
  ),

  // --- Flashcard Achievements ---
  Achievement(
    id: 'flashcard_first',
    title: 'Card Player',
    description: 'Review your first flashcard',
    icon: '🃏',
    category: AchievementCategory.flashcard,
    target: 1,
  ),
  Achievement(
    id: 'flashcard_10',
    title: 'Card Collector',
    description: 'Review 10 flashcards',
    icon: '🗃️',
    category: AchievementCategory.flashcard,
    target: 10,
  ),
  Achievement(
    id: 'flashcard_100',
    title: 'Card Master',
    description: 'Review 100 flashcards',
    icon: '🎴',
    category: AchievementCategory.flashcard,
    target: 100,
  ),
  Achievement(
    id: 'flashcard_500',
    title: 'Flash Champion',
    description: 'Review 500 flashcards',
    icon: '⚡',
    category: AchievementCategory.flashcard,
    target: 500,
  ),

  // --- Level Achievements ---
  Achievement(
    id: 'level_5',
    title: 'Rising Star',
    description: 'Reach level 5',
    icon: '⭐',
    category: AchievementCategory.level,
    target: 5,
  ),
  Achievement(
    id: 'level_10',
    title: 'Dedicated Learner',
    description: 'Reach level 10',
    icon: '🌟',
    category: AchievementCategory.level,
    target: 10,
  ),
  Achievement(
    id: 'level_25',
    title: 'Expert',
    description: 'Reach level 25',
    icon: '🔥',
    category: AchievementCategory.level,
    target: 25,
  ),
  Achievement(
    id: 'level_50',
    title: 'Grandmaster',
    description: 'Reach level 50',
    icon: '👑',
    category: AchievementCategory.level,
    target: 50,
  ),
];
