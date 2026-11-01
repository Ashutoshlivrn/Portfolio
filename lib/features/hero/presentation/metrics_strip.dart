import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../../core/widgets/animated_glass_card.dart';

class MetricsStrip extends StatelessWidget {
  const MetricsStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    final metrics = [
      {'val': AppStrings.metric1Value, 'lbl': AppStrings.metric1Label, 'icon': Icons.timeline_rounded},
      {'val': AppStrings.metric2Value, 'lbl': AppStrings.metric2Label, 'icon': Icons.apps_rounded},
      {'val': AppStrings.metric3Value, 'lbl': AppStrings.metric3Label, 'icon': Icons.people_alt_rounded},
      {'val': AppStrings.metric4Value, 'lbl': AppStrings.metric4Label, 'icon': Icons.shield_rounded},
    ];

    if (isMobile) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
        ),
        itemCount: metrics.length,
        itemBuilder: (context, index) {
          final m = metrics[index];
          return _MetricItem(
            value: m['val'] as String,
            label: m['lbl'] as String,
            icon: m['icon'] as IconData,
          );
        },
      );
    }

    return Row(
      children: metrics.map((m) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _MetricItem(
              value: m['val'] as String,
              label: m['lbl'] as String,
              icon: m['icon'] as IconData,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _MetricItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedGlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 20, color: AppColors.primary),
                const SizedBox(width: 8),
                ShaderMask(
                  shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                  child: Text(
                    value,
                    style: AppTypography.displayMedium(context).copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium(context).copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}
