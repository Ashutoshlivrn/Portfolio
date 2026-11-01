import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/project_item.dart';
import '../../data/repositories/project_repository.dart';

final projectCategoriesProvider = Provider<List<String>>((ref) {
  final projects = ref.watch(allProjectsProvider);
  final categories = projects.map((p) => p.category).toSet().toList();
  return ['All', ...categories];
});

final selectedProjectCategoryProvider = StateProvider<String>((ref) => 'All');

final filteredProjectsProvider = Provider<List<ProjectItem>>((ref) {
  final selectedCategory = ref.watch(selectedProjectCategoryProvider);
  final projects = ref.watch(allProjectsProvider);

  if (selectedCategory == 'All') {
    return projects;
  }
  return projects.where((p) => p.category == selectedCategory).toList();
});
