import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_typography.dart';
import '../../../core/utils/responsive_layout.dart';
import '../../../core/utils/url_launcher_util.dart';
import '../../../core/widgets/animated_glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/section_header.dart';
import '../data/models/contact_form_state.dart';
import 'controllers/contact_controller.dart';

class ContactSection extends ConsumerWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

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
                tag: '05. Connect',
                title: AppStrings.contactHeader,
                subtitle: AppStrings.contactSubHeader,
              ),
              const SizedBox(height: 48),

              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4, child: _ContactDetailsCard()),
                    const SizedBox(width: 32),
                    Expanded(flex: 6, child: _ContactForm()),
                  ],
                )
              else
                Column(
                  children: [
                    _ContactDetailsCard(),
                    const SizedBox(height: 24),
                    _ContactForm(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.forum_rounded, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 14),
              Text(
                'Let\'s Collaborate',
                style: AppTypography.titleLarge(context).copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Whether you need a Senior Flutter Engineer for a production build, an architectural consultation, or a contract project, my inbox is open.',
            style: AppTypography.bodyMedium(context),
          ),
          const SizedBox(height: 28),

          _ContactInfoTile(
            icon: Icons.email_outlined,
            title: 'Email',
            value: AppStrings.email,
            onTap: () => UrlLauncherUtil.launchEmail(context, email: AppStrings.email),
          ),
          const SizedBox(height: 16),
          _ContactInfoTile(
            icon: Icons.phone_outlined,
            title: 'Phone',
            value: AppStrings.phone,
            onTap: () => UrlLauncherUtil.launchURL(context, 'tel:${AppStrings.phone}'),
          ),
          const SizedBox(height: 16),
          _ContactInfoTile(
            icon: Icons.location_on_outlined,
            title: 'Location',
            value: AppStrings.location,
          ),
          const SizedBox(height: 16),
          _ContactInfoTile(
            icon: Icons.work_outline_rounded,
            title: 'Experience',
            value: '${AppStrings.experienceYears} Years Production Mobile Dev',
          ),

          const SizedBox(height: 28),
          const Divider(),
          const SizedBox(height: 20),

          // Resume Button
          GradientButton(
            text: 'Download Full Resume',
            icon: Icons.file_download_outlined,
            isOutlined: true,
            onPressed: () => UrlLauncherUtil.launchURL(context, AppStrings.resumeUrl),
          ),
        ],
      ),
    );
  }
}

class _ContactInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const _ContactInfoTile({
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 18, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.codeFont(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: AppTypography.bodyMedium(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: onTap != null ? AppColors.primary : Theme.of(context).colorScheme.onSurface,
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

class _ContactForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends ConsumerState<_ContactForm> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _subjectCtrl;
  late final TextEditingController _msgCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _subjectCtrl = TextEditingController();
    _msgCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(contactControllerProvider);
    final controller = ref.read(contactControllerProvider.notifier);

    return AnimatedGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send a Direct Message',
            style: AppTypography.titleLarge(context).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Fill out the form below to initiate an inquiry or discussion.',
            style: AppTypography.bodyMedium(context),
          ),
          const SizedBox(height: 24),

          if (formState.status == FormSubmissionStatus.success)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.accent),
              ),
              child: Column(
                children: [
                  const Icon(Icons.check_circle_rounded, color: AppColors.accent, size: 40),
                  const SizedBox(height: 12),
                  Text(
                    'Message Prepared & Email Launched!',
                    style: AppTypography.titleLarge(context).copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Thank you for reaching out. I will get back to you within 24 hours.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyMedium(context),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      _nameCtrl.clear();
                      _emailCtrl.clear();
                      _subjectCtrl.clear();
                      _msgCtrl.clear();
                      controller.reset();
                    },
                    child: const Text('Send Another Message'),
                  ),
                ],
              ),
            )
          else ...[
            if (formState.errorMessage != null)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.error),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        formState.errorMessage!,
                        style: const TextStyle(color: AppColors.error, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

            // Name field
            TextField(
              controller: _nameCtrl,
              onChanged: controller.onNameChanged,
              decoration: const InputDecoration(
                labelText: 'Your Name *',
                hintText: 'e.g. Sarah Connor',
                prefixIcon: Icon(Icons.person_outline_rounded, size: 20),
              ),
            ),
            const SizedBox(height: 16),

            // Email field
            TextField(
              controller: _emailCtrl,
              onChanged: controller.onEmailChanged,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address *',
                hintText: 'e.g. sarah@example.com',
                prefixIcon: Icon(Icons.email_outlined, size: 20),
              ),
            ),
            const SizedBox(height: 16),

            // Subject field
            TextField(
              controller: _subjectCtrl,
              onChanged: controller.onSubjectChanged,
              decoration: const InputDecoration(
                labelText: 'Subject',
                hintText: 'e.g. Senior Flutter Role / App Architecture',
                prefixIcon: Icon(Icons.subject_rounded, size: 20),
              ),
            ),
            const SizedBox(height: 16),

            // Message field
            TextField(
              controller: _msgCtrl,
              onChanged: controller.onMessageChanged,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Message *',
                hintText: 'Tell me about your product, project timeline, or team goals...',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24),

            // Submit Button
            formState.status == FormSubmissionStatus.submitting
                ? const Center(child: CircularProgressIndicator())
                : GradientButton(
                    text: 'Send Message',
                    icon: Icons.send_rounded,
                    onPressed: () => controller.submitForm(context),
                  ),
          ],
        ],
      ),
    );
  }
}
