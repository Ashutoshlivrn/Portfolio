import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/url_launcher_util.dart';
import '../controllers/navigation_controller.dart';

class FooterSection extends ConsumerWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightCardHover,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Brand & Tagline
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '< / >',
                              style: AppTypography.codeFont(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0B0F19),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            AppStrings.developerName,
                            style: AppTypography.titleLarge(context).copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Architected with Flutter 3 & Riverpod 2',
                        style: AppTypography.codeFont(
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),

                  // Back to Top Button
                  IconButton.filledTonal(
                    tooltip: 'Back to Top',
                    onPressed: () => ref.read(navigationProvider.notifier).scrollToSection(NavigationSection.home),
                    icon: const Icon(Icons.arrow_upward_rounded),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 20),

              // Social Links and Copyright
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  Text(
                    '© ${DateTime.now().year} ${AppStrings.developerName}. Built with Clean Architecture & Riverpod.',
                    style: AppTypography.bodyMedium(context).copyWith(fontSize: 13),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _SocialIconButton(
                        icon: Icons.code_rounded,
                        tooltip: 'GitHub',
                        onTap: () => UrlLauncherUtil.launchURL(context, AppStrings.githubUrl),
                      ),
                      const SizedBox(width: 8),
                      _SocialIconButton(
                        icon: Icons.business_center_rounded,
                        tooltip: 'LinkedIn',
                        onTap: () => UrlLauncherUtil.launchURL(context, AppStrings.linkedinUrl),
                      ),
                      const SizedBox(width: 8),
                      _SocialIconButton(
                        icon: Icons.email_rounded,
                        tooltip: 'Email',
                        onTap: () => UrlLauncherUtil.launchEmail(context, email: AppStrings.email),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _SocialIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
    );
  }
}
