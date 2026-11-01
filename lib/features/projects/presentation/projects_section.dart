import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../../core/widgets/custom_chip.dart';
import '../../../core/widgets/section_header.dart';
import 'controllers/project_filter_controller.dart';
import 'widgets/project_card.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final categories = ref.watch(projectCategoriesProvider);
    final selectedCategory = ref.watch(selectedProjectCategoryProvider);
    final filteredProjects = ref.watch(filteredProjectsProvider);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              const SectionHeader(
                tag: '04. Showcase',
                title: AppStrings.projectsHeader,
                subtitle: AppStrings.projectsSubHeader,
              ),
              const SizedBox(height: 32),

              // Filter Chips
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: categories.map((cat) {
                  final isSel = selectedCategory == cat;
                  return CustomChip(
                    label: cat,
                    isSelected: isSel,
                    onTap: () => ref.read(selectedProjectCategoryProvider.notifier).state = cat,
                  );
                }).toList(),
              ),

              const SizedBox(height: 40),

              // Projects Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 768;

                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: filteredProjects.map((project) {
                      return SizedBox(
                        width: isWide ? (constraints.maxWidth - 24) / 2 : constraints.maxWidth,
                        child: ProjectCard(project: project),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
