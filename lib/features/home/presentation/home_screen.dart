import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../about/presentation/about_section.dart';
import '../../contact/presentation/contact_section.dart';
import '../../experience/presentation/experience_section.dart';
import '../../hero/presentation/hero_section.dart';
import '../../navigation/controllers/navigation_controller.dart';
import '../../navigation/widgets/desktop_nav_bar.dart';
import '../../navigation/widgets/footer_section.dart';
import '../../navigation/widgets/mobile_drawer.dart';
import '../../projects/presentation/projects_section.dart';
import '../../skills/presentation/skills_section.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 400 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (_scrollController.offset <= 400 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final navNotifier = ref.read(navigationProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      drawer: isDesktop ? null : const MobileDrawer(),
      appBar: isDesktop
          ? null
          : AppBar(
              backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              elevation: 0,
              title: Row(
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
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                  onPressed: () => ref.read(themeModeProvider.notifier).toggleTheme(),
                  icon: Icon(
                    isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    color: isDark ? AppColors.warning : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
      body: Stack(
        children: [
          // Background ambient gradient glow
          Positioned(
            top: -150,
            left: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: isDark ? 0.08 : 0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 600,
            right: -150,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withValues(alpha: isDark ? 0.07 : 0.03),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                if (isDesktop) const SizedBox(height: 80), // Space for floating navbar

                // Hero Section
                Container(
                  key: navNotifier.sectionKeys[NavigationSection.home],
                  child: const HeroSection(),
                ),

                // About Section
                Container(
                  key: navNotifier.sectionKeys[NavigationSection.about],
                  child: const AboutSection(),
                ),

                // Skills Section
                Container(
                  key: navNotifier.sectionKeys[NavigationSection.skills],
                  child: const SkillsSection(),
                ),

                // Experience Section
                Container(
                  key: navNotifier.sectionKeys[NavigationSection.experience],
                  child: const ExperienceSection(),
                ),

                // Projects Section
                Container(
                  key: navNotifier.sectionKeys[NavigationSection.projects],
                  child: const ProjectsSection(),
                ),

                // Contact Section
                Container(
                  key: navNotifier.sectionKeys[NavigationSection.contact],
                  child: const ContactSection(),
                ),

                // Footer Section
                const FooterSection(),
              ],
            ),
          ),

          // Floating Desktop Navbar
          if (isDesktop)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: const DesktopNavBar(),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: _showBackToTop
          ? FloatingActionButton.small(
              tooltip: 'Back to top',
              backgroundColor: AppColors.primary,
              foregroundColor: const Color(0xFF0B0F19),
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOutCubic,
                );
              },
              child: const Icon(Icons.arrow_upward_rounded),
            )
          : null,
    );
  }
}
