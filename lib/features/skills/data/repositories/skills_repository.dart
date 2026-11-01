import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/skill_category.dart';

abstract class SkillsRepository {
  List<SkillCategory> getSkillCategories();
}

class InMemorySkillsRepository implements SkillsRepository {
  @override
  List<SkillCategory> getSkillCategories() {
    return const [
      SkillCategory(
        id: 'mobile_core',
        title: 'Flutter & Mobile Core',
        icon: Icons.phone_android_rounded,
        skills: [
          SkillItem(name: 'Flutter SDK & Widgets', proficiency: 0.98, experience: '3.5 yrs', isHighlight: true),
          SkillItem(name: 'Dart Programming', proficiency: 0.96, experience: '3.5 yrs', isHighlight: true),
          SkillItem(name: 'Responsive UI Architecture', proficiency: 0.95, experience: '3.5 yrs', isHighlight: true),
          SkillItem(name: 'Legacy Code Refactoring', proficiency: 0.92, experience: '3 yrs'),
          SkillItem(name: 'Performance Profiling & Jitter Fixes', proficiency: 0.90, experience: '3 yrs'),
          SkillItem(name: 'Java to Flutter Migration', proficiency: 0.88, experience: '2.5 yrs'),
        ],
      ),
      SkillCategory(
        id: 'hardware_media',
        title: 'BLE, IoT & Media Streaming',
        icon: Icons.bluetooth_audio_rounded,
        skills: [
          SkillItem(name: 'Bluetooth Low Energy (BLE)', proficiency: 0.94, experience: '2.5 yrs', isHighlight: true),
          SkillItem(name: 'Medical Hardware Data Parsing', proficiency: 0.92, experience: '2 yrs', isHighlight: true),
          SkillItem(name: 'Live Video Streaming (HLS / OTT)', proficiency: 0.90, experience: '2.5 yrs', isHighlight: true),
          SkillItem(name: 'Multi-Angle Video Switching', proficiency: 0.88, experience: '2 yrs'),
          SkillItem(name: 'Custom Video Player Packages', proficiency: 0.90, experience: '2 yrs'),
          SkillItem(name: 'Live Map & Driver Tracking (GPS)', proficiency: 0.92, experience: '3 yrs'),
        ],
      ),
      SkillCategory(
        id: 'state_arch',
        title: 'State & Architecture',
        icon: Icons.account_tree_rounded,
        skills: [
          SkillItem(name: 'Riverpod 2 (Notifier / AsyncNotifier)', proficiency: 0.96, experience: '3 yrs', isHighlight: true),
          SkillItem(name: 'BLoC & Cubit', proficiency: 0.90, experience: '3 yrs'),
          SkillItem(name: 'Provider & ValueNotifier', proficiency: 0.94, experience: '3.5 yrs'),
          SkillItem(name: 'Clean Architecture & MVVM', proficiency: 0.92, experience: '3.5 yrs', isHighlight: true),
          SkillItem(name: 'Session Security & Geo-Logout', proficiency: 0.90, experience: '2 yrs'),
        ],
      ),
      SkillCategory(
        id: 'backend_devops',
        title: 'APIs, Firebase & Deployment',
        icon: Icons.cloud_done_rounded,
        skills: [
          SkillItem(name: 'RESTful APIs & JSON Serialization', proficiency: 0.96, experience: '3.5 yrs', isHighlight: true),
          SkillItem(name: 'Payment Gateways & Wallet Systems', proficiency: 0.90, experience: '2.5 yrs', isHighlight: true),
          SkillItem(name: 'Firebase (Auth, Firestore, FCM)', proficiency: 0.92, experience: '3.5 yrs'),
          SkillItem(name: 'Google Play & App Store Publishing', proficiency: 0.92, experience: '3 yrs'),
          SkillItem(name: 'Git (GitHub / Bitbucket) & Jira', proficiency: 0.95, experience: '3.5 yrs'),
        ],
      ),
    ];
  }
}

final skillsRepositoryProvider = Provider<SkillsRepository>((ref) {
  return InMemorySkillsRepository();
});
