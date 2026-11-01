import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/utils/url_launcher_util.dart';
import '../../../../core/widgets/animated_glass_card.dart';
import '../../../../core/widgets/custom_chip.dart';
import '../../data/models/project_item.dart';

class ProjectCard extends StatelessWidget {
  final ProjectItem project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return AnimatedGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Category & Stats + Links
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      project.category.toUpperCase(),
                      style: AppTypography.codeFont(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  if (project.isFeatured) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '★ Featured',
                        style: AppTypography.codeFont(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Row(
                children: [
                  if (project.githubUrl != null)
                    IconButton(
                      tooltip: 'View Source Code',
                      icon: const Icon(Icons.code_rounded, size: 20),
                      onPressed: () => UrlLauncherUtil.launchURL(context, project.githubUrl!),
                    ),
                  if (project.liveUrl != null)
                    IconButton(
                      tooltip: 'Live Demo / Store Link',
                      icon: const Icon(Icons.launch_rounded, size: 20),
                      onPressed: () => UrlLauncherUtil.launchURL(context, project.liveUrl!),
                    ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Title
          Text(
            project.title,
            style: AppTypography.titleLarge(context).copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 6),

          // Tagline
          Text(
            project.tagline,
            style: AppTypography.bodyMedium(context).copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 14),

          // Description
          Text(
            project.description,
            style: AppTypography.bodyMedium(context).copyWith(
              height: 1.5,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
            ),
          ),

          const SizedBox(height: 20),

          // Metric/Stats Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkSurface
                  : AppColors.lightCardHover,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.insights_rounded, size: 16, color: AppColors.accent),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    project.stats,
                    style: AppTypography.codeFont(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),
          const Divider(),
          const SizedBox(height: 14),

          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.tags.map((t) => CustomChip(label: t)).toList(),
          ),
        ],
      ),
    );
  }
}
