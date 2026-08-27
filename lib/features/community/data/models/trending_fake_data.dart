import 'package:egy_akin/exports.dart';

/// Visual presentation model for the Trending tab.
/// Built from API [TrendModel] plus a recycled style palette by rank.
class TrendingTopicUi {
  final int rank;
  final String tag;
  final String category;
  final int postsCount;
  final int? growthPercent;
  final IconData icon;
  final List<Color> lightColors;
  final List<Color> darkColors;
  final Color accent;

  const TrendingTopicUi({
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

  bool get isRising => (growthPercent ?? 0) >= 0;

  String get searchQuery => tag.startsWith('#') ? tag : '#$tag';

  static TrendingTopicUi fromTrend(TrendModel trend, int index) {
    final style = _styles[index % _styles.length];
    final rawTag = (trend.tag ?? '').trim();
    final tag = rawTag.isEmpty
        ? '#trend'
        : (rawTag.startsWith('#') ? rawTag : '#$rawTag');

    return TrendingTopicUi(
      rank: index + 1,
      tag: tag,
      category: 'TRENDING',
      postsCount: trend.usageCount ?? 0,
      growthPercent: null,
      icon: style.icon,
      lightColors: style.lightColors,
      darkColors: style.darkColors,
      accent: style.accent,
    );
  }

  static List<TrendingTopicUi> fromTrends(List<TrendModel> trends) {
    return [
      for (var i = 0; i < trends.length; i++) fromTrend(trends[i], i),
    ];
  }
}

class _TrendStyle {
  final IconData icon;
  final List<Color> lightColors;
  final List<Color> darkColors;
  final Color accent;

  const _TrendStyle({
    required this.icon,
    required this.lightColors,
    required this.darkColors,
    required this.accent,
  });
}

const List<_TrendStyle> _styles = [
  _TrendStyle(
    icon: Icons.local_fire_department_rounded,
    lightColors: [Color(0xFF9F7AEA), Color(0xFF5B21B6)],
    darkColors: [Color(0xFF8B5CF6), Color(0xFF4C1D95)],
    accent: Color(0xFFC4B5FD),
  ),
  _TrendStyle(
    icon: Icons.groups_rounded,
    lightColors: [Color(0xFFDBEAFE), Color(0xFFBFDBFE)],
    darkColors: [Color(0xFF0C1E38), Color(0xFF122A4A)],
    accent: Color(0xFF60A5FA),
  ),
  _TrendStyle(
    icon: Icons.favorite_rounded,
    lightColors: [Color(0xFFD1FAE5), Color(0xFFA7F3D0)],
    darkColors: [Color(0xFF0C241C), Color(0xFF123528)],
    accent: Color(0xFF34D399),
  ),
  _TrendStyle(
    icon: Icons.medical_services_rounded,
    lightColors: [Color(0xFFFFEDD5), Color(0xFFFED7AA)],
    darkColors: [Color(0xFF2A1D0C), Color(0xFF3A2810)],
    accent: Color(0xFFFBBF24),
  ),
  _TrendStyle(
    icon: Icons.shield_rounded,
    lightColors: [Color(0xFFCCFBF1), Color(0xFF99F6E4)],
    darkColors: [Color(0xFF0C2422), Color(0xFF123330)],
    accent: Color(0xFF2DD4BF),
  ),
  _TrendStyle(
    icon: Icons.tag_rounded,
    lightColors: [Color(0xFFFCE7F3), Color(0xFFFBCFE8)],
    darkColors: [Color(0xFF2A1220), Color(0xFF3A1830)],
    accent: Color(0xFFF472B6),
  ),
];
