import 'package:flutter/material.dart';

class SkillItem {
  final String name;
  final double proficiency; // 0.0 to 1.0
  final String experience;
  final IconData? icon;
  final bool isHighlight;

  const SkillItem({
    required this.name,
    required this.proficiency,
    required this.experience,
    this.icon,
    this.isHighlight = false,
  });
}

class SkillCategory {
  final String id;
  final String title;
  final IconData icon;
  final List<SkillItem> skills;

  const SkillCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.skills,
  });
}
