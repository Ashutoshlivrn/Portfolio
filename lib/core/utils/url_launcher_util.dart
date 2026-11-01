import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class UrlLauncherUtil {
  static Future<void> launchURL(BuildContext context, String urlString) async {
    final uri = Uri.tryParse(urlString);
    if (uri == null) {
      _showErrorSnackBar(context, 'Invalid URL: $urlString');
      return;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && context.mounted) {
        _showErrorSnackBar(context, 'Could not open link: $urlString');
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, 'Error opening link: $e');
      }
    }
  }

  static Future<void> launchEmail(
    BuildContext context, {
    required String email,
    String? subject,
    String? body,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null && subject.isNotEmpty) 'subject': subject,
        if (body != null && body.isNotEmpty) 'body': body,
      },
    );

    try {
      final launched = await launchUrl(uri);
      if (!launched && context.mounted) {
        _showErrorSnackBar(context, 'Could not launch email client.');
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, 'Failed to launch email: $e');
      }
    }
  }

  static void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
