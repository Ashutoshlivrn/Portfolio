import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../../core/widgets/animated_glass_card.dart';
import '../../../core/widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    final pillars = [
      {
        'title': 'BLE & Medical IoT Integration',
        'desc': 'Interfacing Flutter with diagnostic devices (DiaSpect TM), binary packet parsing, and delivering winning live client demos.',
        'icon': Icons.bluetooth_audio_rounded,
        'accent': AppColors.primary,
      },
      {
        'title': 'Riverpod & Scalable LMS',
        'desc': 'Architected Acadle white-label enterprise LMS platform with robust unidirectional state, video tracking, and social interactions.',
        'icon': Icons.sync_alt_rounded,
        'accent': AppColors.secondary,
      },
      {
        'title': 'Legacy App Modernization',
        'desc': 'Refactored legacy ambulance & streaming platforms, eliminating screen flickering and upgrading years-old dependencies.',
        'icon': Icons.speed_rounded,
        'accent': AppColors.accent,
      },
      {
        'title': 'Live Streaming & Real-Time Maps',
        'desc': 'Multi-angle live match broadcasting (Ranji Trophy) and precision GPS map tracking with OTP validation for ambulances.',
        'icon': Icons.live_tv_rounded,
        'accent': AppColors.warning,
      },
    ];

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
                tag: '01. About Me',
                title: AppStrings.aboutHeader,
                subtitle: AppStrings.aboutSubHeader,
              ),
              const SizedBox(height: 48),

              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bio text left side
                    Expanded(
                      flex: 5,
                      child: _BioCard(),
                    ),
                    const SizedBox(width: 32),
                    // Pillars grid right side
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: pillars.map((p) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _PillarCard(
                              title: p['title'] as String,
                              desc: p['desc'] as String,
                              icon: p['icon'] as IconData,
                              accent: p['accent'] as Color,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _BioCard(),
                    const SizedBox(height: 24),
                    ...pillars.map((p) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _PillarCard(
                          title: p['title'] as String,
                          desc: p['desc'] as String,
                          icon: p['icon'] as IconData,
                          accent: p['accent'] as Color,
                        ),
                      );
                    }),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BioCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.code_rounded, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Engineering Background',
                style: AppTypography.titleLarge(context).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            AppStrings.bioParagraph1,
            style: AppTypography.bodyLarge(context),
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.bioParagraph2,
            style: AppTypography.bodyLarge(context),
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.bioParagraph3,
            style: AppTypography.bodyLarge(context),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          Wrap(
            spacing: 20,
            runSpacing: 12,
            children: [
              _InfoBadge(label: 'Location', value: AppStrings.location, icon: Icons.place_outlined),
              _InfoBadge(label: 'Experience', value: '${AppStrings.experienceYears} Years', icon: Icons.history_rounded),
              _InfoBadge(label: 'Education', value: 'B.Tech CSE (8.0 CGPA)', icon: Icons.school_outlined),
              _InfoBadge(label: 'Status', value: 'Ready to Ship', icon: Icons.check_circle_outline),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoBadge({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTypography.codeFont(
                fontSize: 10,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            Text(
              value,
              style: AppTypography.codeFont(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PillarCard extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;
  final Color accent;

  const _PillarCard({
    required this.title,
    required this.desc,
    required this.icon,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedGlassCard(
      hoverBorderColor: accent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: accent, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleLarge(context).copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
