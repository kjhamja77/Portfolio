import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/utils/scroll_behaviour.dart';
import 'package:myportfolio/screens/project_details.dart';
import 'package:url_launcher/url_launcher.dart';



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
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home:  PortfolioHomePage()
    );
  }
}


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

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (kDebugMode) print('Could not launch $url');
    }
  }

  void _showContacts() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0A0A23),Colors.black12],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Contacts',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
              SizedBox(height: 15,),
              ListTile(
                leading: const Icon(Icons.email_outlined,color: Colors.white60),
                title: const Text('Email',style: TextStyle(color: Colors.white),),
                subtitle: const Text('kjhamja77@gmail.com',style: TextStyle(color: Colors.white60)),
                onTap: () => _openUrl('mailto:kjhamja77@gmail.com'),
              ),
              ListTile(
                leading: const Icon(Icons.phone_outlined,color: Colors.white60),
                title: const Text('Phone - India',style: TextStyle(color: Colors.white),),
                subtitle: const Text('+91 7695818144',style: TextStyle(color: Colors.white60)),
                onTap: () => _openUrl('https://wa.me/+917695818144'),
              ),
              ListTile(
                leading: const Icon(Icons.phone_outlined,color: Colors.white60),
                title: const Text('Phone - UAE',style: TextStyle(color: Colors.white),),
                subtitle: const Text('+971 58 841 0143',style: TextStyle(color: Colors.white60)),
                // onTap: () => _openUrl('https://wa.me/+917695818144'),
              ),
              ListTile(
                leading: const Icon(Icons.location_on_outlined,color: Colors.white60,),
                title: const Text('Location',style: TextStyle(color: Colors.white),),
                subtitle: const Text('Thanjavur, TamilNadu',style: TextStyle(color: Colors.white60)),
                onTap: () => _openUrl('https://www.google.com/maps'),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Tooltip(
                    message: "LinkedIn",
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        tooltip: 'LinkedIn',
                        onPressed: () => _openUrl('https://www.linkedin.com/in/halith-hamja-218476204/'),
                        icon: Image.asset('assets/linkedIn.png',height: 40,width: 40,fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                  Tooltip(
                    message: "GitHub",
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        tooltip: 'GitHub',
                        onPressed: () => _openUrl('https://github.com/kjhamja77'),
                        icon: Image.asset('assets/gitHub.png',height: 40,width: 40,fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                  // IconButton(
                  //   tooltip: 'X',
                  //   onPressed: () => _openUrl('https://x.com/'),
                  //   icon: const Icon(Icons.chat_bubble_outline),
                  // ),
                ],
              ),
              SizedBox(height: 15,),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () => Navigator.of(ctx).pop(), child: const Text('Close',style: TextStyle(color: Colors.white),)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavBar(double width, BuildContext context) {
    final isSmall = width < 900;

    final navItems = [
      {'label': 'About', 'key': _aboutKey},
      {'label': 'Resume', 'key': _resumeKey},
      {'label': 'Projects', 'key': _portfolioKey},
    ];

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 🔹 Logo + Title
          Row(
            children: [
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halith Hamja',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Mobile App Developer',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 🔹 Navigation Items (Desktop)
          if (!isSmall)
            Row(
              children: navItems.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    onPressed: () => _scrollTo(item['key'] as GlobalKey),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      overlayColor:
                      Colors.indigoAccent.withValues(alpha: 0.2),
                    ),
                    child: Text(
                      item['label'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

          // 🔹 Contact / Drawer Toggle
          if (isSmall)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            )
          else
            ElevatedButton.icon(
              onPressed: _showContacts,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              icon: const Icon(Icons.phone, size: 18, color: Colors.white),
              label: const Text('Contact',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
        ],
      ),
    );
  }



  Widget _heroSection(double width) {
    final isSmall = width < 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 20 : 80, vertical: isSmall ? 60 : 100),

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A0A23),Colors.black],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flex(
            direction: isSmall ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [
              // LEFT SIDE - Text Section
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment:
                isSmall ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  const Text(
                    '👋 Hello, I’m',
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Halith Hamja',
                    style: TextStyle(
                      fontSize: isSmall ? 34 : 52,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                    ),
                  ),
                  const SizedBox(height: 8),

                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Flutter Developer',
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: isSmall ? 20 : 24,
                          fontWeight: FontWeight.w500,
                        ),
                        speed: const Duration(milliseconds: 90),
                      ),
                      TypewriterAnimatedText(
                        'Mobile App Engineer (Kotlin | Flutter)',
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: isSmall ? 20 : 24,
                          fontWeight: FontWeight.w500,
                        ),
                        speed: const Duration(milliseconds: 90),
                      ),
                      TypewriterAnimatedText(
                        'Building seamless cross-platform apps 🚀',
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: isSmall ? 20 : 24,
                          fontWeight: FontWeight.w500,
                        ),
                        speed: const Duration(milliseconds: 90),
                      ),
                      TypewriterAnimatedText(
                        'Building seamless Native apps 🚀',
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: isSmall ? 20 : 24,
                          fontWeight: FontWeight.w500,
                        ),
                        speed: const Duration(milliseconds: 90),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: isSmall ? double.infinity : null,
                    child: Wrap(
                      alignment:
                      isSmall ? WrapAlignment.center : WrapAlignment.start,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigoAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => _openUrl('mailto:kjhamja77@gmail.com'),
                          icon: const Icon(Icons.email_outlined, size: 20,color: Colors.white,),
                          label: const Text('Contact Me', style: TextStyle(fontSize: 16,color: Colors.white)),
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.indigoAccent),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => _openUrl('https://drive.google.com/file/d/1slKS8k9pisqSYosjiN6Mh2Ua-se0WA67/view?usp=sharing'),
                          icon: const Icon(Icons.download_outlined, size: 20),
                          label: const Text('Download CV', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(width: isSmall ? 0 : 60, height: isSmall ? 40 : 0),

              if (!isSmall)
                Flexible(
                  flex: 1,
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      height: 350,
                      width: 420,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigoAccent.withValues(alpha: 0.3),
                            blurRadius: 30,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child:
                        Image.network(
                          'https://cdnl.iconscout.com/lottie/premium/thumb/developer-working-on-computer-animation-gif-download-3618988.gif',
                          fit: BoxFit.cover,
                          errorBuilder: (c, _, __) => Container(color: Colors.grey[900]),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _aboutSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          key: _aboutKey,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0A0A23),Colors.black],
            ),
          ),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SectionTitle('About Me'),
              const SizedBox(height: 30),
              Container(
                constraints: const BoxConstraints(maxWidth: 900),
                child: const Text(
                  "I'm a passionate mobile app developer specializing in Flutter and Kotlin, focused on building high-quality cross-platform applications with clean architecture, smooth performance, and modern UI design."
                  "I work extensively with Flutter, Firebase, and REST APIs, delivering scalable and user-friendly apps for Android and iOS."
                  "I enjoy solving real-world problems through code, optimizing app performance, and turning ideas into polished products."
                  "Beyond development, I stay committed to continuous learning — keeping up with emerging tools, technologies, and design trends to improve my skills and build better experiences.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                    height: 1.6,
                  ),
                ),
              ),

              const SizedBox(height: 60),
              Text(
                'Technical Skills',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 30),

              Wrap(
                alignment: WrapAlignment.center,
                spacing: 50,
                runSpacing: 40,
                children: [
                  _skillIcon('assets/flutter.png', "Flutter"),
                  _skillIcon('assets/kotlin.png', "Kotlin"),
                  _skillIcon('assets/python.png', "Python"),
                  _skillIcon('assets/firebase.png', "Firebase"),
                ],
              ),

              const SizedBox(height: 80),

              Text(
                'Tools & Environments',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 30),

              Wrap(
                alignment: WrapAlignment.center,
                spacing: 50,
                runSpacing: 40,
                children: [
                  _skillIcon('assets/androidStudio.png', "Android Studio"),
                  _skillIcon('assets/xcode.png', "Xcode"),
                  _skillIcon('assets/vscode.png', "VS Code"),
                  _skillIcon('assets/postman.png', "Postman"),
                  _skillIcon('assets/git.png', "Git"),
                  _skillIcon('assets/figma.png', "Figma"),
                ],
              ),

              const SizedBox(height: 60),
            ],
          ),
        );
      },
    );
  }

  Widget _skillIcon(String asset, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[900],
              boxShadow: const [
                BoxShadow(color: Colors.black54, blurRadius: 10),
              ],
              border: Border.all(color: Colors.indigoAccent, width: 1.2),
            ),
            padding: const EdgeInsets.all(14),
            child: Tooltip(
              message: label,
              child: Image.asset(
                asset,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _resumeSection() {

    final experiences = [
      {
        'title': 'Mobile Application Developer',
        'company': 'Inspire Clean Energy Private Limited',
        'duration': 'June 2024 – Jan 2025',
        'points': [
          'Developed **Eira Connect** using Flutter, REST API, Isar DB & AWS S3 with image capture, secure URLs, and offline storage.',
          'Built **Eira Monitoring** with Syncfusion Charts, intuitive UI, PDF export, and password-protected access.',
          'Improved performance, ensured accurate data flow, and maintained stability through debugging, testing, and deployment.'
        ],
      },
      {
        'title': 'Mobile Application Developer',
        'company': 'Sanorac Technologies Private Limited',
        'duration': 'May 2023 – Oct 2023',
        'points': [
          'Developed **Vividlipi** with REST APIs, WooCommerce, EPUB reader, audio & YouTube players for rich learning content.',
          'Built **Degrees Tutorial** with secure Stripe & InstaMojo payments and adaptive UI using Bloc state management.',
          'Enhanced app performance through structured debugging, testing, and GitLab-based version control.'
        ],
      },
      {
        'title': 'Flutter Developer',
        'company': 'Vugha Technological Solution Private Limited',
        'duration': 'Apr 2022 – Mar 2023',
        'points': [
          'Developed **Ayani** using Flutter + Firebase (Firestore, Authentication, Functions) and deployed on Play Store & App Store.',
          'Integrated Paytm payments, CI/CD pipelines, Crashlytics monitoring, and Remote Config for dynamic updates.',
          'Performed debugging, unit testing, and test documentation ensuring long-term stability and maintainability.'
        ],
      },
      {
        'title': 'Software Developer',
        'company': 'Garuda Aerospace Private Limited',
        'duration': 'Jan 2021 – Oct 2021',
        'points': [
          'Built **Garuda Learning Application** using Flutter with Email Auth, Firestore & Firebase Storage for secure learning.',
          'Designed interactive UI for training modules, quizzes, and smooth learning experience.',
          'Developed & optimized **Assessment Website** on WordPress with custom features and long-term support.'
        ],
      },
    ];

    return Container(
      key: _resumeKey,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A0A23),Colors.black],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Resume'),
          const SizedBox(height: 32),

          const Text(
            'Experience',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 28),

          LayoutBuilder(
            builder: (_, constraints) {
              final bool isSingleColumn = constraints.maxWidth < 900;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: experiences.map((exp) {
                  return SizedBox(
                    width: isSingleColumn
                        ? constraints.maxWidth
                        : (constraints.maxWidth / 2) - 32,
                    child: _experienceCard(exp),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 40),
          const Divider(color: Colors.white30, thickness: 1),
          const SizedBox(height: 32),

          const Text(
            'Education',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 20),

          _educationCard(),
        ],
      ),
    );
  }

  Widget _experienceCard(Map<String, dynamic> exp) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exp['title'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            exp['company'],
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          Text(
            exp['duration'],
            style: const TextStyle(color: Colors.white54, fontSize: 14),
          ),

          const SizedBox(height: 12),

          ...exp['points'].map<Widget>((p) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child:
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text("• ", style: TextStyle(color: Colors.white70)),
                Expanded(
                  child: Text(
                    p,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _educationCard() {
    final educationList = [
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


    return LayoutBuilder(
      builder: (context, constraints) {
        bool isRow = constraints.maxWidth > 900;

        return isRow
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: educationList.map((edu) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _educationCardResponsive(edu),
              ),
            );
          }).toList(),
        )
            : Column(
          children: educationList.map((edu) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _educationCardResponsive(edu),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _educationCardResponsive(Map<String, dynamic> edu) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          edu['icon'],
          color: Colors.indigoAccent,
          size: 36,
        ),
        title: Text(
          edu['course'],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          '${edu['institution']}\n${edu['duration']}',
          style: const TextStyle(color: Colors.white70, height: 1.4),
        ),
      ),
    );
  }

  Widget _portfolioSection() {
    final projects = [
      {
        'title': 'Eira',
        'subtitle': 'Application',
        'tagline':'Track. Analyze. Optimize your energy performance.',
        'description':
        'A Flutter-based energy monitoring app with REST API integration, featuring Syncfusion charts for accurate energy tracking, ticket management, and downloadable plant-level reports.',
        'brief':"A Flutter-based energy monitoring app that provides real-time visibility into plant performance and energy usage. It integrates with REST APIs to deliver accurate, up-to-date data and displays insights using interactive Syncfusion charts. Users can track energy trends, manage tickets, and download detailed plant-level reports for analysis and decision-making. The platform ensures reliable data handling, smooth performance, and a modern interface optimized for both mobile and tablet users.",
        'image': 'assets/eira_icon.png',
        'screenshots':['assets/screenshots/Eira_monitor1.jpeg',
          'assets/screenshots/Eira_monitor2.jpeg',
          'assets/screenshots/Eira_monitor3.jpeg',
          'assets/screenshots/Eira_monitor4.jpeg',
          'assets/screenshots/Eira_monitor5.jpeg',
          'assets/screenshots/Eira_monitor7.jpeg',
          'assets/screenshots/Eira_monitor6.jpeg'
        ],
        'techStack':['assets/flutter.png','assets/RestAPI.png','assets/git.png','assets/postman.png'],
        'github': 'https://github.com/kjhamja77/Eira_Monitor',
        'playstore': 'https://nagarikapp.gov.np',
        'appstore': 'https://apps.apple.com/',
      },
      {
        'title': 'Eira Connect',
        'subtitle': 'Application',
        'tagline':'Smart ticketing built for the real world — capture, work offline, sync anywhere.',
        'description':
        'A Flutter-based ticket management application featuring image capture, offline data storage with Isar DB, location-based ticket access, and seamless server syncing through REST APIs.',
        'brief':"A robust Flutter-based ticket management system designed for field operations. The app enables users to capture and attach images directly through the device camera, store ticket data securely offline using Isar DB, and automatically synchronize updates to the server via REST APIs once connectivity is restored. It also features intelligent location-based ticket accessibility, ensuring users can only manage tickets relevant to their current geolocation. The solution offers a seamless workflow, high performance in offline environments, and reliable data consistency across devices.",
        'image': 'assets/eira_connect.png',
        'screenshots':['assets/screenshots/eira_connect2.jpeg',
          'assets/screenshots/eira_connect1.jpeg',
          'assets/screenshots/eira_connect3.jpeg',
          'assets/screenshots/eira_connect4.jpeg','assets/screenshots/eira_connect6.jpeg'],
        'techStack':['assets/flutter.png','assets/RestAPI.png','assets/IsarDb.png','assets/git.png','assets/postman.png'],
        'github': 'https://github.com/kjhamja77/Eiraconnect',
        'playstore':
        'https://play.google.com/store/apps/details?id=com.inspire.nibhuna&pcampaignid=web_share',
        'appstore': 'https://apps.apple.com/',
      },
      {
        'title': 'Nuchurch',
        'subtitle': 'Application',
        'tagline':'Connect with faith — book, learn, and grow with your church community.',
        'description':
        'A church application built with Flutter and REST APIs to book baptisms, view church events, and listen to Old and New Testament teachings.',
        'brief':'A church application built with Flutter, offering a simple and user-friendly way for parishioners to engage with their church. Through REST APIs, users can easily book baptisms, stay updated on upcoming church events, and explore community activities. The app also provides access to teachings from the Old and New Testaments, making spiritual learning available anytime. Overall, it serves as a convenient digital platform to support church involvement and spiritual growth.',
        'image': 'assets/nuchurch_icon.png',
        'screenshots':['assets/screenshots/nuchurch2.jpeg','assets/screenshots/nuchurch1.jpeg','assets/screenshots/nuchurch3.jpeg','assets/screenshots/nuchurch4.jpeg','assets/screenshots/nuchurch5.jpeg'],
        'techStack':['assets/flutter.png','assets/RestAPI.png','assets/git.png','assets/postman.png'],
        'github': 'https://github.com/kjhamja77/Nuchurch',
        'playstore': 'https://play.google.com/store',
        'appstore': 'https://apps.apple.com/',
      },
      {
        'title': 'Vividlipi',
        'subtitle': 'Application',
        'tagline':'Read. Listen. Learn — all your knowledge in one intelligent media app.',
        'description':
        'A Flutter-based Learning & Media App that allows users to purchase and read books through WooCommerce, access an integrated EPUB reader, listen to podcasts, and watch YouTube videos.',
        'brief':'A Flutter-based Learning & Media App that brings books, podcasts, and videos into one unified platform. It connects with WooCommerce so users can easily browse, purchase, and access digital books. The built-in EPUB reader ensures a smooth, customizable reading experience. Users can also listen to podcasts and watch embedded YouTube videos without leaving the app. Overall, it provides a seamless and versatile digital learning environment.',
        'image': 'assets/vividlipi.png',
        'screenshots':['assets/screenshots/vividlipi1.jpeg','assets/screenshots/vividlipi2.jpeg','assets/screenshots/vividlipi4.jpeg','assets/screenshots/vividlipi5.jpeg','assets/screenshots/vividlipi6.jpeg'],
        'techStack':['assets/flutter.png','assets/RestAPI.png','assets/git.png','assets/postman.png','assets/figma.png'],
        'github': 'https://github.com/kjhamja77/Vividlipi.git',
        'playstore': 'https://play.google.com/store',
        'appstore': 'https://apps.apple.com/',
      },
      {
        'title': 'Degrees Tutorial',
        'subtitle': 'Application',
        'tagline':'Learn smarter — lessons, homework, and quizzes all in one seamless platform.',
        'description':
        'An education app for school students built with Flutter and REST APIs, providing course lessons, homework access, and quizzes to complete learning modules.',
        'brief':'An education app for school students built using Flutter, designed to make learning more interactive and accessible. It connects with REST APIs to deliver structured course lessons, updated content, and personalized study material. Students can view and submit homework directly through the app, making daily learning more organized. Engaging quizzes are included within each module to test understanding and reinforce key concepts. The app aims to provide a complete digital learning experience that supports both classroom and self-paced study.',
        'image': 'assets/degress_icon.png',
        'screenshots':['assets/screenshots/degrees6.jpeg','assets/screenshots/degrees2.jpeg','assets/screenshots/degrees3.jpeg','assets/screenshots/degrees4.jpeg','assets/screenshots/degrees5.jpeg'],
        'techStack':['assets/flutter.png','assets/RestAPI.png','assets/git.png','assets/postman.png','assets/figma.png'],
        'github': 'https://github.com/kjhamja77/Degress_tutorial',
        'playstore': 'https://tokma.ai',
        'appstore': 'https://apps.apple.com/',
      },
      {
        'title': 'Ayani',
        'subtitle': 'Application',
        'tagline':'Pure water delivered on demand — fast, simple, and secure.',
        'description':
        'A Flutter-based water delivery app for purchasing 20L water cans, integrated with Firebase for data management and Paytm for secure online payments.',
        'brief':'This Flutter-based water delivery app enables users to easily order and refill 20L water cans through a simple and intuitive interface. It uses Firebase for authentication, real-time database handling, and seamless order tracking. Secure online payments are integrated through Paytm, ensuring a smooth checkout experience. Users can manage addresses, view past orders, and receive real-time delivery notifications. Designed with scalability and performance in mind, it supports fast and reliable operations for delivery-based businesses.',
        'image': 'assets/ayani_icon.png',
        'screenshots':[
          'assets/screenshots/ayani1.jpg',
          'assets/screenshots/ayani2.jpg',
          'assets/screenshots/ayani3.jpg',
          'assets/screenshots/ayani4.jpg',
          'assets/screenshots/ayani5.jpg',
          'assets/screenshots/ayani6.jpg'
        ],
        'techStack':['assets/flutter.png','assets/RestAPI.png','assets/firebase.png',
          'assets/git.png','assets/postman.png','assets/xcode.png'],
        'github': 'https://github.com/',
        'playstore':
        'https://play.google.com/store/apps/details?id=com.ayani.prod.vugha&pcampaignid=web_share',
        'appstore': 'https://apps.apple.com/in/app/ayani/id6444288601',
      },
      {
        'title': 'Ayani Vendor',
        'subtitle': 'Application',
        'tagline':'Enabling real-time visibility and operational control across vendor and delivery workflows.',
        'description':
        'A Flutter-based vendor app for managing orders, assigning deliveries to transporters, tracking can counts, and monitoring user can distribution using Firebase.',
        'brief':'This vendor management app is built using Flutter to streamline water delivery operations. Vendors can manage orders, assign deliveries to transporters, and track fulfillment progress in real time. Firebase handles authentication, secure data storage, and live synchronization. The system also monitors can movement, including issued, returned, and pending counts, ensuring accurate inventory tracking. With a simple and role-based workflow, the app improves delivery efficiency and operational control.',
        'image': 'assets/ayani_vendor.png',
        'screenshots':[
          'assets/screenshots/ayani_vendor1.jpg',
          'assets/screenshots/ayani_vendor2.jpg',
          'assets/screenshots/ayani_vendor3.jpg',
          'assets/screenshots/ayani_vendor4.jpg',
          'assets/screenshots/ayani_vendor5.jpg',
          'assets/screenshots/ayani_vendor6.jpg',
        ],
        'techStack':['assets/flutter.png','assets/firebase.png','assets/git.png'],
        'github': 'https://github.com/kjhamja77/Ayani-vendor.git',
        'playstore':
        'https://play.google.com/store/apps/details?id=com.ayani_vendor.prod.vugha&pcampaignid=web_share',
        'appstore': 'https://apps.apple.com/',
      },
      {
        'title': 'Ayani Transporter',
        'subtitle': 'Application',
        'tagline':'A smarter way for delivery partners to manage, track, and complete orders',
        'description':
        'A Flutter-based transporter app for delivery partners to manage assigned can deliveries, optimized using a shortest-distance routing algorithm, integrated with Firebase and REST APIs.',
        'brief':'This Flutter-based transporter app supports delivery partners managing 20L water can logistics. It uses a shortest-distance routing algorithm to optimize delivery sequences and reduce travel time. Partners can view assigned orders, update delivery status, and manage can returns in real time. Firebase handles authentication and storage, while REST APIs enable seamless data synchronization with vendor systems. The mobile-friendly interface ensures smooth and efficient on-route usage.',
        'image': 'assets/ayani_transporter.png',
        'screenshots':['assets/screenshots/ayani_transporter1.jpeg','assets/screenshots/ayani_transporter2.jpeg','assets/screenshots/ayani_transporter3.jpeg','assets/screenshots/ayani_transporter4.jpeg','assets/screenshots/ayani_transporter5.jpeg'],
        'techStack':['assets/flutter.png','assets/RestAPI.png','assets/firebase.png','assets/git.png','assets/postman.png'],
        'github': 'https://github.com/kjhamja77/Ayani-transporter.git',
        'playstore':
        '',
        'appstore': 'https://apps.apple.com/',
      },
      {
        'title': 'Hecho Digital',
        'subtitle': 'Application',
        'tagline':'A smarter way to source construction materials—fast, reliable, and seamless.',
        'description':
        'A Flutter-based e-commerce app to purchase construction materials like cement, bricks, steel rods, and other building supplies using REST API integration.',
        'brief':'This Flutter-based e-commerce app allows users to purchase construction materials like cement, bricks, and steel rods with ease. It integrates REST APIs to provide real-time product availability, accurate pricing, and smooth ordering. Users can browse categorized items, compare options, place orders, and track deliveries through an intuitive interface. With secure checkout and order history features, the app offers a seamless and reliable construction material purchasing experience.',
        'image': 'assets/hecho_digital.png',
        'screenshots':['assets/screenshots/hecho3.jpeg','assets/screenshots/hecho1.jpeg','assets/screenshots/hecho2.jpeg','assets/screenshots/hecho4.jpeg','assets/screenshots/hecho5.jpeg'],
        'techStack':['assets/flutter.png','assets/RestAPI.png','assets/postman.png'],
        'github': 'https://github.com/',
        'playstore':
        '',
        'appstore': 'https://apps.apple.com/',
      },
      {
        'title': 'Hecho Merchant',
        'subtitle': 'Application',
        'tagline':'Manage, track, and grow your construction supply business with confidence.',
        'description':
        'A Flutter-based seller app to upload construction supplies and materials for sale on the Hecho Digital platform, built using REST APIs.',
        'brief':'This Flutter-based seller app enables vendors to upload and manage construction materials for sale on the Hecho Digital platform. With REST API integration, product details, pricing, and stock updates sync in real time for accurate marketplace listings. Sellers can track orders, manage product status, and access performance insights through an intuitive interface. The app includes secure authentication, scalable architecture, and essential tools to streamline product management and support efficient digital selling.',
        'image': 'assets/hecho_merchant.png',
        'screenshots':['assets/screenshots/hecho_merchant1.jpeg','assets/screenshots/hecho_merchant2.jpeg','assets/screenshots/hecho_merchant3.jpeg','assets/screenshots/hecho_merchant4.jpeg','assets/screenshots/hecho_merchant5.jpeg'],
        'techStack':['assets/flutter.png','assets/RestAPI.png','assets/postman.png'],
        'github': 'https://github.com/',
        'playstore':
        '',
        'appstore': 'https://apps.apple.com/',
      },
      {
        'title': 'Garuda E-Learning',
        'subtitle': 'Application',
        'tagline':'A Modern Learning Platform Built for Precision, Progress, and Aerospace Excellence.',
        'description':
        'A Flutter-based e-learning app with pre-recorded aerospace lessons and PDF study materials, powered by Firebase.',
        'brief':'This Flutter-based e-learning app delivers pre-recorded aerospace lessons with a smooth and structured learning experience. Users can also access downloadable PDF study materials for revision and deeper understanding. With Firebase integration, the app ensures secure authentication, real-time data handling, and seamless progress tracking. Designed for scalability, it provides an efficient and user-friendly digital learning platform.',
        'image': 'assets/garuda_icon.png',
        'screenshots':[],
        'techStack':['assets/flutter.png','assets/firebase.png'],
        'github': 'https://github.com/',
        'playstore':
        '',
        'appstore': 'https://apps.apple.com/',
      },
    ];

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          key: _portfolioKey,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0A0A23),Colors.black],
            ),
          ),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(alignment:Alignment.centerLeft,child: const SectionTitle('Projects')),
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                child: Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: projects.map((p){
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
                          techStacks = stacks.split(',').map((e) =>e.trim()).toList();
                        } else if ((raw is String && raw.isNotEmpty) && (stacks is String && stacks.isNotEmpty)) {
                          screenshots = [raw];
                          techStacks = [stacks];
                        } else {
                          screenshots = [];
                          techStacks = [];
                        }
                    return GestureDetector(
                      onTap: () async{
                
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectDetailsPage(
                              projectName: p['title'].toString(),
                              tagline: p['tagline'].toString(),
                              description: p['brief'].toString(),
                              logoPath: p['image'].toString(),
                              screenshots: screenshots,
                              techStack: techStacks,
                            ),
                          ),
                        );
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 400,
                          height: MediaQuery.of(context).size.width <500 ? 375:340,
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(color: Colors.black54, blurRadius: 12, spreadRadius: 2),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                child: Container(
                                  color: Colors.white,
                                  child: Image.asset(
                                    p['image'].toString(),
                                    height: 150,
                                    width: double.infinity,
                                    fit: p['title'] == 'Degrees Tutorial'
                                        ? BoxFit.fitWidth
                                        : BoxFit.fitHeight,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          p['title'].toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (["Ayani", "Eira Connect", "Ayani Vendor"].contains(p['title']))
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.play_circle_fill_outlined,
                                                  color: Colors.green.shade500,
                                                ),
                                                onPressed: () => _openUrl(p['playstore'].toString()),
                                              ),
                                              if (p['title'] != "Eira Connect" && p['title'] != "Ayani Vendor")
                                                IconButton(
                                                  icon: const Icon(Icons.apple, color: Colors.white),
                                                  onPressed: () => _openUrl(p['appstore'].toString()),
                                                ),
                                            ],
                                          ),
                                      ],
                                    ),
                
                                    const SizedBox(height: 4),
                                    Text(
                                      p['subtitle'].toString(),
                                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                                    ),
                
                                    const SizedBox(height: 10),
                                    Text(
                                      p['description'].toString(),
                                      style: const TextStyle(color: Colors.white60, fontSize: 13, height: 1.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        );
      },
      // child:
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          children: [
            ListTile(
              leading: const Icon(Icons.flutter_dash, color: Colors.indigoAccent),
              title: const Text(
                'Halith Hamja',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: const Text(
                'Mobile App Developer',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            const Divider(color: Colors.white24),
            ...[
              {'label': 'About', 'key': _aboutKey},
              {'label': 'Resume', 'key': _resumeKey},
              {'label': 'Portfolio', 'key': _portfolioKey},
            ].map((item) {
              return ListTile(
                title: Text(
                  item['label'] as String,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
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
      body: LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth;
        return Column(
          children: [
            _buildNavBar(width,context),
            Expanded(
              child: SingleChildScrollView(
                controller: _scroll,
                child: Column(
                  children: [
                    _heroSection(width),
                    _aboutSection(),
                    _resumeSection(),
                    _portfolioSection(),
                    // _blogSection(),
                    // _contactSection(),
                    Footer()
                  ],
                ),
              ),
            ),
          ],
        );
      }),
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