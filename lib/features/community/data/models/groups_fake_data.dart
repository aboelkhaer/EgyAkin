// Fake groups for the redesigned Groups tab.
// Replace with API GroupModel mapping once ready.

import 'package:flutter/material.dart';

class CommunityGroupFake {
  final String id;
  final String name;
  final String description;
  final int memberCount;
  final int unreadBadge;
  final IconData icon;
  final Color accent;
  final bool isJoined;

  const CommunityGroupFake({
    required this.id,
    required this.name,
    required this.description,
    required this.memberCount,
    required this.icon,
    required this.accent,
    this.unreadBadge = 0,
    this.isJoined = false,
  });

  CommunityGroupFake copyWith({bool? isJoined, int? unreadBadge}) {
    return CommunityGroupFake(
      id: id,
      name: name,
      description: description,
      memberCount: memberCount,
      icon: icon,
      accent: accent,
      unreadBadge: unreadBadge ?? this.unreadBadge,
      isJoined: isJoined ?? this.isJoined,
    );
  }
}

class GroupsFakeData {
  GroupsFakeData._();

  static const List<CommunityGroupFake> yourGroups = [
    CommunityGroupFake(
      id: 'yg1',
      name: 'Nephrology Egypt',
      description: 'Clinical updates & discussions',
      memberCount: 342,
      unreadBadge: 5,
      icon: Icons.monitor_heart_outlined,
      accent: Color(0xFF7C5CFC),
      isJoined: true,
    ),
    CommunityGroupFake(
      id: 'yg2',
      name: 'Case Conferences',
      description: 'Weekly case review',
      memberCount: 128,
      unreadBadge: 0,
      icon: Icons.assignment_outlined,
      accent: Color(0xFF7C5CFC),
      isJoined: true,
    ),
    CommunityGroupFake(
      id: 'yg3',
      name: 'Transplant Hub',
      description: 'Referral & outcomes',
      memberCount: 96,
      unreadBadge: 2,
      icon: Icons.volunteer_activism_outlined,
      accent: Color(0xFF7C5CFC),
      isJoined: true,
    ),
  ];

  static const List<CommunityGroupFake> discoverGroups = [
    CommunityGroupFake(
      id: 'dg1',
      name: 'Alameen',
      description: 'Protocols & patient pathways',
      memberCount: 214,
      icon: Icons.local_hospital_outlined,
      accent: Color(0xFF22C55E),
    ),
    CommunityGroupFake(
      id: 'dg2',
      name: 'Dialysis Unit Team',
      description: 'Alameen General Hospital',
      memberCount: 89,
      icon: Icons.water_drop_outlined,
      accent: Color(0xFFF59E0B),
    ),
    CommunityGroupFake(
      id: 'dg3',
      name: 'CKD Diet & Lifestyle',
      description: 'Nutrition guidance for CKD',
      memberCount: 156,
      icon: Icons.restaurant_outlined,
      accent: Color(0xFF8B5CF6),
    ),
    CommunityGroupFake(
      id: 'dg4',
      name: 'ICU Nephrology',
      description: 'Acute kidney injury cases',
      memberCount: 203,
      icon: Icons.emergency_outlined,
      accent: Color(0xFF3B82F6),
    ),
  ];
}
