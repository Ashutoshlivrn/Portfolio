import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';
import '../utils/responsive_layout.dart';

class SectionHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String subtitle;
  final bool isCenter;

  const SectionHeader({
    super.key,
    required this.tag,
    required this.title,
    required this.subtitle,
    this.isCenter = true,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Column(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Tag Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            tag.toUpperCase(),
            style: AppTypography.codeFont(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Title
        Text(
          title,
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: (isMobile
                  ? AppTypography.headlineLarge(context)
                  : AppTypography.displayMedium(context))
              .copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 10),

        // Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Text(
            subtitle,
            textAlign: isCenter ? TextAlign.center : TextAlign.start,
            style: AppTypography.bodyLarge(context).copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
      ],
    );
  }
}
