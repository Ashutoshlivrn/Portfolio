import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project_item.dart';

abstract class ProjectRepository {
  List<ProjectItem> getProjects();
}

class InMemoryProjectRepository implements ProjectRepository {
  @override
  List<ProjectItem> getProjects() {
    return const [
      ProjectItem(
        id: 'diaspect',
        title: 'DiaSpect: Medical BLE Hardware Integration',
        tagline: 'Direct Bluetooth Low Energy integration with DiaSpect TM medical equipment.',
        description:
            'Engineered BLE communication layer to interface Flutter with DiaSpect TM diagnostic hardware. Parsed real-time binary data packets to extract hemoglobin levels, manage diagnostic records, and process rapid tests. Conducted in-person client technical demos that directly secured contract extensions.',
        tags: ['Flutter', 'Bluetooth Low Energy (BLE)', 'Medical IoT', 'Packet Parsing', 'Riverpod', 'Diagnostic Reports'],
        category: 'Hardware & IoT',
        githubUrl: 'https://github.com/Ashutoshlivrn',
        liveUrl: 'https://github.com/Ashutoshlivrn',
        stats: 'Hardware Certified • 100% Demo Pass',
        isFeatured: true,
      ),
      ProjectItem(
        id: 'mesee',
        title: 'Mesee: Multi-Country Service Marketplace',
        tagline: 'UrbanClap-style dual on-demand mobile apps for Users & Service Partners.',
        description:
            'Architected full-scale dual platforms handling multi-currency payment gateways, customer/partner wallet balances, automated penalty calculations for late cancellations, lead-bidding distribution, and real-time job milestone lifecycles (On the way, In-progress, Completed).',
        tags: ['Flutter', 'Multi-Currency', 'Wallet Engine', 'Lead Bidding', 'Stripe / Razorpay', 'Riverpod'],
        category: 'On-Demand & Fintech',
        githubUrl: 'https://github.com/Ashutoshlivrn',
        liveUrl: 'https://github.com/Ashutoshlivrn',
        stats: 'Dual App Ecosystem • Multi-Currency',
        isFeatured: true,
      ),
      ProjectItem(
        id: 'acadle',
        title: 'Acadle: Enterprise White-Label LMS',
        tagline: 'Scalable learning management system built with Flutter & Riverpod.',
        description:
            'Built the core mobile experience for Acadle at Vahmine Technologies. Implemented interactive video lessons, quizzes, assessments, real-time video progress tracking, and community social feeds (posts, comments, likes, bookmarks) powered by Riverpod state management and RESTful APIs.',
        tags: ['Flutter', 'Riverpod', 'Clean Arch', 'LMS Engine', 'Video Tracking', 'Social Feed'],
        category: 'EdTech & Enterprise',
        githubUrl: 'https://github.com/Ashutoshlivrn',
        liveUrl: 'https://github.com/Ashutoshlivrn',
        stats: 'Enterprise White-Label • Riverpod Core',
        isFeatured: true,
      ),
      ProjectItem(
        id: 'sbs_ambulance',
        title: 'SBS Emergency Ambulance System',
        tagline: 'Modernization of legacy User & Driver emergency response apps.',
        description:
            'Complete refactor of 2 legacy applications. Eliminated screen flickering by redesigning state management, integrated precision live map tracking, driver dispatch algorithms, targeted loading feedback, and OTP verification upon patient pickup.',
        tags: ['Flutter', 'Legacy Refactoring', 'Google Maps', 'OTP Verification', 'Real-Time Tracking'],
        category: 'Emergency & Maps',
        githubUrl: 'https://github.com/Ashutoshlivrn',
        liveUrl: 'https://github.com/Ashutoshlivrn',
        stats: 'Zero-Flicker UI • 2 Apps Modernized',
        isFeatured: true,
      ),
      ProjectItem(
        id: 'khelogramin',
        title: 'KheloGramin: OTT & Local News Platform',
        tagline: 'Live multi-angle match streaming for Ranji Trophy & hyperlocal news.',
        description:
            'Upgraded 2-3 year old legacy dependencies and modernized media playback engines. Engineered multi-camera angle video feed switching during live sports broadcasts and built community-driven incident reporting media upload modules.',
        tags: ['Flutter', 'HLS Live Streaming', 'Multi-Angle Feed', 'OTT Platform', 'News Media'],
        category: 'Media & Streaming',
        githubUrl: 'https://github.com/Ashutoshlivrn',
        liveUrl: 'https://github.com/Ashutoshlivrn',
        stats: 'Ranji Trophy Live Feeds • HLS Stream',
        isFeatured: false,
      ),
      ProjectItem(
        id: 'eli_netram',
        title: 'Eli Netram: Hospital & Doctor Platform',
        tagline: 'Complete eye hospital management system for doctors and patients.',
        description:
            'Built full hospital ecosystem connecting patients and doctors. Features include multi-member family profile management, instant doctor appointment booking, digital prescription viewer, pathology report downloads, and integrated billing.',
        tags: ['Flutter', 'Healthcare', 'Appointments', 'Digital Prescriptions', 'Payment Integration'],
        category: 'Healthcare & IoT',
        githubUrl: 'https://github.com/Ashutoshlivrn',
        liveUrl: 'https://github.com/Ashutoshlivrn',
        stats: 'Doctor & Patient Multi-Role',
        isFeatured: false,
      ),
      ProjectItem(
        id: 'video_enforce',
        title: 'Video Enforce Package',
        tagline: 'Custom Dart/Flutter package for strict video progress & watch-time enforcement.',
        description:
            'Developed a custom video enforcement package compatible with Vimeo, Wistia, and HTML5 video players. Implemented restricted forward seeking, auto-resume from last saved timestamp, completion tracking, and custom full-screen controls.',
        tags: ['Flutter Package', 'Vimeo & Wistia SDK', 'Video Player', 'Open Source', 'Dart'],
        category: 'Open Source',
        githubUrl: 'https://github.com/Ashutoshlivrn',
        liveUrl: 'https://github.com/Ashutoshlivrn',
        stats: 'Multi-Player Support (Vimeo, Wistia)',
        isFeatured: true,
      ),
      ProjectItem(
        id: 'pathshala_condo',
        title: 'Pathshala & Condo Pulse',
        tagline: 'Large-scale UI architecture: 200+ screens and community auth engines.',
        description:
            'Constructed over 200+ pixel-perfect, responsive screens for the Pathshala E-Learning app covering intricate student and teacher onboarding journeys. Integrated end-to-end authentication and community resident modules for Condo Pulse.',
        tags: ['Flutter', '200+ Screens', 'Design System', 'Role-Based Auth', 'Material 3'],
        category: 'EdTech & Enterprise',
        githubUrl: 'https://github.com/Ashutoshlivrn',
        liveUrl: 'https://github.com/Ashutoshlivrn',
        stats: '200+ Screens Architected',
        isFeatured: false,
      ),
    ];
  }
}

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return InMemoryProjectRepository();
});

final allProjectsProvider = Provider<List<ProjectItem>>((ref) {
  return ref.watch(projectRepositoryProvider).getProjects();
});
