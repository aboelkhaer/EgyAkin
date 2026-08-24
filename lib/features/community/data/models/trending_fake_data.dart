// Fake trending topics for the redesigned Trending tab.
// Replace with API TrendModel mapping once ready.

import 'package:flutter/material.dart';

class TrendingTopicFake {
  final int rank;
  final String tag;
  final String category;
  final int postsCount;
  final int growthPercent;
  final IconData icon;
  final List<Color> lightColors;
  final List<Color> darkColors;
  final Color accent;

  const TrendingTopicFake({
    required this.rank,
    required this.tag,
    required this.category,
    required this.postsCount,
    required this.growthPercent,
    required this.icon,
    required this.lightColors,
    required this.darkColors,
    required this.accent,
  });

  bool get isRising => growthPercent >= 0;

  String get searchQuery => tag.startsWith('#') ? tag : '#$tag';
}

class TrendingFakeData {
  TrendingFakeData._();

  static const List<TrendingTopicFake> topics = [
    TrendingTopicFake(
      rank: 1,
      tag: '#KidneyHealth',
      category: 'HEALTH',
      postsCount: 128,
      growthPercent: 42,
      icon: Icons.local_fire_department_rounded,
      // Vibrant purple → deep indigo (matches mockup hero)
      lightColors: [Color(0xFF9F7AEA), Color(0xFF5B21B6)],
      darkColors: [Color(0xFF8B5CF6), Color(0xFF4C1D95)],
      accent: Color(0xFFC4B5FD),
    ),
    TrendingTopicFake(
      rank: 2,
      tag: '#EgyAkinSupport',
      category: 'SUPPORT',
      postsCount: 96,
      growthPercent: 30,
      icon: Icons.groups_rounded,
      lightColors: [Color(0xFFDBEAFE), Color(0xFFBFDBFE)],
      darkColors: [Color(0xFF0C1E38), Color(0xFF122A4A)],
      accent: Color(0xFF60A5FA),
    ),
    TrendingTopicFake(
      rank: 3,
      tag: '#YouAreNotAlone',
      category: 'COMMUNITY',
      postsCount: 74,
      growthPercent: 18,
      icon: Icons.favorite_rounded,
      lightColors: [Color(0xFFD1FAE5), Color(0xFFA7F3D0)],
      darkColors: [Color(0xFF0C241C), Color(0xFF123528)],
      accent: Color(0xFF34D399),
    ),
    TrendingTopicFake(
      rank: 4,
      tag: '#ChronicKidneyDisease',
      category: 'CLINICAL',
      postsCount: 63,
      growthPercent: 9,
      icon: Icons.medical_services_rounded,
      lightColors: [Color(0xFFFFEDD5), Color(0xFFFED7AA)],
      darkColors: [Color(0xFF2A1D0C), Color(0xFF3A2810)],
      accent: Color(0xFFFBBF24),
    ),
    TrendingTopicFake(
      rank: 5,
      tag: '#RenalWarrior',
      category: 'CARE',
      postsCount: 51,
      growthPercent: -4,
      icon: Icons.shield_rounded,
      lightColors: [Color(0xFFCCFBF1), Color(0xFF99F6E4)],
      darkColors: [Color(0xFF0C2422), Color(0xFF123330)],
      accent: Color(0xFF2DD4BF),
    ),
  ];
}
