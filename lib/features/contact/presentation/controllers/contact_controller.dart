import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/url_launcher_util.dart';
import '../../data/models/contact_form_state.dart';

class ContactController extends StateNotifier<ContactFormState> {
  ContactController() : super(const ContactFormState());

  void onNameChanged(String val) => state = state.copyWith(name: val);
  void onEmailChanged(String val) => state = state.copyWith(email: val);
  void onSubjectChanged(String val) => state = state.copyWith(subject: val);
  void onMessageChanged(String val) => state = state.copyWith(message: val);

  Future<void> submitForm(BuildContext context) async {
    if (state.name.trim().isEmpty ||
        state.email.trim().isEmpty ||
        state.message.trim().isEmpty) {
      state = state.copyWith(
        status: FormSubmissionStatus.error,
        errorMessage: 'Please fill in all required fields.',
      );
      return;
    }

    state = state.copyWith(status: FormSubmissionStatus.submitting, errorMessage: null);

    try {
      // Simulate network request for 1 second
      await Future.delayed(const Duration(milliseconds: 900));

      // Trigger email intent directly as fallback/integration
      if (context.mounted) {
        await UrlLauncherUtil.launchEmail(
          context,
          email: AppStrings.email,
          subject: '[Portfolio Inquiry] ${state.subject.isNotEmpty ? state.subject : 'Hello from ${state.name}'}',
          body: 'From: ${state.name} (${state.email})\n\n${state.message}',
        );
      }

      state = state.copyWith(status: FormSubmissionStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: FormSubmissionStatus.error,
        errorMessage: 'Failed to send message: $e',
      );
    }
  }

  void reset() {
    state = const ContactFormState();
  }
}

final contactControllerProvider =
    StateNotifierProvider<ContactController, ContactFormState>((ref) {
  return ContactController();
});
