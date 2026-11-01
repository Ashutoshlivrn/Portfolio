import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../../core/utils/url_launcher_util.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../navigation/controllers/navigation_controller.dart';
import 'metrics_strip.dart';
import 'profile_avatar_widget.dart';

class HeroSection extends ConsumerWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final navNotifier = ref.read(navigationProvider.notifier);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: isDesktop ? 60 : 32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _HeroContent(navNotifier: navNotifier),
                    ),
                    const SizedBox(width: 48),
                    const Expanded(
                      flex: 4,
                      child: Center(child: ProfileAvatarWidget()),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(child: ProfileAvatarWidget()),
                    const SizedBox(height: 32),
                    _HeroContent(navNotifier: navNotifier, isCenter: true),
                  ],
                ),

              const SizedBox(height: 48),

              // Metrics Strip (3.5+ yrs, 15+ apps, 250k+ users, 99.8% crash free)
              const MetricsStrip(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroContent extends StatelessWidget {
  final NavigationNotifier navNotifier;
  final bool isCenter;

  const _HeroContent({
    required this.navNotifier,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Availability Status Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.openToWorkBadge,
                style: AppTypography.codeFont(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Headline
        RichText(
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            style: AppTypography.displayLarge(context).copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.15,
            ),
            children: [
              const TextSpan(text: "Hi, I'm "),
              TextSpan(
                text: AppStrings.developerName,
                style: const TextStyle(
                  color: AppColors.primary,
                ),
              ),
              const TextSpan(text: "\nSenior Flutter Developer"),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Subtitle Pitch
        Text(
          '3.5 years of shipping production Flutter apps, BLE medical IoT hardware (DiaSpect TM), live sports streaming, and enterprise LMS platforms with Riverpod.',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.bodyLarge(context).copyWith(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
          ),
        ),

        const SizedBox(height: 28),

        // Action Buttons
        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
          children: [
            GradientButton(
              text: 'View Featured Work',
              icon: Icons.rocket_launch_rounded,
              onPressed: () => navNotifier.scrollToSection(NavigationSection.projects),
            ),
            GradientButton(
              text: 'Get In Touch',
              icon: Icons.send_rounded,
              isOutlined: true,
              onPressed: () => navNotifier.scrollToSection(NavigationSection.contact),
            ),
            GradientButton(
              text: 'Resume',
              icon: Icons.description_outlined,
              isOutlined: true,
              onPressed: () => UrlLauncherUtil.launchURL(context, AppStrings.resumeUrl),
            ),
          ],
        ),
      ],
    );
  }
}
