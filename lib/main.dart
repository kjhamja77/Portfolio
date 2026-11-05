import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/utils/app_colors.dart';
import 'package:myportfolio/utils/scroll_behaviour.dart';
import 'package:myportfolio/screens/project_details.dart';
import 'package:myportfolio/widgets/animation_component/auro_background.dart';
import 'package:myportfolio/widgets/animation_component/floating.dart';
import 'package:myportfolio/widgets/animation_component/hover_lift.dart';
import 'package:myportfolio/widgets/animation_component/hover_scale.dart';
import 'package:myportfolio/widgets/animation_component/reveal_scope.dart';
import 'package:myportfolio/widgets/animation_component/reveal_widget.dart';
import 'package:myportfolio/widgets/animation_component/text_marque.dart';
import 'package:myportfolio/widgets/animation_component/tilt_on_hover.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: WebScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Halith Hamja',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home:  PortfolioHomePage()
    );
  }
}

const LinearGradient kSectionGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF0A0A23), Colors.black],
);

const BoxDecoration kSectionDecoration =
BoxDecoration(gradient: kSectionGradient);

const LinearGradient kBrandGradient = LinearGradient(
  colors: [AppColors.purple, AppColors.blue],
);

// ─────────────────────────────────────────────────────────────────────────────
// DATA
// ─────────────────────────────────────────────────────────────────────────────
final List<Map<String, dynamic>> kExperiences = [
  {
    'title': 'Mobile Application Developer (Flutter)',
    'company': 'Borderless Security FZCO, Dubai',
    'duration': 'Jan 2026 – Jul 2026',
    'points': [
      'Built four Flutter mobile applications across e-commerce, real estate and ERP: Kardosi, Estate Hub, FilesDNA and FilesDNA HR, delivering production-ready document and HR workflows.',
      'Integrated REST APIs and developed reusable Flutter components shared across the four applications for consistent and scalable feature delivery.',
      'Improved Kardosi loading performance for large API responses by moving heavy processing to Dart isolates and resolved production issues through debugging.',
      'Delivered multiple ERP web modules under tight timelines using AI-assisted development with Claude and ChatGPT, while owning requirements and business logic.',
    ],
  },
  {
    'title': 'Mobile Application Developer (Flutter)',
    'company': 'Gloup (Freelance), Chennai, India',
    'duration': 'Sep 2025 – Jan 2026',
    'points': [
      'Led a team of four to develop Gloup and Gloup Partner, driving Flutter mobile development and collaborating with backend developers on REST API planning.',
      'Collaborated on a technology stack involving Node.js backend, React.js frontend and AWS-hosted servers.',
      'Successfully launched both applications on Google Play and the App Store. Gloup achieved 10K+ downloads with a 4.0-star rating from 39 reviews, while Gloup Partner reached 500+ downloads.',
    ],
  },
  {
    'title': 'Mobile Application Developer (Flutter & Android)',
    'company': 'Inspire Clean Energy, Chennai, India',
    'duration': 'Jun 2024 – Jan 2025',
    'points': [
      'Developed Eira Connect (published on Google Play as TYKT, with 100+ downloads) for ticket management, image capture and cloud file handling using Flutter, REST APIs, Isar and AWS S3.',
      'Resolved application crashes affecting approximately 90% of user devices in Eira Connect by optimizing background-task handling and removing performance bottlenecks.',
      'Built Eira Monitoring for energy tracking and visualization using Flutter, REST APIs and Syncfusion Charts.',
      'Integrated a third-party heatmap chart through Kotlin and Flutter platform channels, passing datasets to native Android code for processing and visualization.',
      'Implemented password-protected PDF downloads and improved code quality through unit testing.',
    ],
  },
  {
    'title': 'Mobile Application Developer (Flutter)',
    'company': 'Numota Technologies (Freelance), Kanyakumari, India',
    'duration': 'Oct 2023 – Jan 2024',
    'points': [
      'Developed Nuchurch, a Flutter mobile application for church communities, implementing user login and church-oriented services through client backend integration.',
      'Built Christian learning content features, including Bible audio and Christian video playback.',
      'Implemented a directory of technician contact numbers to support the church community.',
    ],
  },
  {
    'title': 'Mobile Application Developer (Flutter & Android)',
    'company': 'Sanorac Technologies, Coimbatore, India',
    'duration': 'May 2023 – Oct 2023',
    'points': [
      'Developed and delivered Vividlipi and Degrees Tutorial Flutter applications with REST API and WooCommerce integrations.',
      'Integrated audio and YouTube playback, EPUB reading and Stripe/InstaMojo payment gateways.',
      'Built responsive BLoC-driven interfaces and managed source code and version control using GitLab.',
    ],
  },
  {
    'title': 'Flutter Developer',
    'company': 'Vugha Technological Solution, Chennai, India',
    'duration': 'Apr 2022 – Mar 2023',
    'points': [
      'Developed Ayani, Ayani Vendor and Ayani Transporter using Flutter, Firebase Authentication, Firestore and REST APIs through Firebase Functions.',
      'Ayani achieved 500+ Google Play downloads with a 4.4-star rating from 74 reviews, while Ayani Vendor reached 10+ downloads.',
      'Integrated Paytm payments, Firebase Crashlytics and Remote Config for payment processing, crash monitoring and dynamic updates.',
      'Supported CI/CD workflows and application releases on Google Play and the App Store.',
    ],
  },
  {
    'title': 'Software Developer',
    'company': 'Garuda Aerospace, Chennai, India',
    'duration': 'Jan 2021 – Oct 2021',
    'points': [
      'Developed a Flutter-based e-learning application using Firebase Authentication, Cloud Firestore and Firebase Storage.',
      'Customized a WordPress assessment website, implemented required features and optimized website performance.',
      'Provided ongoing website maintenance and technical support.',
    ],
  },
];

final List<Map<String, dynamic>> kEducation = [
  {
    'course': 'Master of Computer Application',
    'institution': 'Periyar Maniammai Institute of Science and Technology',
    'duration': '2017 – 2020',
    'icon': Icons.school_outlined,
  },
  {
    'course': 'Bachelor of Computer Science',
    'institution': 'Annai College of Arts and Science',
    'duration': '2015 – 2018',
    'icon': Icons.school,
  },
];

const List<String> kCategories = [
  'All',
  'Enterprise',
  'E-Commerce',
  'Education',
  'Delivery',
  'Community',
];

