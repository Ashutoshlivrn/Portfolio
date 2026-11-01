import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/skill_category.dart';
import '../../data/repositories/skills_repository.dart';

/// Provider returning the list of all skill categories.
final skillCategoriesProvider = Provider<List<SkillCategory>>((ref) {
  final repo = ref.watch(skillsRepositoryProvider);
  return repo.getSkillCategories();
});

/// StateProvider holding the active category ID ('all' or specific id).
final selectedSkillCategoryProvider = StateProvider<String>((ref) => 'all');

/// Filtered categories provider based on the selected category.
final filteredSkillCategoriesProvider = Provider<List<SkillCategory>>((ref) {
  final categories = ref.watch(skillCategoriesProvider);
  final selected = ref.watch(selectedSkillCategoryProvider);

  if (selected == 'all') {
    return categories;
  }
  return categories.where((c) => c.id == selected).toList();
});
