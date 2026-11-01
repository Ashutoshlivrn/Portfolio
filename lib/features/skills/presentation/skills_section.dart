import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../../core/widgets/animated_glass_card.dart';
import '../../../core/widgets/custom_chip.dart';
import '../../../core/widgets/section_header.dart';
import 'controllers/skills_controller.dart';
import '../data/models/skill_category.dart';

class SkillsSection extends ConsumerWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final categories = ref.watch(skillCategoriesProvider);
    final selectedCategory = ref.watch(selectedSkillCategoryProvider);
    final filteredCategories = ref.watch(filteredSkillCategoriesProvider);

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
                tag: '02. Skills',
                title: AppStrings.skillsHeader,
                subtitle: AppStrings.skillsSubHeader,
              ),
              const SizedBox(height: 32),

              // Filter Tabs
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  CustomChip(
                    label: 'All Technologies',
                    icon: Icons.grid_view_rounded,
                    isSelected: selectedCategory == 'all',
                    onTap: () => ref.read(selectedSkillCategoryProvider.notifier).state = 'all',
                  ),
                  ...categories.map((cat) {
                    final isSel = selectedCategory == cat.id;
                    return CustomChip(
                      label: cat.title,
                      icon: cat.icon,
                      isSelected: isSel,
                      onTap: () => ref.read(selectedSkillCategoryProvider.notifier).state = cat.id,
                    );
                  }),
                ],
              ),

              const SizedBox(height: 40),

              // Categories Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 700;

                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: filteredCategories.map((category) {
                      return SizedBox(
                        width: isWide ? (constraints.maxWidth - 24) / 2 : constraints.maxWidth,
                        child: _CategoryCard(category: category),
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

class _CategoryCard extends StatelessWidget {
  final SkillCategory category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return AnimatedGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(category.icon, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  category.title,
                  style: AppTypography.titleLarge(context).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...category.skills.map((skill) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: _SkillRow(skill: skill),
            );
          }),
        ],
      ),
    );
  }
}

class _SkillRow extends StatelessWidget {
  final SkillItem skill;

  const _SkillRow({required this.skill});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      skill.name,
                      style: AppTypography.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (skill.isHighlight) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Core',
                        style: AppTypography.codeFont(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              skill.experience,
              style: AppTypography.codeFont(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Proficiency progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: skill.proficiency,
            minHeight: 6,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkBorder
                : AppColors.lightBorder,
            valueColor: AlwaysStoppedAnimation<Color>(
              skill.isHighlight ? AppColors.primary : AppColors.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