final List<Map<String, dynamic>> kProjects = [
  {
    'title': 'KJ Expense Tracker',
    'category': 'Finance',
    'subtitle': 'Personal Finance Application',
    'tagline': 'Know where every dirham goes.',
    'description':
    'A Flutter-based personal expense tracker that records bank and cash spending in one place, with period filters, date ranges and a clean light and dark interface.',
    'brief':
    "KJ Expense Tracker is a personal finance app built with Flutter for my own daily use, designed to make tracking money simple and clear. It brings bank transactions and cash expenses into a single list, picks up transactions from bank SMS alerts, and lets me add cash purchases manually with the amount, date, time and notes. Spending can be viewed by today, week or month, or filtered with a custom date range, so I can see exactly where my money goes. The app follows a consistent design system with light and dark themes, an animated splash screen and reusable UI components, built for a smooth and distraction-free experience.",
    'image': 'assets/kj_splash.png',
    'screenshots': [
      'assets/screenshots/kjE1.jpeg',
      'assets/screenshots/kjE2.jpeg',
      'assets/screenshots/kjE3.jpeg',
      'assets/screenshots/kjE4.jpeg',
      'assets/screenshots/kjE5.jpeg',
      'assets/screenshots/kjE6.jpeg',
      'assets/screenshots/kjE7.jpeg',
      'assets/screenshots/kjE8.jpeg',
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/git.png',
    ],
    'github': '',
    'playstore': '',
    'appstore': '',
  },
  {
    'title': 'Kardosi',
    'category': 'E-Commerce',
    'subtitle': 'E-Commerce Application',
    'tagline': 'Shop smarter. Sell faster. All in one app.',
    'description':
    'A Flutter-based e-commerce mobile application with REST API integration, delivering a seamless shopping experience with reusable UI components and optimized performance.',
    'brief':
    "Kardosi is an enterprise e-commerce mobile application built with Flutter, designed to deliver a smooth and reliable shopping experience across Android and iOS. The app integrates REST APIs for real-time product, order, and inventory data, with a focus on reusable UI components, optimized performance, and quick resolution of production issues. Built and maintained within an Agile team, Kardosi ensures a consistent, scalable, and user-friendly shopping journey from browsing to checkout.",
    'image': 'assets/kardosi.png',
    'screenshots': [
      'assets/screenshots/kardosi1.jpeg',
      'assets/screenshots/kardosi2.jpeg',
      'assets/screenshots/kardosi3.jpeg',
      'assets/screenshots/kardosi4.jpeg',
      'assets/screenshots/kardosi5.jpeg',
      'assets/screenshots/kardosi6.jpeg',
      'assets/screenshots/kardosi7.jpeg',
      'assets/screenshots/kardosi8.jpeg',
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/git.png',
      'assets/postman.png'
    ],
    'github': '',
    'playstore': '',
    'appstore': '',
  },
  {
    'title': 'Estate Hub',
    'category': 'Enterprise',
    'subtitle': 'Real Estate Application',
    'tagline': 'Find. List. Manage properties with ease.',
    'description':
    'A Flutter-based real estate application with REST API integration, enabling property listing, search, and management for a streamlined real estate experience.',
    'brief':
    "Estate Hub is an enterprise real estate mobile application developed with Flutter, built to simplify property listing, search, and management. It integrates REST APIs for real-time property data, offering users a smooth browsing and management experience with reusable, well-optimized UI components. The app was developed and maintained as part of a suite of enterprise applications, with an emphasis on performance, reliability, and Agile-driven feature delivery.",
    'image': 'assets/estate_hub.png',
    'screenshots': [
      'assets/screenshots/estatehub_pic1.jpeg',
      'assets/screenshots/estatehub_pic2.jpeg',
      'assets/screenshots/estatehub_pic3.jpeg',
      'assets/screenshots/estatehub_pic4.jpeg',
      'assets/screenshots/estatehub_pic5.jpeg',
      'assets/screenshots/estatehub_pic6.jpeg',
      'assets/screenshots/estatehub_pic7.jpeg',
      'assets/screenshots/estatehub_pic8.jpeg'
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/git.png',
      'assets/postman.png'
    ],
    'github': '',
    'playstore': '',
    'appstore': '',
  },
  {
    'title': 'FilesDNA',
    'category': 'Enterprise',
    'subtitle': 'ERP Application',
    'tagline': 'Organize. Track. Manage documents effortlessly.',
    'description':
    'A Flutter-based ERP module application for document management, built with REST API integration and AI-assisted development for faster, higher-quality delivery.',
    'brief':
    "FilesDNA is an enterprise ERP module application built with Flutter for streamlined document management. The app integrates REST APIs for real-time data synchronization and was developed with the support of AI-assisted tools, including Claude Code and ChatGPT, to accelerate development, improve code quality, and streamline implementation. FilesDNA focuses on reliable performance, reusable components, and a clean interface for managing enterprise documentation workflows.",
    'image': 'assets/filesdna.png',
    'screenshots': [
      'assets/screenshots/filesdna1.jpeg',
      'assets/screenshots/filesdna2.jpeg',
      'assets/screenshots/filesdna3.jpeg',
      'assets/screenshots/filesdna4.jpeg',
      'assets/screenshots/filesdna5.jpeg',
      'assets/screenshots/filesdna6.jpeg',
      'assets/screenshots/filesdna7.jpeg',
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/git.png',
      'assets/postman.png'
    ],
    'github': '',
    'playstore': '',
    'appstore': '',
  },
  {
    'title': 'FilesDNA HR',
    'category': 'Enterprise',
    'subtitle': 'ERP Application',
    'tagline': 'Simplify HR operations, one module at a time.',
    'description':
    'A Flutter-based ERP module application for HR and workforce management, built alongside FilesDNA with REST API integration and AI-assisted development.',
    'brief':
    "FilesDNA HR is a companion ERP module application to FilesDNA, developed with Flutter to handle HR and workforce management functions for enterprise clients. The app integrates REST APIs for real-time HR data and was built using AI-assisted development tools, including Claude Code and ChatGPT, to accelerate implementation and maintain high code quality. FilesDNA HR emphasizes performance, reusability, and a consistent user experience across the ERP suite.",
    'image': 'assets/filesdna_hr.png',
    'screenshots': [
      'assets/screenshots/filesdnahr1.jpeg',
      'assets/screenshots/filesdnahr2.jpeg',
      'assets/screenshots/filesdnahr3.jpeg',
      'assets/screenshots/filesdnahr4.jpeg',
      'assets/screenshots/filesdnahr5.jpeg',
      'assets/screenshots/filesdnahr6.jpeg',
      'assets/screenshots/filesdnahr7.jpeg',
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/git.png',
      'assets/postman.png'
    ],
    'github': '',
    'playstore': '',
    'appstore': '',
  },
  {
    'title': 'Gloup',
    'category': 'Beauty & Lifestyle',
    'subtitle': 'Salon Booking Application',
    'tagline': 'Discover salons. Find your style. Book your experience.',
    'description':
    'A Flutter-based salon application designed for users to discover and connect with salons through a seamless mobile experience.',
    'brief':
    "Gloup is a customer-facing salon application developed using Flutter to connect users with salon services. The application provides a convenient mobile platform for customers to explore salon offerings and connect with salons. It integrates REST APIs to communicate with the backend and delivers a responsive, user-friendly experience. Gloup was successfully launched on Google Play and the App Store, achieving 10K+ Google Play downloads with a 4.0-star rating from 39 reviews.",
    'image': 'assets/gloup_icon.png',
    'screenshots': [
      'assets/screenshots/gloup12.jpeg',
      'assets/screenshots/gloup11.jpeg',
      'assets/screenshots/gloup10.jpeg',
      'assets/screenshots/gloup9.jpeg',
      'assets/screenshots/gloup8.jpeg',
      'assets/screenshots/gloup7.jpeg',
      'assets/screenshots/gloup6.jpeg',
      'assets/screenshots/gloup5.jpeg',
      'assets/screenshots/gloup4.jpeg',
      'assets/screenshots/gloup3.jpeg',
      'assets/screenshots/gloup2.jpeg',
      'assets/screenshots/gloup1.jpeg',
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/postman.png',
      'assets/git.png',
      'assets/figma.png',
    ],
    'github': '',
    'playstore': 'https://play.google.com/store/apps/details?id=com.gloup.userapp&pcampaignid=web_share',
    'appstore': 'https://apps.apple.com/ar/app/gloup-salons-spas-near-you/id6752922662?l=en-GB',
  },

  {
    'title': 'Gloup Partner',
    'category': 'Business & Enterprise',
    'subtitle': 'Salon Management Application',
    'tagline': 'Manage your salon. Grow your business. Serve better.',
    'description':
    'A Flutter-based salon partner application designed for salon owners to manage their business through a dedicated mobile platform.',
    'brief':
    "Gloup Partner is a salon business application developed using Flutter specifically for salon owners and partners. It serves as a dedicated platform to help salon businesses manage their operations and interact with the Gloup ecosystem. The application integrates REST APIs for backend communication and provides a streamlined mobile experience for salon partners. Developed as part of the Gloup platform, the application was successfully launched on Google Play and the App Store, achieving 500+ Google Play downloads.",
    'image': 'assets/gloup_partner_icon.png',
    'screenshots': [
      'assets/screenshots/gloupp10.jpeg',
      'assets/screenshots/gloupp11.jpeg',
      'assets/screenshots/gloupp9.jpeg',
      'assets/screenshots/gloupp8.jpeg',
      'assets/screenshots/gloupp7.jpeg',
      'assets/screenshots/gloupp6.jpeg',
      'assets/screenshots/gloupp5.jpeg',
      'assets/screenshots/gloupp4.jpeg',
      'assets/screenshots/gloupp3.jpeg',
      'assets/screenshots/gloupp2.jpeg',
      'assets/screenshots/gloupp1.jpeg',

    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/postman.png',
      'assets/git.png',
      'assets/figma.png',
    ],
    'github': '',
    'playstore': 'https://play.google.com/store/apps/details?id=com.gloup.partnerapp&pcampaignid=web_share',
    'appstore': 'https://apps.apple.com/in/app/gloup-partner/id6752799057',
  },
  {
    'title': 'Eira',
    'category': 'Enterprise',
    'subtitle': 'Application',
    'tagline': 'Track. Analyze. Optimize your energy performance.',
    'description':
    'A Flutter-based energy monitoring app with REST API integration, featuring Syncfusion charts for accurate energy tracking, ticket management, and downloadable plant-level reports.',
    'brief':
    "A Flutter-based energy monitoring app that provides real-time visibility into plant performance and energy usage. It integrates with REST APIs to deliver accurate, up-to-date data and displays insights using interactive Syncfusion charts. Users can track energy trends, manage tickets, and download detailed plant-level reports for analysis and decision-making. The platform ensures reliable data handling, smooth performance, and a modern interface optimized for both mobile and tablet users.",
    'image': 'assets/eira_icon.png',
    'screenshots': [
      'assets/screenshots/Eira_monitor1.jpeg',
      'assets/screenshots/Eira_monitor2.jpeg',
      'assets/screenshots/Eira_monitor3.jpeg',
      'assets/screenshots/Eira_monitor4.jpeg',
      'assets/screenshots/Eira_monitor5.jpeg',
      'assets/screenshots/Eira_monitor7.jpeg',
      'assets/screenshots/Eira_monitor6.jpeg'
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/git.png',
      'assets/postman.png'
    ],
    'github': 'https://github.com/kjhamja77/Eira_Monitor',
    'playstore': '',
    'appstore': '',
  },
  {
    'title': 'Eira Connect',
    'category': 'Enterprise',
    'subtitle': 'Application',
    'tagline':
    'Smart ticketing built for the real world — capture, work offline, sync anywhere.',
    'description':
    'A Flutter-based ticket management application featuring image capture, offline data storage with Isar DB, location-based ticket access, and seamless server syncing through REST APIs.',
    'brief':
    "A robust Flutter-based ticket management system designed for field operations. The app enables users to capture and attach images directly through the device camera, store ticket data securely offline using Isar DB, and automatically synchronize updates to the server via REST APIs once connectivity is restored. It also features intelligent location-based ticket accessibility, ensuring users can only manage tickets relevant to their current geolocation. The solution offers a seamless workflow, high performance in offline environments, and reliable data consistency across devices.",
    'image': 'assets/eira_connect.png',
    'screenshots': [
      'assets/screenshots/eira_connect2.jpeg',
      'assets/screenshots/eira_connect1.jpeg',
      'assets/screenshots/eira_connect3.jpeg',
      'assets/screenshots/eira_connect4.jpeg',
      'assets/screenshots/eira_connect6.jpeg'
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/IsarDb.png',
      'assets/git.png',
      'assets/postman.png'
    ],
    'github': 'https://github.com/kjhamja77/Eiraconnect',
    'playstore':
    'https://play.google.com/store/apps/details?id=com.eiraconnect.nibhuna&pcampaignid=web_share',
    'appstore': '',
  },
  {
    'title': 'Nuchurch',
    'category': 'Community',
    'subtitle': 'Application',
    'tagline':
    'Connect with faith — book, learn, and grow with your church community.',
    'description':
    'A church application built with Flutter and REST APIs to book baptisms, view church events, and listen to Old and New Testament teachings.',
    'brief':
    'A church application built with Flutter, offering a simple and user-friendly way for parishioners to engage with their church. Through REST APIs, users can easily book baptisms, stay updated on upcoming church events, and explore community activities. The app also provides access to teachings from the Old and New Testaments, making spiritual learning available anytime. Overall, it serves as a convenient digital platform to support church involvement and spiritual growth.',
    'image': 'assets/nuchurch_icon.png',
    'screenshots': [
      'assets/screenshots/nuchurch2.jpeg',
      'assets/screenshots/nuchurch1.jpeg',
      'assets/screenshots/nuchurch3.jpeg',
      'assets/screenshots/nuchurch4.jpeg',
      'assets/screenshots/nuchurch5.jpeg'
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/git.png',
      'assets/postman.png'
    ],
    'github': 'https://github.com/kjhamja77/Nuchurch',
    'playstore': '',
    'appstore': '',
  },
  {
    'title': 'Vividlipi',
    'category': 'Education',
    'subtitle': 'Application',
    'tagline':
    'Read. Listen. Learn — all your knowledge in one intelligent media app.',
    'description':
    'A Flutter-based Learning & Media App that allows users to purchase and read books through WooCommerce, access an integrated EPUB reader, listen to podcasts, and watch YouTube videos.',
    'brief':
    'A Flutter-based Learning & Media App that brings books, podcasts, and videos into one unified platform. It connects with WooCommerce so users can easily browse, purchase, and access digital books. The built-in EPUB reader ensures a smooth, customizable reading experience. Users can also listen to podcasts and watch embedded YouTube videos without leaving the app. Overall, it provides a seamless and versatile digital learning environment.',
    'image': 'assets/vividlipi.png',
    'screenshots': [
      'assets/screenshots/vividlipi1.jpeg',
      'assets/screenshots/vividlipi2.jpeg',
      'assets/screenshots/vividlipi4.jpeg',
      'assets/screenshots/vividlipi5.jpeg',
      'assets/screenshots/vividlipi6.jpeg'
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/git.png',
      'assets/postman.png',
      'assets/figma.png'
    ],
    'github': 'https://github.com/kjhamja77/Vividlipi.git',
    'playstore': '',
    'appstore': '',
  },
  {
    'title': 'Degrees Tutorial',
    'category': 'Education',
    'subtitle': 'Application',
    'tagline':
    'Learn smarter — lessons, homework, and quizzes all in one seamless platform.',
    'description':
    'An education app for school students built with Flutter and REST APIs, providing course lessons, homework access, and quizzes to complete learning modules.',
    'brief':
    'An education app for school students built using Flutter, designed to make learning more interactive and accessible. It connects with REST APIs to deliver structured course lessons, updated content, and personalized study material. Students can view and submit homework directly through the app, making daily learning more organized. Engaging quizzes are included within each module to test understanding and reinforce key concepts. The app aims to provide a complete digital learning experience that supports both classroom and self-paced study.',
    'image': 'assets/degress_icon.png',
    'screenshots': [
      'assets/screenshots/degrees6.jpeg',
      'assets/screenshots/degrees2.jpeg',
      'assets/screenshots/degrees3.jpeg',
      'assets/screenshots/degrees4.jpeg',
      'assets/screenshots/degrees5.jpeg'
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/git.png',
      'assets/postman.png',
      'assets/figma.png'
    ],
    'github': 'https://github.com/kjhamja77/Degress_tutorial',
    'playstore': '',
    'appstore': '',
  },
  {
    'title': 'Ayani',
    'category': 'Delivery',
    'subtitle': 'Application',
    'tagline': 'Pure water delivered on demand — fast, simple, and secure.',
    'description':
    'A Flutter-based water delivery app for purchasing 20L water cans, integrated with Firebase for data management and Paytm for secure online payments.',
    'brief':
    'This Flutter-based water delivery app enables users to easily order and refill 20L water cans through a simple and intuitive interface. It uses Firebase for authentication, real-time database handling, and seamless order tracking. Secure online payments are integrated through Paytm, ensuring a smooth checkout experience. Users can manage addresses, view past orders, and receive real-time delivery notifications. Designed with scalability and performance in mind, it supports fast and reliable operations for delivery-based businesses.',
    'image': 'assets/ayani_icon.png',
    'screenshots': [
      'assets/screenshots/ayani1.jpg',
      'assets/screenshots/ayani2.jpg',
      'assets/screenshots/ayani3.jpg',
      'assets/screenshots/ayani4.jpg',
      'assets/screenshots/ayani5.jpg',
      'assets/screenshots/ayani6.jpg'
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/firebase.png',
      'assets/git.png',
      'assets/postman.png',
      'assets/xcode.png'
    ],
    'github': 'https://github.com/',
    'playstore':
    'https://play.google.com/store/apps/details?id=com.ayani.prod.vugha&pcampaignid=web_share',
    'appstore': 'https://apps.apple.com/in/app/ayani/id6444288601',
  },
  {
    'title': 'Ayani Vendor',
    'category': 'Delivery',
    'subtitle': 'Application',
    'tagline':
    'Enabling real-time visibility and operational control across vendor and delivery workflows.',
    'description':
    'A Flutter-based vendor app for managing orders, assigning deliveries to transporters, tracking can counts, and monitoring user can distribution using Firebase.',
    'brief':
    'This vendor management app is built using Flutter to streamline water delivery operations. Vendors can manage orders, assign deliveries to transporters, and track fulfillment progress in real time. Firebase handles authentication, secure data storage, and live synchronization. The system also monitors can movement, including issued, returned, and pending counts, ensuring accurate inventory tracking. With a simple and role-based workflow, the app improves delivery efficiency and operational control.',
    'image': 'assets/ayani_vendor.png',
    'screenshots': [
      'assets/screenshots/ayani_vendor1.jpg',
      'assets/screenshots/ayani_vendor2.jpg',
      'assets/screenshots/ayani_vendor3.jpg',
      'assets/screenshots/ayani_vendor4.jpg',
      'assets/screenshots/ayani_vendor5.jpg',
      'assets/screenshots/ayani_vendor6.jpg',
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/firebase.png',
      'assets/git.png'
    ],
    'github': 'https://github.com/kjhamja77/Ayani-vendor.git',
    'playstore':
    'https://play.google.com/store/apps/details?id=com.ayani_vendor.prod.vugha&pcampaignid=web_share',
    'appstore': '',
  },
  {
    'title': 'Ayani Transporter',
    'category': 'Delivery',
    'subtitle': 'Application',
    'tagline':
    'A smarter way for delivery partners to manage, track, and complete orders',
    'description':
    'A Flutter-based transporter app for delivery partners to manage assigned can deliveries, optimized using a shortest-distance routing algorithm, integrated with Firebase and REST APIs.',
    'brief':
    'This Flutter-based transporter app supports delivery partners managing 20L water can logistics. It uses a shortest-distance routing algorithm to optimize delivery sequences and reduce travel time. Partners can view assigned orders, update delivery status, and manage can returns in real time. Firebase handles authentication and storage, while REST APIs enable seamless data synchronization with vendor systems. The mobile-friendly interface ensures smooth and efficient on-route usage.',
    'image': 'assets/ayani_transporter.png',
    'screenshots': [
      'assets/screenshots/ayani_transporter1.jpeg',
      'assets/screenshots/ayani_transporter2.jpeg',
      'assets/screenshots/ayani_transporter3.jpeg',
      'assets/screenshots/ayani_transporter4.jpeg',
      'assets/screenshots/ayani_transporter5.jpeg'
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/firebase.png',
      'assets/git.png',
      'assets/postman.png'
    ],
    'github': 'https://github.com/kjhamja77/Ayani-transporter.git',
    'playstore': '',
    'appstore': '',
  },
  {
    'title': 'Hecho Digital',
    'category': 'E-Commerce',
    'subtitle': 'Application',
    'tagline':
    'A smarter way to source construction materials—fast, reliable, and seamless.',
    'description':
    'A Flutter-based e-commerce app to purchase construction materials like cement, bricks, steel rods, and other building supplies using REST API integration.',
    'brief':
    'This Flutter-based e-commerce app allows users to purchase construction materials like cement, bricks, and steel rods with ease. It integrates REST APIs to provide real-time product availability, accurate pricing, and smooth ordering. Users can browse categorized items, compare options, place orders, and track deliveries through an intuitive interface. With secure checkout and order history features, the app offers a seamless and reliable construction material purchasing experience.',
    'image': 'assets/hecho_digital.png',
    'screenshots': [
      'assets/screenshots/hecho3.jpeg',
      'assets/screenshots/hecho1.jpeg',
      'assets/screenshots/hecho2.jpeg',
      'assets/screenshots/hecho4.jpeg',
      'assets/screenshots/hecho5.jpeg'
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/postman.png'
    ],
    'github': '',
    'playstore': '',
    'appstore': '',
  },
  {
    'title': 'Hecho Merchant',
    'category': 'E-Commerce',
    'subtitle': 'Application',
    'tagline':
    'Manage, track, and grow your construction supply business with confidence.',
    'description':
    'A Flutter-based seller app to upload construction supplies and materials for sale on the Hecho Digital platform, built using REST APIs.',
    'brief':
    'This Flutter-based seller app enables vendors to upload and manage construction materials for sale on the Hecho Digital platform. With REST API integration, product details, pricing, and stock updates sync in real time for accurate marketplace listings. Sellers can track orders, manage product status, and access performance insights through an intuitive interface. The app includes secure authentication, scalable architecture, and essential tools to streamline product management and support efficient digital selling.',
    'image': 'assets/hecho_merchant.png',
    'screenshots': [
      'assets/screenshots/hecho_merchant1.jpeg',
      'assets/screenshots/hecho_merchant2.jpeg',
      'assets/screenshots/hecho_merchant3.jpeg',
      'assets/screenshots/hecho_merchant4.jpeg',
      'assets/screenshots/hecho_merchant5.jpeg'
    ],
    'techStack': [
      'assets/flutter.png',
      'assets/RestAPI.png',
      'assets/postman.png'
    ],
    'github': '',
    'playstore': '',
    'appstore': '',
  },
  {
    'title': 'Garuda E-Learning',
    'category': 'Education',
    'subtitle': 'Application',
    'tagline':
    'A Modern Learning Platform Built for Precision, Progress, and Aerospace Excellence.',
    'description':
    'A Flutter-based e-learning app with pre-recorded aerospace lessons and PDF study materials, powered by Firebase.',
    'brief':
    'This Flutter-based e-learning app delivers pre-recorded aerospace lessons with a smooth and structured learning experience. Users can also access downloadable PDF study materials for revision and deeper understanding. With Firebase integration, the app ensures secure authentication, real-time data handling, and seamless progress tracking. Designed for scalability, it provides an efficient and user-friendly digital learning platform.',
    'image': 'assets/garuda_icon.png',
    'screenshots': [],
    'techStack': ['assets/flutter.png', 'assets/firebase.png'],
    'github': '',
    'playstore': '',
    'appstore': '',
  },
];

