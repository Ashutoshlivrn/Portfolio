import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/core/constants/app_strings.dart';
import 'package:portfolio/core/theme/theme_provider.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('PortfolioApp renders successfully with Riverpod ProviderScope',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const ProviderScope(
        child: PortfolioApp(),
      ),
    );

    // Pump initial frames
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Verify key portfolio developer info exists
    expect(find.text(AppStrings.developerName), findsWidgets);
    expect(find.text(AppStrings.openToWorkBadge), findsOneWidget);
  });

  test('ThemeNotifier toggles theme state correctly', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(themeModeProvider.notifier).isDarkMode, true);

    container.read(themeModeProvider.notifier).toggleTheme();
    expect(container.read(themeModeProvider.notifier).isDarkMode, false);

    container.read(themeModeProvider.notifier).toggleTheme();
    expect(container.read(themeModeProvider.notifier).isDarkMode, true);
  });
}
