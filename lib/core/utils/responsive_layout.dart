import 'package:flutter/material.dart';

/// Screen break-points standard for modern web and mobile apps.
abstract class Breakpoints {
  static const double mobileMax = 768;
  static const double tabletMax = 1024;
  static const double desktopMax = 1280;
  static const double maxContentWidth = 1200;
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < Breakpoints.mobileMax;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= Breakpoints.mobileMax && width < Breakpoints.tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= Breakpoints.tabletMax;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= Breakpoints.tabletMax) {
          return desktop;
        } else if (constraints.maxWidth >= Breakpoints.mobileMax) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}