// ─────────────────────────────────────────────────────────────────────────────
// HOME PAGE
// ─────────────────────────────────────────────────────────────────────────────
class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scroll = ScrollController();
  final _aboutKey = GlobalKey();
  final _resumeKey = GlobalKey();
  final _portfolioKey = GlobalKey();

  final ValueNotifier<double> _progress = ValueNotifier(0);
  final ValueNotifier<int> _active = ValueNotifier(-1);
  final ValueNotifier<bool> _showTop = ValueNotifier(false);
  final ValueNotifier<Offset?> _mouse = ValueNotifier(null);

  String _filter = 'All';

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    _progress.dispose();
    _active.dispose();
    _showTop.dispose();
    _mouse.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scroll.hasClients) return;
    final pos = _scroll.position;
    _progress.value =
    pos.maxScrollExtent > 0 ? (pos.pixels / pos.maxScrollExtent) : 0;
    _showTop.value = pos.pixels > 500;

    int a = -1;
    final keys = [_aboutKey, _resumeKey, _portfolioKey];
    for (int i = 0; i < keys.length; i++) {
      final box = keys[i].currentContext?.findRenderObject();
      if (box is RenderBox && box.attached) {
        if (box.localToGlobal(Offset.zero).dy <= 180) a = i;
      }
    }
    _active.value = a;
  }

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  void _toTop() {
    _scroll.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (kDebugMode) print('Could not launch $url');
    }
  }

  // ───────────────────────── CONTACT DIALOG ─────────────────────────
  void _showContacts() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Contacts',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 380),
      transitionBuilder: (ctx, anim, _, child) {
        final curved =
        CurvedAnimation(parent: anim, curve: Curves.easeOutBack);
        return FadeTransition(
          opacity: anim,
          child: ScaleTransition(scale: curved, child: child),
        );
      },
      pageBuilder: (ctx, _, __) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: math.min(380, MediaQuery.of(ctx).size.width - 40),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white12),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF131347), Color(0xFF0B0B1E)],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blue.withValues(alpha: 0.25),
                  blurRadius: 40,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Contacts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                _contactTile(Icons.email_outlined, 'Email',
                    'kjhamja77@gmail.com', 'mailto:kjhamja77@gmail.com'),
                _contactTile(Icons.phone_outlined, 'Phone - India',
                    '+91 7695818144', 'https://wa.me/+917695818144'),
                _contactTile(Icons.phone_outlined, 'Phone - UAE',
                    '+971 58 841 0143', 'https://wa.me/+971588410143'),
                _contactTile(Icons.location_on_outlined, 'Location',
                    'Bur Dubai, Dubai', 'https://maps.app.goo.gl/UXx5hs7EMRndSEkq9'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _socialCircle(
                      'LinkedIn',
                      'assets/linkedIn.png',
                      'https://www.linkedin.com/in/halith-hamja-218476204/',
                    ),
                    _socialCircle(
                      'GitHub',
                      'assets/gitHub.png',
                      'https://github.com/kjhamja77',
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Close',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contactTile(IconData icon, String title, String sub, String url) {
    return ListTile(
      leading: Icon(icon, color: Colors.white60),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(sub, style: const TextStyle(color: Colors.white60)),
      onTap: () => _openUrl(url),
    );
  }

  Widget _socialCircle(String tip, String asset, String url) {
    return HoverScale(
      child: Tooltip(
        message: tip,
        child: Container(
          decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: IconButton(
            tooltip: tip,
            onPressed: () => _openUrl(url),
            icon: Image.asset(asset, height: 40, width: 40, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  // ───────────────────────── NAV BAR ─────────────────────────

  Widget _buildNavBar(double width) {
    final isSmall = width < 900;

    final navItems = [
      {'label': 'About', 'key': _aboutKey},
      {'label': 'Resume', 'key': _resumeKey},
      {'label': 'Projects', 'key': _portfolioKey},
    ];

    Widget navButton(String label, int index, int active) {
      final selected = active == index;

      return HoverScale(
        scale: 1.04,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: selected
                ? AppColors.purple.withValues(alpha: 0.13)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? AppColors.purple.withValues(alpha: 0.25)
                  : Colors.transparent,
            ),
          ),
          child: TextButton(
            onPressed: () =>
                _scrollTo(navItems[index]['key'] as GlobalKey),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              overlayColor: AppColors.purple.withValues(alpha: 0.12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                    selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected ? Colors.white : Colors.white70,
                  ),
                  child: Text(label),
                ),
                const SizedBox(height: 5),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  height: 3,
                  width: selected ? 22 : 0,
                  decoration: BoxDecoration(
                    gradient: kBrandGradient,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: selected
                        ? [
                      BoxShadow(
                        color: AppColors.purple
                            .withValues(alpha: 0.5),
                        blurRadius: 8,
                      ),
                    ]
                        : [],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget contactButton() {
      return HoverScale(
        scale: 1.06,
        child: Container(
          decoration: BoxDecoration(
            gradient: kBrandGradient,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.purple.withValues(alpha: 0.3),
                blurRadius: 18,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _showContacts,
              borderRadius: BorderRadius.circular(30),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.call_rounded,
                      color: Colors.white,
                      size: 17,
                    ),
                    SizedBox(width: 9),
                    Text(
                      'Contact Me',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_outward_rounded,
                      color: Colors.white70,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF080811).withValues(alpha: 0.97),
        border: Border(
          bottom: BorderSide(
            color: AppColors.purple.withValues(alpha: 0.22),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width < 600 ? 16 : 30,
            vertical: 12,
          ),
          child: Row(
            children: [
              // Logo and profile
              Expanded(
                flex: isSmall ? 1 : 2,
                child: InkWell(
                  onTap: _toTop,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            gradient: kBrandGradient,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: Image.asset(
                              'assets/kjh_logo.png',
                              height: 46,
                              width: 46,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Halith Hamja',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.4,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Mobile App Developer',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 12,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Desktop navigation
              if (!isSmall)
                Expanded(
                  flex: 2,
                  child: ValueListenableBuilder<int>(
                    valueListenable: _active,
                    builder: (_, active, __) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < navItems.length; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: navButton(
                                navItems[i]['label'] as String,
                                i,
                                active,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),

              // Contact / mobile menu
              Expanded(
                flex: isSmall ? 0 : 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: isSmall
                      ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white12,
                      ),
                    ),
                    child: Builder(
                      builder: (context) => IconButton(
                        tooltip: 'Open navigation menu',
                        onPressed: () =>
                            Scaffold.of(context).openEndDrawer(),
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  )
                      : contactButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────────── HERO ─────────────────────────
  Widget _heroSection(double width) {
    final bool isMobile = width < 800;
    final bool isTablet = width >= 800 && width < 1150;
    final bool isXL = width >= 1500;
    final center = isMobile;

    // Fluid sizes: they grow with the screen on desktop / full-screen.
    final double nameSize =
    isMobile ? 43 : (isTablet ? 54 : (width * 0.05).clamp(60.0, 96.0));
    final double titleSize =
    isMobile ? 21 : (isTablet ? 25 : (width * 0.0175).clamp(26.0, 36.0));
    final double roleSize = isMobile ? 16 : (titleSize * 0.78);
    final double descSize =
    isMobile ? 16 : (isTablet ? 17 : (width * 0.0098).clamp(17.0, 22.0));
    final double descMaxW =
    isMobile ? 600 : (width * 0.38).clamp(520.0, 760.0);
    final double btnH = isXL ? 60 : 52;
    final double btnFont = isXL ? 18 : 16;
    final double scale = isMobile ? 1 : (isXL ? 1.25 : 1.1);

    final text = Column(
      crossAxisAlignment:
      center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Reveal(
          delay: const Duration(milliseconds: 100),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 17 * scale, vertical: 9 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFF090D24),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.purple.withValues(alpha: .5),
              ),
            ),
            child: Text(
              "👋 Hello, I'm",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16 * scale,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 22 * scale),
        Reveal(
          delay: const Duration(milliseconds: 250),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: center ? Alignment.center : Alignment.centerLeft,
            child: RichText(
              textAlign: center ? TextAlign.center : TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Halith ',
                    style: GoogleFonts.poppins(
                      color: AppColors.white,
                      fontSize: nameSize,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -nameSize * 0.035,
                    ),
                  ),
                  TextSpan(
                    text: 'Hamja',
                    style: GoogleFonts.poppins(
                      fontSize: nameSize,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -nameSize * 0.035,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: [AppColors.purple, AppColors.blue],
                        ).createShader(
                          Rect.fromLTWH(0, 0, nameSize * 4.6, nameSize),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 16 * scale),
        Reveal(
          delay: const Duration(milliseconds: 400),
          child: Text(
            'Mobile Application Developer',
            textAlign: center ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              color: AppColors.white,
              fontSize: titleSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 10 * scale),
        Reveal(
          delay: const Duration(milliseconds: 520),
          child: SizedBox(
            height: roleSize * 1.7,
            child: DefaultTextStyle(
              style: TextStyle(
                color: AppColors.blue,
                fontSize: roleSize,
                fontWeight: FontWeight.w500,
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(milliseconds: 1400),
                animatedTexts: [
                  TypewriterAnimatedText('Flutter Developer 💙',
                      speed: const Duration(milliseconds: 70)),
                  TypewriterAnimatedText('Kotlin Android Engineer 🤖',
                      speed: const Duration(milliseconds: 70)),
                  TypewriterAnimatedText('Cross-platform App Builder 🚀',
                      speed: const Duration(milliseconds: 70)),
                  TypewriterAnimatedText('Firebase & REST API Integrator ⚡',
                      speed: const Duration(milliseconds: 70)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12 * scale),
        Reveal(
          delay: const Duration(milliseconds: 640),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: descMaxW),
            child: Text(
              'Building seamless cross-platform mobile applications using '
                  'Flutter & Android that solve real-world problems and deliver '
                  'exceptional user experiences.',
              textAlign: center ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                color: AppColors.muted,
                fontSize: descSize,
                height: 1.65,
              ),
            ),
          ),
        ),
        SizedBox(height: 30 * scale),
        Reveal(
          delay: const Duration(milliseconds: 780),
          child: Wrap(
            alignment: center ? WrapAlignment.center : WrapAlignment.start,
            spacing: 14,
            runSpacing: 12,
            children: [
              HoverScale(
                scale: 1.06,
                child: Container(
                  height: btnH,
                  decoration: BoxDecoration(
                    gradient: kBrandGradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blue.withValues(alpha: .3),
                        blurRadius: 24,
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () => _openUrl('mailto:kjhamja77@gmail.com'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 26 * scale),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: Icon(Icons.email_outlined,
                        color: Colors.white, size: btnFont + 4),
                    label: Text(
                      'Contact Me',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: btnFont,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              HoverScale(
                scale: 1.06,
                child: SizedBox(
                  height: btnH,
                  child: OutlinedButton.icon(
                    onPressed: () => _openUrl(
                      'https://drive.google.com/file/d/1yJocI7d7IvQu8eRrFvOcPbXMQ98oONPO/view?usp=sharing',
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.white,
                      side: BorderSide(
                        color: AppColors.blue.withValues(alpha: .8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 26 * scale),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: Icon(Icons.download_outlined, size: btnFont + 4),
                    label: Text('Download CV',
                        style: TextStyle(fontSize: btnFont)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 36 * scale),
        Reveal(
          delay: const Duration(milliseconds: 920),
          child: Wrap(
            alignment: center ? WrapAlignment.center : WrapAlignment.start,
            spacing: 14 * scale,
            runSpacing: 14 * scale,
            children: [
              _statCard(4, '+', 'Years Experience', scale),
              _statCard(kProjects.length, '', 'Apps Built', scale),
              _statCard(kExperiences.length, '', 'Companies', scale),
            ],
          ),
        ),
      ],
    );

    // The photo already has its own frame, icons and dots, so it is shown
    // whole (no cropping, no second border) and simply fills its column.
    final image = LayoutBuilder(
      builder: (context, c) {
        final double maxW = isMobile ? 380 : (isTablet ? 470 : (isXL ? 800 : 660));
        final double w = math.min(c.maxWidth, maxW);
        return Reveal(
          from: isMobile ? RevealFrom.bottom : RevealFrom.right,
          delay: const Duration(milliseconds: 450),
          duration: const Duration(milliseconds: 1100),
          distance: 70,
          child: Floating(
            amplitude: 8,
            child: TiltOnHover(
              child: SizedBox(
                width: w,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // soft glow behind the picture
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.purple.withValues(alpha: .28),
                                blurRadius: 90,
                                spreadRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/profile.png',
                      width: w,
                      fit: BoxFit.fitWidth,
                      errorBuilder: (c, e, s) => Container(
                        width: w,
                        height: w * 1.1,
                        color: const Color(0xFF0A0D20),
                        child: const Icon(Icons.person,
                            color: Colors.white, size: 90),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    final double hPad = isMobile ? 24 : (isTablet ? 45 : (isXL ? 110 : 78));
    final double vPad = isMobile ? 55 : (isXL ? 90 : 70);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF08091E), Color(0xFF030511), Color(0xFF010208)],
        ),
      ),
      child: Stack(
        children: [
          const Positioned.fill(child: AuroraBackground()),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1900),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
                child: isMobile
                    ? Column(
                  children: [text, const SizedBox(height: 44), image],
                )
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 10, child: text),
                    SizedBox(width: isXL ? 60 : 30),
                    Expanded(flex: 9, child: Center(child: image)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(int target, String suffix, String label, double scale) {
    return Reveal.builder(
      from: RevealFrom.none,
      builder: (context, anim) => HoverLift(
        glow: AppColors.purple,
        color: const Color(0xFF090D24),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 22 * scale, vertical: 14 * scale),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: anim,
                builder: (_, __) {
                  final v = (target * Curves.easeOutCubic.transform(anim.value))
                      .round();
                  return ShaderMask(
                    shaderCallback: (r) => kBrandGradient.createShader(r),
                    child: Text(
                      '$v$suffix',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28 * scale,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 2),
              Text(label,
                  style: TextStyle(
                      color: AppColors.muted, fontSize: 13 * scale)),
            ],
          ),
        ),
      ),
    );
  }
  // ───────────────────────── ABOUT ─────────────────────────
  Widget _aboutSection() {
    final skills = [
      ['assets/flutter.png', 'Flutter'],
      ['assets/kotlin.png', 'Kotlin'],
      ['assets/python.png', 'Python'],
      ['assets/firebase.png', 'Firebase'],
    ];
    final tools = [
      ['assets/androidStudio.png', 'Android Studio'],
      ['assets/xcode.png', 'Xcode'],
      ['assets/vscode.png', 'VS Code'],
      ['assets/postman.png', 'Postman'],
      ['assets/git.png', 'Git'],
      ['assets/figma.png', 'Figma'],
    ];

    return Container(
      key: _aboutKey,
      decoration: kSectionDecoration,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _SectionTitle('About Me', center: true),
          const SizedBox(height: 30),
          Reveal(
            delay: const Duration(milliseconds: 150),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 900),
              child: const Text(
                "I'm a passionate mobile app developer specializing in Flutter and Kotlin, focused on building high-quality cross-platform applications with clean architecture, smooth performance, and modern UI design. "
                    "I work extensively with Flutter, Firebase, and REST APIs, delivering scalable and user-friendly apps for Android and iOS. "
                    "I enjoy solving real-world problems through code, optimizing app performance, and turning ideas into polished products. "
                    "Beyond development, I stay committed to continuous learning — keeping up with emerging tools, technologies, and design trends to improve my skills and build better experiences.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 17,
                  height: 1.7,
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Reveal(
            child: const Text(
              'Technical Skills',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 50,
            runSpacing: 40,
            children: [
              for (int i = 0; i < skills.length; i++)
                _skillIcon(skills[i][0], skills[i][1], i),
            ],
          ),
          const SizedBox(height: 80),
          Reveal(
            child: const Text(
              'Tools & Environments',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 50,
            runSpacing: 40,
            children: [
              for (int i = 0; i < tools.length; i++)
                _skillIcon(tools[i][0], tools[i][1], i),
            ],
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _skillIcon(String asset, String label, int index) {
    return Reveal(
      delay: Duration(milliseconds: index * 90),
      distance: 30,
      child: _SkillBadge(asset: asset, label: label),
    );
  }

  // ───────────────────────── RESUME ─────────────────────────
  Widget _resumeSection() {
    return Container(
      key: _resumeKey,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
      decoration: kSectionDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle('Resume'),
          const SizedBox(height: 32),
          Reveal(
            from: RevealFrom.left,
            child: const Text(
              'Experience',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (_, constraints) {
              final bool single = constraints.maxWidth < 900;
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  for (int i = 0; i < kExperiences.length; i++)
                    SizedBox(
                      width: single
                          ? constraints.maxWidth
                          : (constraints.maxWidth / 2) - 32,
                      child: Reveal(
                        delay: Duration(milliseconds: single ? 0 : (i % 2) * 150),
                        from: single
                            ? RevealFrom.bottom
                            : (i.isEven ? RevealFrom.left : RevealFrom.right),
                        child: _experienceCard(kExperiences[i]),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 40),
          const Divider(color: Colors.white30, thickness: 1),
          const SizedBox(height: 32),
          Reveal(
            from: RevealFrom.left,
            child: const Text(
              'Education',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _educationCard(),
        ],
      ),
    );
  }

  Widget _richPoint(String text) {
    final parts = text.split('**');
    return Text.rich(
      TextSpan(
        children: [
          for (int i = 0; i < parts.length; i++)
            TextSpan(
              text: parts[i],
              style: i.isOdd
                  ? const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600)
                  : null,
            ),
        ],
      ),
      style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
    );
  }

  Widget _experienceCard(Map<String, dynamic> exp) {
    final points = (exp['points'] as List).cast<String>();
    return HoverLift(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: kBrandGradient,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    exp['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(exp['company'],
                style: const TextStyle(color: Colors.white70, fontSize: 16)),
            Text(exp['duration'],
                style: const TextStyle(color: Colors.white54, fontSize: 14)),
            const SizedBox(height: 12),
            for (final p in points)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: Colors.white70)),
                    Expanded(child: _richPoint(p)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _educationCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isRow = constraints.maxWidth > 900;
        final cards = [
          for (int i = 0; i < kEducation.length; i++)
            Reveal(
              delay: Duration(milliseconds: i * 150),
              child: HoverLift(
                glow: AppColors.purple,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListTile(
                    leading: Icon(kEducation[i]['icon'],
                        color: Colors.indigoAccent, size: 36),
                    title: Text(
                      kEducation[i]['course'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      '${kEducation[i]['institution']}\n${kEducation[i]['duration']}',
                      style:
                      const TextStyle(color: Colors.white70, height: 1.4),
                    ),
                  ),
                ),
              ),
            ),
        ];
        return isRow
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final c in cards)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: c,
                ),
              ),
          ],
        )
            : Column(
          children: [
            for (final c in cards)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: c,
              ),
          ],
        );
      },
    );
  }

  // ───────────────────────── PROJECTS ─────────────────────────
  Widget _portfolioSection() {
    final filtered = _filter == 'All'
        ? kProjects
        : kProjects.where((p) => p['category'] == _filter).toList();

    return Container(
      key: _portfolioKey,
      decoration: kSectionDecoration,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardW = math.min(400.0, constraints.maxWidth);
          final cardH = MediaQuery.of(context).size.width < 500 ? 375.0 : 340.0;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionTitle('Projects'),
              const SizedBox(height: 20),
              Reveal(
                delay: const Duration(milliseconds: 150),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final c in kCategories) _filterChip(c),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Wrap(
                    key: ValueKey(_filter),
                    spacing: 30,alignment: WrapAlignment.spaceBetween,
                    runSpacing: 30,
                    children: [
                      for (int i = 0; i < filtered.length; i++)
                        Reveal(
                          delay: Duration(milliseconds: (i % 3) * 120),
                          distance: 50,
                          child: _ProjectCard(
                            p: filtered[i],
                            width: cardW,
                            height: cardH,
                            onOpenUrl: _openUrl,
                            onTap: () => _openProject(filtered[i]),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _filterChip(String label) {
    final selected = _filter == label;
    return HoverScale(
      scale: 1.05,
      child: GestureDetector(
        onTap: () => setState(() => _filter = label),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
            decoration: BoxDecoration(
              gradient: selected ? kBrandGradient : null,
              color: selected ? null : Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: selected ? Colors.transparent : Colors.white24,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.white70,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openProject(Map<String, dynamic> p) {
    List<String> screenshots;
    List<String> techStacks;

    var raw = p['screenshots'];
    var stacks = p['techStack'];

    if (raw is List && stacks is List) {
      screenshots = List<String>.from(raw);
      techStacks = List<String>.from(stacks);
    } else if ((raw is String && raw.contains(',')) &&
        (stacks is String && stacks.contains(','))) {
      screenshots = raw.split(',').map((e) => e.trim()).toList();
      techStacks = stacks.split(',').map((e) => e.trim()).toList();
    } else if ((raw is String && raw.isNotEmpty) &&
        (stacks is String && stacks.isNotEmpty)) {
      screenshots = [raw];
      techStacks = [stacks];
    } else {
      screenshots = [];
      techStacks = [];
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 450),
        pageBuilder: (_, __, ___) => ProjectDetailsPage(
          projectName: p['title'].toString(),
          tagline: p['tagline'].toString(),
          description: p['brief'].toString(),
          logoPath: p['image'].toString(),
          screenshots: screenshots,
          techStack: techStacks,
          playstoreUrl: p['playstore'],
          appstoreUrl: p['appstore'],
        ),
        transitionsBuilder: (_, anim, __, child) {
          final curved =
          CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.06),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  // ───────────────────────── CTA ─────────────────────────
  Widget _ctaSection() {
    Widget btn(
        IconData icon,
        String label,
        String url, {
          bool primary = false,
        }) {
      return HoverScale(
        scale: 1.06,
        child: OutlinedButton.icon(
          onPressed: () => _openUrl(url),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: primary
                ? AppColors.purple
                : Colors.white.withValues(alpha: 0.03),
            side: BorderSide(
              color: primary
                  ? AppColors.purple
                  : Colors.white.withValues(alpha: 0.25),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: primary ? 28 : 20,
              vertical: primary ? 17 : 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          icon: Icon(icon, size: 19),
          label: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 80,
      ),
      decoration: kSectionDecoration,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background glow
          Positioned(
            child: Container(
              width: 400,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.purple.withValues(alpha: 0.15),
                    blurRadius: 140,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),

          Center(
            child: Reveal(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 52,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: AppColors.purple.withValues(alpha: 0.4),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.purple.withValues(alpha: 0.22),
                      AppColors.blue.withValues(alpha: 0.08),
                      const Color(0xFF0D1020),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.purple.withValues(alpha: 0.08),
                      blurRadius: 35,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Availability indicator
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.green.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle,
                            color: Color(0xFF45D6A0),
                            size: 9,
                          ),
                          SizedBox(width: 9),
                          Text(
                            'OPEN TO OPPORTUNITIES',
                            style: TextStyle(
                              color: Color(0xFF75E5BC),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Heading
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Let's build "),
                          TextSpan(
                            text: 'something great',
                            style: TextStyle(
                              color: Color(0xFFA98AFF),
                            ),
                          ),
                          TextSpan(text: ' together.'),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Have a project, an exciting idea, or a job opportunity? '
                          'I would love to hear about it.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        height: 1.7,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Primary CTA
                    btn(
                      Icons.send_rounded,
                      "Let's Talk",
                      'mailto:kjhamja77@gmail.com',
                      primary: true,
                    ),

                    const SizedBox(height: 35),

                    // Divider
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 450),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'OR CONNECT WITH ME',
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 10,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white.withValues(alpha: 0.15),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Social links
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 14,
                      runSpacing: 14,
                      children: [
                        btn(
                          Icons.chat_bubble_outline,
                          'WhatsApp',
                          'https://wa.me/971588410143',
                        ),
                        btn(
                          Icons.link,
                          'LinkedIn',
                          'https://www.linkedin.com/in/halith-hamja-218476204/',
                        ),
                        btn(
                          Icons.code,
                          'GitHub',
                          'https://github.com/kjhamja77',
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Email
                    HoverScale(
                      scale: 1.04,
                      child: GestureDetector(
                        onTap: () => _openUrl(
                          'mailto:kjhamja77@gmail.com',
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: Color(0xFFA98AFF),
                              size: 17,
                            ),
                            SizedBox(width: 9),
                            Text(
                              'kjhamja77@gmail.com',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // ───────────────────────── BUILD ─────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      endDrawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          children: [
            const ListTile(
              leading: Icon(Icons.flutter_dash, color: Colors.indigoAccent),
              title: Text(
                'Halith Hamja',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              subtitle: Text('Mobile App Developer',
                  style: TextStyle(color: Colors.white70)),
            ),
            const Divider(color: Colors.white24),
            ...[
              {'label': 'About', 'key': _aboutKey},
              {'label': 'Resume', 'key': _resumeKey},
              {'label': 'Projects', 'key': _portfolioKey},
            ].map((item) {
              return ListTile(
                title: Text(item['label'] as String,
                    style:
                    const TextStyle(color: Colors.white70, fontSize: 16)),
                onTap: () {
                  Navigator.pop(context);
                  _scrollTo(item['key'] as GlobalKey);
                },
              );
            }),
            const Divider(color: Colors.white24),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.indigoAccent),
              title: const Text('Contact Me',
                  style: TextStyle(color: Colors.white70)),
              onTap: () {
                Navigator.pop(context);
                _showContacts();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _showTop,
        builder: (_, show, __) => AnimatedScale(
          scale: show ? 1 : 0,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutBack,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: Colors.indigoAccent,
            onPressed: _toTop,
            child: const Icon(Icons.arrow_upward, color: Colors.white),
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth;
        final desktop = width >= 900;
        return MouseRegion(
          onHover: (e) {
            if (desktop) _mouse.value = e.localPosition;
          },
          onExit: (_) => _mouse.value = null,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Column(
                  children: [
                    _buildNavBar(width),
                    ValueListenableBuilder<double>(
                      valueListenable: _progress,
                      builder: (_, p, __) => Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: p.clamp(0.0, 1.0),
                          child: Container(
                            height: 3,
                            decoration:
                            const BoxDecoration(gradient: kBrandGradient),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: RevealScope(
                        controller: _scroll,
                        child: SingleChildScrollView(
                          controller: _scroll,
                          child: Column(
                            children: [
                              _heroSection(width),
                              const TechMarquee(),
                              _aboutSection(),
                              _resumeSection(),
                              _portfolioSection(),
                              _ctaSection(),
                              const _Footer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Cursor spotlight (desktop only)
              if (desktop)
                ValueListenableBuilder<Offset?>(
                  valueListenable: _mouse,
                  builder: (_, pos, __) {
                    if (pos == null) return const SizedBox.shrink();
                    return Positioned(
                      left: pos.dx - 260,
                      top: pos.dy - 260,
                      child: IgnorePointer(
                        child: Container(
                          width: 520,
                          height: 520,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.blue.withValues(alpha: 0.10),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SKILL BADGE (hover pop + glow)
// ─────────────────────────────────────────────────────────────────────────────
class _SkillBadge extends StatefulWidget {
  final String asset;
  final String label;

  const _SkillBadge({required this.asset, required this.label});

  @override
  State<_SkillBadge> createState() => _SkillBadgeState();
}

class _SkillBadgeState extends State<_SkillBadge> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            scale: _hover ? 1.15 : 1,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutBack,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 90,
              width: 90,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[900],
                border: Border.all(
                  color: _hover ? AppColors.purple : Colors.indigoAccent,
                  width: _hover ? 2 : 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _hover
                        ? AppColors.blue.withValues(alpha: 0.5)
                        : Colors.black54,
                    blurRadius: _hover ? 26 : 10,
                  ),
                ],
              ),
              child: Tooltip(
                message: widget.label,
                child: Image.asset(widget.asset, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 10),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: TextStyle(
              color: _hover ? Colors.white : Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            child: Text(widget.label),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PROJECT CARD (3D tilt, cursor glare, hover overlay)
// ─────────────────────────────────────────────────────────────────────────────


class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> p;
  final double width;
  final double height;
  final VoidCallback onTap;
  final void Function(String) onOpenUrl;

  const _ProjectCard({
    required this.p,
    required this.width,
    required this.height,
    required this.onTap,
    required this.onOpenUrl,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hover = false;
  Offset _tilt = Offset.zero;

  void _onHover(PointerEvent e) {
    if (widget.width <= 0 || widget.height <= 0) return;

    final dx = (e.localPosition.dx / widget.width) * 2 - 1;
    final dy = (e.localPosition.dy / widget.height) * 2 - 1;

    setState(() {
      _hover = true;
      _tilt = Offset(
        dx.clamp(-1.0, 1.0),
        dy.clamp(-1.0, 1.0),
      );
    });
  }

  Widget _badge({
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.68),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _storeButton({
    required IconData icon,
    required String url,
    required Color color,
    required String tooltip,
  }) {
    // Do not display a button if its URL is unavailable.
    if (url.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Tooltip(
      message: tooltip,
      child: HoverScale(
        scale: 1.12,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => widget.onOpenUrl(url),
            icon: Icon(icon, color: color, size: 19),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.p;

    final title = p['title']?.toString() ?? '';
    final category = p['category']?.toString() ?? 'Project';
    final image = p['image']?.toString() ?? '';
    final subtitle = p['subtitle']?.toString() ?? '';
    final description = p['description']?.toString() ?? '';

    final playStore = p['playstore']?.toString().trim() ?? '';
    final appStore = p['appstore']?.toString().trim() ?? '';

    final hasPlayStore = playStore.isNotEmpty &&
        playStore.toLowerCase() != 'null';

    final hasAppStore = appStore.isNotEmpty &&
        appStore.toLowerCase() != 'null';

    final transform = Matrix4.translationValues(
      0,
      _hover ? -8 : 0,
      0,
    )..setEntry(3, 2, 0.0012);

    transform
      ..rotateX(_hover ? -_tilt.dy * 0.045 : 0)
      ..rotateY(_hover ? _tilt.dx * 0.045 : 0);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onHover: _onHover,
      onExit: (_) {
        setState(() {
          _hover = false;
          _tilt = Offset.zero;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transformAlignment: Alignment.center,
          transform: transform,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: const Color(0xFF11121D),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: _hover
                  ? AppColors.purple.withValues(alpha: 0.75)
                  : Colors.white.withValues(alpha: 0.09),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _hover
                    ? AppColors.purple.withValues(alpha: 0.22)
                    : Colors.black.withValues(alpha: 0.25),
                blurRadius: _hover ? 35 : 15,
                spreadRadius: _hover ? 1 : 0,
                offset: Offset(0, _hover ? 12 : 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(21),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project image
                    SizedBox(
                      height: 175,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            color: const Color(0xFF202131),
                            child: AnimatedScale(
                              scale: _hover ? 1.08 : 1,
                              duration:
                              const Duration(milliseconds: 500),
                              curve: Curves.easeOutCubic,
                              child: Image.asset(
                                image,
                                fit: BoxFit.fitHeight,
                                errorBuilder: (_, __, ___) =>
                                const Center(
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    color: Colors.white38,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Image gradient
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withValues(alpha: 0.25),
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.60),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Category badge
                          Positioned(
                            top: 13,
                            left: 13,
                            child: _badge(
                              label: category,
                              icon: Icons.grid_view_rounded,
                              color: AppColors.blue,
                            ),
                          ),

                          // Hover overlay
                          Positioned.fill(
                            child: IgnorePointer(
                              child: AnimatedOpacity(
                                opacity: _hover ? 1 : 0,
                                duration:
                                const Duration(milliseconds: 250),
                                child: Container(
                                  color: Colors.black.withValues(
                                    alpha: 0.42,
                                  ),
                                  alignment: Alignment.center,
                                  child: AnimatedSlide(
                                    offset: _hover
                                        ? Offset.zero
                                        : const Offset(0, 0.2),
                                    duration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    child: Container(
                                      padding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 19,
                                        vertical: 11,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.purple,
                                        borderRadius:
                                        BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.purple
                                                .withValues(alpha: 0.4),
                                            blurRadius: 18,
                                          ),
                                        ],
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Explore Project',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Project information
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          18, 16, 18, 14,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title and available store buttons
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ),

                                if (hasPlayStore || hasAppStore) ...[
                                  const SizedBox(width: 8),

                                  if (hasPlayStore)
                                    _storeButton(
                                      icon: Icons.play_arrow_rounded,
                                      url: playStore,
                                      color: const Color(0xFF55D68B),
                                      tooltip: 'Google Play',
                                    ),

                                  if (hasPlayStore && hasAppStore)
                                    const SizedBox(width: 7),

                                  if (hasAppStore)
                                    _storeButton(
                                      icon: Icons.apple_rounded,
                                      url: appStore,
                                      color: Colors.white,
                                      tooltip: 'App Store',
                                    ),
                                ],
                              ],
                            ),

                            const SizedBox(height: 5),

                            Text(
                              subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.blue,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 11),

                            Expanded(
                              child: Text(
                                description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 12.5,
                                  height: 1.55,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Bottom action
                            Row(
                              children: [
                                Container(
                                  width: 28,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    gradient: kBrandGradient,
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'VIEW PROJECT',
                                  style: TextStyle(
                                    color: Colors.white.withValues(
                                      alpha: 0.65,
                                    ),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const Spacer(),
                                AnimatedContainer(
                                  duration:
                                  const Duration(milliseconds: 250),
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: _hover
                                        ? AppColors.purple
                                        : Colors.white.withValues(
                                      alpha: 0.07,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(9),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_outward_rounded,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Cursor-following glare
                Positioned.fill(
                  child: IgnorePointer(
                    child: AnimatedOpacity(
                      opacity: _hover ? 1 : 0,
                      duration: const Duration(milliseconds: 250),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment(
                              _tilt.dx,
                              _tilt.dy,
                            ),
                            radius: 0.85,
                            colors: [
                              Colors.white.withValues(alpha: 0.09),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// ─────────────────────────────────────────────────────────────────────────────
// SECTION TITLE (underline grows in on reveal)
// ─────────────────────────────────────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  final bool center;

  const _SectionTitle(this.title, {this.center = false});

  @override
  Widget build(BuildContext context) {
    return Reveal.builder(
      from: center ? RevealFrom.bottom : RevealFrom.left,
      distance: 30,
      builder: (context, anim) => Column(
        crossAxisAlignment:
        center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white60,
            ),
          ),
          const SizedBox(height: 6),
          AnimatedBuilder(
            animation: anim,
            builder: (_, __) => Container(
              height: 3,
              width: 70 * Curves.easeOut.transform(anim.value),
              decoration: BoxDecoration(
                gradient: kBrandGradient,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FOOTER
// ─────────────────────────────────────────────────────────────────────────────
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: kSectionDecoration,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Text(
            '© ${DateTime.now().year} Halith Hamja. All Rights Reserved',
            style: const TextStyle(color: Colors.white60),
          ),
          const SizedBox(height: 6),
          const Text('Built with Flutter 💙',
              style: TextStyle(color: Colors.white60)),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.white60));
  }
}


class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A0A23),Colors.black],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Text('© ${DateTime.now().year} Halith Hamja. All Rights Reserved', style: const TextStyle(color: Colors.white60)),
          const SizedBox(height: 6),
          Text('Built with Flutter', style: const TextStyle(color: Colors.white60)),
        ],
      ),
    );
  }
}