import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/theme/theme_provider.dart';
import '../controllers/navigation_controller.dart';

class MobileDrawer extends ConsumerWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSection = ref.watch(navigationProvider);
    final navNotifier = ref.read(navigationProvider.notifier);
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Drawer(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '< / >',
                      style: AppTypography.codeFont(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0B0F19),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.developerName,
                          style: AppTypography.titleLarge(context).copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '${AppStrings.experienceYears} Years Flutter',
                          style: AppTypography.codeFont(
                            fontSize: 11,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            const Divider(),

            // Section Nav Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: NavigationSection.values.map((section) {
                  final isCurrent = activeSection == section;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: isCurrent
                          ? AppColors.primary.withValues(alpha: 0.12)
                          : Colors.transparent,
                      leading: Icon(
                        section.icon,
                        color: isCurrent ? AppColors.primary : Theme.of(context).colorScheme.onSurface,
                      ),
                      title: Text(
                        section.label,
                        style: TextStyle(
                          color: isCurrent ? AppColors.primary : Theme.of(context).colorScheme.onSurface,
                          fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        navNotifier.scrollToSection(section);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const Divider(),

            // Theme Switcher & Footer
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isDark ? 'Dark Theme' : 'Light Theme',
                    style: AppTypography.bodyMedium(context),
                  ),
                  IconButton(
                    onPressed: () => ref.read(themeModeProvider.notifier).toggleTheme(),
                    icon: Icon(
                      isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      color: isDark ? AppColors.warning : AppColors.textPrimaryLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
