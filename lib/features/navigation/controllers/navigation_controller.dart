import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NavigationSection {
  home('Home', Icons.home_rounded),
  about('About', Icons.person_rounded),
  skills('Skills', Icons.code_rounded),
  experience('Experience', Icons.work_history_rounded),
  projects('Projects', Icons.layers_rounded),
  contact('Contact', Icons.mail_rounded);

  final String label;
  final IconData icon;
  const NavigationSection(this.label, this.icon);
}

class NavigationNotifier extends StateNotifier<NavigationSection> {
  NavigationNotifier() : super(NavigationSection.home);

  final Map<NavigationSection, GlobalKey> sectionKeys = {
    NavigationSection.home: GlobalKey(),
    NavigationSection.about: GlobalKey(),
    NavigationSection.skills: GlobalKey(),
    NavigationSection.experience: GlobalKey(),
    NavigationSection.projects: GlobalKey(),
    NavigationSection.contact: GlobalKey(),
  };

  void setActiveSection(NavigationSection section) {
    state = section;
  }

  void scrollToSection(NavigationSection section) {
    state = section;
    final key = sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }
}

final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationSection>((ref) {
  return NavigationNotifier();
});
