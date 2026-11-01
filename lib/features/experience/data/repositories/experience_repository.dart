import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/experience_item.dart';

abstract class ExperienceRepository {
  List<ExperienceItem> getExperiences();
}

class InMemoryExperienceRepository implements ExperienceRepository {
  @override
  List<ExperienceItem> getExperiences() {
    return const [
      ExperienceItem(
        role: 'Senior Flutter Developer',
        company: 'Alobha Technologies',
        period: 'Mar 2026 – Oct 2026',
        location: 'Noida, India',
        isCurrent: true,
        description:
            'Spearheaded medical IoT hardware integrations, multi-role hospital ecosystems, emergency response app modernizations, live video streaming, and multi-currency service marketplaces.',
        highlights: [
          'BLE & Medical IoT (DiaSpect TM): Engineered Bluetooth Low Energy integration interfacing Flutter with DiaSpect TM medical equipment; handled real-time hemoglobin data capture, diagnostic test history, and delivered live client demos that secured project expansions.',
          'Emergency Response Overhaul (SBS Ambulance & Driver): Refactored 2 legacy apps (User & Driver); eliminated UI flickering, optimized state management, integrated precision live map tracking, driver dispatch, and OTP verification upon pickup.',
          'On-Demand Marketplace (Mesee User & Partner): Architected dual multi-country UrbanClap-style platforms featuring multi-currency payment gateways, digital wallet systems, automated late cancellation penalties, lead distribution, and work-status lifecycles.',
          'Live Sports Streaming (KheloGramin OTT & News): Upgraded 2-3 year old legacy dependencies to implement live multi-camera angle video streaming feeds for Ranji Trophy matches and crowdsourced community news reporting modules.',
          'Healthcare Platform (Eli Netram): Built complete hospital ecosystem for doctors and patients with online appointment booking, digital prescriptions, family member profiles, and integrated bill payment.',
          'Large-Scale UI Architecture: Delivered 200+ responsive screens for Pathshala (E-Learning) with Student/Teacher registration workflows, and designed complete screen suites & auth engine for Condo Pulse (Community Management).',
        ],
        technologies: [
          'Flutter SDK',
          'Dart',
          'Bluetooth Low Energy (BLE)',
          'Riverpod',
          'Live Video Streaming (HLS)',
          'Google Maps & OTP',
          'Payment Gateways & Wallets',
          'REST APIs',
        ],
      ),
      ExperienceItem(
        role: 'Flutter Developer',
        company: 'Vahmine Technologies Private Limited',
        period: 'Oct 2024 – Dec 2025',
        location: 'Noida, India',
        description:
            'Led development of the flagship white-label LMS platform Acadle using Flutter and Riverpod, delivering enterprise learning modules and social engagement features.',
        highlights: [
          'LMS Platform (Acadle): Built end-to-end video learning, quizzes, surveys, assessments, and video progress tracking modules using Riverpod for clean unidirectional state management.',
          'Social Engagement Suite: Implemented community feeds with posts, threaded comments, likes, and bookmarking via RESTful APIs, substantially boosting user retention.',
          'Security & Scalability: Engineered geo-based logout, secure session handling, role-based access control (RBAC), and multi-language internationalization.',
          'Code Optimization: Refactored core modules to enhance frame rates, reduce memory consumption, and ensure high responsiveness on varied device form factors.',
        ],
        technologies: [
          'Flutter',
          'Riverpod',
          'Clean Architecture',
          'RESTful APIs',
          'Geo-Location & Security',
          'LMS Architecture',
          'Multi-Language (i18n)',
        ],
      ),
      ExperienceItem(
        role: 'Flutter Developer',
        company: 'Robolaxy',
        period: 'Jun 2023 – Oct 2024',
        location: 'Chandigarh / Mohali, India',
        description:
            'Developed cross-platform mobile apps using Flutter and Dart across education and utility domains, modernizing legacy enterprise systems.',
        highlights: [
          'Java to Flutter Migration: Successfully migrated enterprise Java-based application workflows to Flutter, significantly elevating UI fluidity and cross-platform maintainability.',
          'Real-Time Cloud Backend: Integrated Firebase Authentication, Firestore, and Cloud Messaging (FCM) alongside REST APIs for seamless data synchronization.',
          'End-to-End Delivery: Handled UI/UX implementation from design specs, system testing, app debugging, and Play Store / App Store release preparation.',
        ],
        technologies: [
          'Flutter',
          'Dart',
          'BLoC / Provider',
          'Firebase (Auth, Firestore, FCM)',
          'Java Migration',
          'Git & App Deployment',
        ],
      ),
    ];
  }
}

final experienceRepositoryProvider = Provider<ExperienceRepository>((ref) {
  return InMemoryExperienceRepository();
});

final experiencesProvider = Provider<List<ExperienceItem>>((ref) {
  return ref.watch(experienceRepositoryProvider).getExperiences();
});
