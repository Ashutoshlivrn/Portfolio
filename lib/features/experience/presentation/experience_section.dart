import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../../core/widgets/animated_glass_card.dart';
import '../../../core/widgets/custom_chip.dart';
import '../../../core/widgets/section_header.dart';
import '../data/models/experience_item.dart';
import '../data/repositories/experience_repository.dart';

class ExperienceSection extends ConsumerWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final experiences = ref.watch(experiencesProvider);

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
                tag: '03. Career',
                title: AppStrings.experienceHeader,
                subtitle: AppStrings.experienceSubHeader,
              ),
              const SizedBox(height: 48),

              // Timeline list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experiences.length,
                itemBuilder: (context, index) {
                  final exp = experiences[index];
                  final isLast = index == experiences.length - 1;

                  return _TimelineTile(
                    experience: exp,
                    isLast: isLast,
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

class _TimelineTile extends StatelessWidget {
  final ExperienceItem experience;
  final bool isLast;

  const _TimelineTile({
    required this.experience,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator line & dot
          Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: experience.isCurrent ? AppColors.primary : AppColors.darkSurface,
                  border: Border.all(
                    color: experience.isCurrent ? AppColors.primary : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                    width: 3,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),

          // Experience Card Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: AnimatedGlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top header: Role & Company + Period badge
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              experience.role,
                              style: AppTypography.titleLarge(context).copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${experience.company} • ${experience.location}',
                              style: AppTypography.bodyMedium(context).copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: experience.isCurrent
                                ? AppColors.accent.withValues(alpha: 0.15)
                                : (isDark ? AppColors.darkSurface : AppColors.lightCardHover),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: experience.isCurrent
                                  ? AppColors.accent
                                  : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                            ),
                          ),
                          child: Text(
                            experience.period,
                            style: AppTypography.codeFont(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: experience.isCurrent
                                  ? AppColors.accent
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Text(
                      experience.description,
                      style: AppTypography.bodyMedium(context),
                    ),

                    const SizedBox(height: 16),
                    // Highlights
                    ...experience.highlights.map((h) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Icon(
                                Icons.arrow_right_rounded,
                                size: 18,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                h,
                                style: AppTypography.bodyMedium(context).copyWith(
                                  height: 1.45,
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.85),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: 16),
                    // Tech Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: experience.technologies.map((t) {
                        return CustomChip(label: t);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
