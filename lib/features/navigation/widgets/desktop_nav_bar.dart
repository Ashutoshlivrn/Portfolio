import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/widgets/gradient_button.dart';
import '../controllers/navigation_controller.dart';

class DesktopNavBar extends ConsumerWidget {
  const DesktopNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSection = ref.watch(navigationProvider);
    final navNotifier = ref.read(navigationProvider.notifier);
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: (isDark ? AppColors.darkSurface : AppColors.lightSurface).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Brand Logo
          InkWell(
            onTap: () => navNotifier.scrollToSection(NavigationSection.home),
            borderRadius: BorderRadius.circular(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
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
                Text(
                  AppStrings.developerName,
                  style: AppTypography.titleLarge(context).copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Section Nav Links & Actions
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...NavigationSection.values.map((section) {
                    final isCurrent = activeSection == section;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: TextButton(
                        onPressed: () => navNotifier.scrollToSection(section),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: isCurrent
                              ? AppColors.primary.withValues(alpha: 0.15)
                              : Colors.transparent,
                        ),
                        child: Text(
                          section.label,
                          style: TextStyle(
                            color: isCurrent
                                ? AppColors.primary
                                : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
                            fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 12),
                  // Theme Toggle
                  IconButton(
                    tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                    onPressed: () => ref.read(themeModeProvider.notifier).toggleTheme(),
                    icon: Icon(
                      isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      color: isDark ? AppColors.warning : AppColors.textPrimaryLight,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Contact CTA Button
                  GradientButton(
                    text: 'Let\'s Talk',
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    onPressed: () => navNotifier.scrollToSection(NavigationSection.contact),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
