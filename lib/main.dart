import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/utils/scroll_behaviour.dart';
import 'package:myportfolio/screens/project_details.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/project_model.dart';


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
  final _blogKey = GlobalKey();
  final _contactKey = GlobalKey();

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

  //new Nav bar with responsive navbar
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
              // Icon(Icons.flutter_dash, color: Colors.indigoAccent, size: 28),
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
                      Colors.indigoAccent.withOpacity(0.2),
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
                          //open the pdf action
                          onPressed: () => _openUrl('https://drive.google.com/file/d/1slKS8k9pisqSYosjiN6Mh2Ua-se0WA67/view?usp=sharing'),

                          //download the pdf file directly
                          // onPressed: (){
                          //   const fileUrl = 'https://drive.google.com/file/d/1slKS8k9pisqSYosjiN6Mh2Ua-se0WA67/view?usp=sharing';
                          //   html.AnchorElement(href: fileUrl)..setAttribute("download", "Halith_Hamja_CV.pdf")..click();
                          // },
                          icon: const Icon(Icons.download_outlined, size: 20),
                          label: const Text('Download CV', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Add some spacing between text and image
              SizedBox(width: isSmall ? 0 : 60, height: isSmall ? 40 : 0),


              // Optionally show GIF below for small screens instead of removing
              // if (isSmall) ...[
              //   const SizedBox(height: 40),
              //   ClipRRect(
              //     borderRadius: BorderRadius.circular(20),
              //     child: Image.network(
              //       'https://cdnl.iconscout.com/lottie/premium/thumb/front-end-developer-animation-gif-download-4453020.gif',
              //       height: 220,
              //       fit: BoxFit.cover,
              //       errorBuilder: (c, _, __) => Container(color: Colors.grey[900]),
              //     ),
              //   ),
              // ],
              // RIGHT SIDE - GIF (Visible only on larger screens)
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
        final isWide = constraints.maxWidth > 800;
        return Container(
          key: _aboutKey,
          // color: Colors.black,
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

              // 🧑‍💻 About Description
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

              // 🛠️ Skills Section
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
                  // _skillIcon('assets/restapi.png', "REST API"),
                ],
              ),

              const SizedBox(height: 80),

              // ⚙️ Tools Section
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
                  // _skillIcon('assets/aws.png', "AWS S3"),
                ],
              ),

              const SizedBox(height: 60),
            ],
          ),
        );
      },
    );
  }

  /// --------------------------------------------------
  /// Reusable Skill Icon Widget
  /// --------------------------------------------------
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


// Updated Resume Section Widget
// Projects removed as separate lists and converted into common points
// Project names shown in bold inside the points

  Widget _resumeSection() {
    final width = MediaQuery.of(context).size.width;
    final isSmall = width < 900;

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
        color: Colors.white.withOpacity(0.05),
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
            // Row(
            //   children: [
            //
            //   ],
            // ),
          )),
        ],
      ),
    );
  }



  /// EDUCATION CARD
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

    final width = MediaQuery.of(context).size.width;
    final isWide = width > 900; // Responsive breakpoint

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
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
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

  // Widget portfolioSection(){
  //   List<Project> _loadProjects() {
  //     return [
  //       Project(
  //         title: 'Eira',
  //         subtitle: 'Application',
  //         tagline: 'Track. Analyze. Optimize your energy performance.',
  //         description:
  //         'A Flutter-based energy monitoring app with REST API integration, featuring Syncfusion charts.',
  //         brief:
  //         'A Flutter-based energy monitoring app that provides real-time visibility into plant performance and energy usage...',
  //         image: 'assets/eira_icon.png',
  //         screenshots: [
  //           ProjectScreenshot(id: 'eira_1', path: 'assets/screenshots/Eira_monitor1.jpeg'),
  //           ProjectScreenshot(id: 'eira_2', path: 'assets/screenshots/Eira_monitor2.jpeg'),
  //           ProjectScreenshot(id: 'eira_3', path: 'assets/screenshots/Eira_monitor3.jpeg'),
  //           ProjectScreenshot(id: 'eira_4', path: 'assets/screenshots/Eira_monitor4.jpeg'),
  //           ProjectScreenshot(id: 'eira_5', path: 'assets/screenshots/Eira_monitor5.jpeg'),
  //           ProjectScreenshot(id: 'eira_6', path: 'assets/screenshots/Eira_monitor6.jpeg'),
  //           ProjectScreenshot(id: 'eira_7', path: 'assets/screenshots/Eira_monitor7.jpeg'),
  //         ],
  //         github: 'https://github.com/kjhamja77/Eira_Monitor',
  //         playstore: 'https://nagarikapp.gov.np',
  //         appstore: 'https://apps.apple.com/',
  //       ),
  //       Project(
  //         title: 'Eira Connect',
  //         subtitle: 'Application',
  //         tagline: 'Smart ticketing built for the real world — capture, work offline, sync anywhere.',
  //         description:
  //         'A Flutter-based ticket management application featuring image capture, offline data storage with Isar DB, location-based ticket access, and seamless server syncing through REST APIs.',
  //         brief:
  //         'A robust Flutter-based ticket management system designed for field operations. The app enables users to capture and attach images directly through the device camera, store ticket data securely offline using Isar DB, and automatically synchronize updates to the server via REST APIs once connectivity is restored. It also features intelligent location-based ticket accessibility, ensuring users can only manage tickets relevant to their current geolocation. The solution offers a seamless workflow, high performance in offline environments, and reliable data consistency across devices.',
  //         image: 'assets/eira_connect.png',
  //         screenshots: [
  //           ProjectScreenshot(id: 'eira_1', path: 'assets/screenshots/Eira_monitor1.jpeg'),
  //           ProjectScreenshot(id: 'eira_2', path: 'assets/screenshots/Eira_monitor2.jpeg'),
  //           ProjectScreenshot(id: 'eira_3', path: 'assets/screenshots/Eira_monitor3.jpeg'),
  //         ],
  //         github: 'https://github.com/kjhamja77/Eira_Monitor',
  //         playstore: 'https://nagarikapp.gov.np',
  //         appstore: 'https://apps.apple.com/',
  //       ),
  //       // Add remaining projects here...
  //     ];
  //   }
  //
  //   return Container();
  // }


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
        // final width = constraints.maxWidth;
        return Container(
          key: _portfolioKey,
          // color: Colors.black,
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
                              // Project Image
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
                
                              // Text Section
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
                
                                        // Playstore + Appstore buttons
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
              // GridView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: projects.length,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: width <800 ?1
              //         :width <1100? 2:3,     // Change for responsiveness if needed
              //     mainAxisSpacing: 24,
              //     crossAxisSpacing: 24,
              //     childAspectRatio: width
              //         < 800 ? 1.3:width <1100 ? 1.35 : 1.6,   // Adjust to match card size
              //   ),
              //   itemBuilder: (context, index) {
              //     final p = projects[index];
              //
              //     List<String> screenshots;
              //     List<String> techStacks;
              //
              //     var raw = p['screenshots'];
              //     var stacks = p['techStack'];
              //
              //     if (raw is List && stacks is List) {
              //       screenshots = List<String>.from(raw);
              //       techStacks = List<String>.from(stacks);
              //     } else if ((raw is String && raw.contains(',')) &&
              //         (stacks is String && stacks.contains(','))) {
              //       screenshots = raw.split(',').map((e) => e.trim()).toList();
              //       techStacks = stacks.split(',').map((e) =>e.trim()).toList();
              //     } else if ((raw is String && raw.isNotEmpty) && (stacks is String && stacks.isNotEmpty)) {
              //       screenshots = [raw];
              //       techStacks = [stacks];
              //     } else {
              //       screenshots = [];
              //       techStacks = [];
              //     }
              //     // List<String> data = List<String>.from(p['screenshots'] ?? []);
              //
              //     return GestureDetector(
              //       onTap: () async{
              //
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => ProjectDetailsPage(
              //               projectName: p['title'].toString(),
              //               tagline: p['tagline'].toString(),
              //               description: p['brief'].toString(),
              //               logoPath: p['image'].toString(),
              //               screenshots: screenshots,
              //               techStack: techStacks,
              //             ),
              //           ),
              //         );
              //       },
              //       child: MouseRegion(
              //         cursor: SystemMouseCursors.click,
              //         child: AnimatedContainer(
              //           duration: const Duration(milliseconds: 300),
              //           width: 400,
              //           decoration: BoxDecoration(
              //             color: Colors.grey[900],
              //             borderRadius: BorderRadius.circular(20),
              //             boxShadow: const [
              //               BoxShadow(color: Colors.black54, blurRadius: 12, spreadRadius: 2),
              //             ],
              //           ),
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               // Project Image
              //               ClipRRect(
              //                 borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              //                 child: Container(
              //                   color: Colors.white,
              //                   child: Image.asset(
              //                     p['image'].toString(),
              //                     height: 150,
              //                     width: double.infinity,
              //                     fit: p['title'] == 'Degrees Tutorial'
              //                         ? BoxFit.fitWidth
              //                         : BoxFit.fitHeight,
              //                   ),
              //                 ),
              //               ),
              //
              //               // Text Section
              //               Padding(
              //                 padding: const EdgeInsets.all(16),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Row(
              //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                       children: [
              //                         Text(
              //                           p['title'].toString(),
              //                           style: const TextStyle(
              //                             color: Colors.white,
              //                             fontSize: 20,
              //                             fontWeight: FontWeight.bold,
              //                           ),
              //                         ),
              //
              //                         // Playstore + Appstore buttons
              //                         if (["Ayani", "Eira Connect", "Ayani Vendor"].contains(p['title']))
              //                           Row(
              //                             children: [
              //                               IconButton(
              //                                 icon: Icon(
              //                                   Icons.play_circle_fill_outlined,
              //                                   color: Colors.green.shade500,
              //                                 ),
              //                                 onPressed: () => _openUrl(p['playstore'].toString()),
              //                               ),
              //                               if (p['title'] != "Eira Connect" && p['title'] != "Ayani Vendor")
              //                                 IconButton(
              //                                   icon: const Icon(Icons.apple, color: Colors.white),
              //                                   onPressed: () => _openUrl(p['appstore'].toString()),
              //                                 ),
              //                             ],
              //                           ),
              //                       ],
              //                     ),
              //
              //                     const SizedBox(height: 4),
              //                     Text(
              //                       p['subtitle'].toString(),
              //                       style: const TextStyle(color: Colors.white70, fontSize: 14),
              //                     ),
              //
              //                     const SizedBox(height: 10),
              //                     Text(
              //                       p['description'].toString(),
              //                       style: const TextStyle(color: Colors.white60, fontSize: 13, height: 1.5),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
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
      // backgroundColor: Colors.grey.shade700,
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
      // color: Colors.black,
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


//old Nav bar
// Widget _buildNavBar(double width) {
//   final isSmall = width < 900;
//   final navItems = [
//     {'label': 'About', 'key': _aboutKey},
//     {'label': 'Resume', 'key': _resumeKey},
//     {'label': 'Portfolio', 'key': _portfolioKey},
//     // {'label': 'Blog', 'key': _blogKey},
//     // {'label': 'Contact', 'key': _contactKey},
//   ];
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//     child: Row(
//       children: [
//         Expanded(
//           child: Row(
//             children: [
//               Text('Halith Hamja',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                       color: Colors.blueAccent.shade700)),
//               const SizedBox(width: 16),
//               Text('Mobile Application Developer',
//                   style: TextStyle(color: Colors.grey[700])),
//             ],
//           ),
//         ),
//         if (!isSmall)
//           Row(
//             children: navItems.map((item) {
//               return TextButton(
//                 onPressed: () => _scrollTo(item['key'] as GlobalKey),
//                 child: Text(item['label'] as String),
//               );
//             }).toList(),
//           ),
//         const SizedBox(width: 8),
//         ElevatedButton(
//           onPressed: _showContacts,
//           style: ElevatedButton.styleFrom(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//           ),
//           child: const Text('Show Contacts'),
//         )
//       ],
//     ),
//   );
// }

//new hero section with responsive for mobile view


//new hero section
// Widget _heroSection(double width) {
//   final isSmall = width < 900;
//   return Container(
//     // key: _heroKey,
//     width: double.infinity,
//     padding: EdgeInsets.symmetric(horizontal: isSmall ? 20 : 80, vertical: isSmall ? 60 : 100),
//     decoration: const BoxDecoration(
//       gradient: LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [Colors.black, Color(0xFF0A0A23)],
//       ),
//     ),
//     child: Flex(
//       direction: isSmall ? Axis.vertical : Axis.horizontal,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment:
//       isSmall ? CrossAxisAlignment.center : CrossAxisAlignment.start,
//       children: [
//         // LEFT SIDE - Texts
//         Flexible(
//           flex: 1,
//           child: Column(
//             crossAxisAlignment:
//             isSmall ? CrossAxisAlignment.center : CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 '👋 Hello, I’m',
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: 18,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Halith Hamja',
//                 style: TextStyle(
//                   fontSize: isSmall ? 38 : 52,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.indigoAccent,
//                 ),
//               ),
//               const SizedBox(height: 8),
//
//               // Animated Text
//               AnimatedTextKit(
//                 repeatForever: true,
//                 animatedTexts: [
//                   TypewriterAnimatedText(
//                     'Flutter Developer',
//                     textStyle: TextStyle(
//                       color: Colors.white,
//                       fontSize: isSmall ? 20 : 24,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     speed: const Duration(milliseconds: 90),
//                   ),
//                   TypewriterAnimatedText(
//                     'Mobile App Engineer (Kotlin | Flutter)',
//                     textStyle: TextStyle(
//                       color: Colors.white,
//                       fontSize: isSmall ? 20 : 24,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     speed: const Duration(milliseconds: 90),
//                   ),
//                   TypewriterAnimatedText(
//                     'Building seamless cross-platform apps 🚀',
//                     textStyle: TextStyle(
//                       color: Colors.white,
//                       fontSize: isSmall ? 20 : 24,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     speed: const Duration(milliseconds: 90),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 28),
//
//               SizedBox(
//                 width: isSmall ? double.infinity : null,
//                 child: Wrap(
//                   alignment:
//                   isSmall ? WrapAlignment.center : WrapAlignment.start,
//                   spacing: 12,
//                   runSpacing: 12,
//                   children: [
//                     ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.indigoAccent,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 24, vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: () =>
//                           _openUrl('mailto:kjhamja77@gmail.com'),
//                       icon: const Icon(Icons.email_outlined, size: 20),
//                       label: const Text(
//                         'Contact Me',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                     OutlinedButton.icon(
//                       style: OutlinedButton.styleFrom(
//                         side: const BorderSide(color: Colors.indigoAccent),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 24, vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: () => _openUrl(
//                           'https://example.com/Halith_Hamja_Resume.pdf'),
//                       icon: const Icon(Icons.download_outlined, size: 20),
//                       label: const Text(
//                         'Download CV',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         SizedBox(width: isSmall ? 0 : 60, height: isSmall ? 40 : 0),
//
//         // RIGHT SIDE - Animated Image
//         Flexible(
//           flex: 1,
//           child: Center(
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 600),
//               height: isSmall ? 260 : 380,
//               width: isSmall ? 260 : 380,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.indigoAccent.withOpacity(0.3),
//                     blurRadius: 30,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.network(
//                   // Modern Flutter Developer GIF
//                   'https://media.giphy.com/media/coxQHKASG60HrHtvkt/giphy.gif',
//                   fit: BoxFit.cover,
//                   errorBuilder: (c, _, __) =>
//                       Container(color: Colors.grey[900]),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

//old hero section
// Widget _heroSection(double width) {
//   final isSmall = width < 900;
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: isSmall ? 20 : 80, vertical: 48),
//     child: Flex(
//       direction: isSmall ? Axis.vertical : Axis.horizontal,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Flexible(
//           flex: 1,
//           child: Column(
//             crossAxisAlignment: isSmall ? CrossAxisAlignment.center : CrossAxisAlignment.start,
//             children: [
//               Text('👋 Hi, I am', style: TextStyle(color: Colors.grey[700], fontSize: 16)),
//               const SizedBox(height: 8),
//               Text('Halith Hamja',
//                   style: TextStyle(fontSize: isSmall ? 34 : 44, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
//               const SizedBox(height: 8),
//               Text(
//                 'Mobile App Developer — Flutter | Kotlin ',
//                 style: TextStyle(fontSize: 16, color: Colors.black87),
//                 textAlign: isSmall ? TextAlign.center : TextAlign.start,
//               ),
//               const SizedBox(height: 20),
//               Wrap(
//                 spacing: 12,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => _openUrl('mailto:kjhamja77@gmail.com'),
//                     icon: const Icon(Icons.email_outlined),
//                     label: const Text('Email'),
//                   ),
//                   OutlinedButton.icon(
//                     onPressed: () {
//                       // Download CV stub - replace with real pdf url or storage link
//                       _openUrl('https://example.com/aakash_resume.pdf');
//                     },
//                     icon: const Icon(Icons.download_outlined),
//                     label: const Text('Download CV'),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         const SizedBox(width: 24, height: 24),
//         Flexible(
//           flex: 1,
//           child: Center(
//             child: SizedBox(
//               width: isSmall ? 260 : 400,
//               height: isSmall ? 260 : 400,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.network(
//                   // hero GIF used as decorative image; replace as desired
//                   'https://media.giphy.com/media/qgQUggAC3Pfv687qPC/giphy.gif',
//                   fit: BoxFit.cover,
//                   errorBuilder: (c, _, __) => Container(color: Colors.grey[200]),
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }

//new about section

//interactive resume section in basic model
// Widget _resumeSection() {
//   final experiences = [
//     {
//       'title': 'Mobile Application Developer',
//       'company': 'Inspire Clean Energy Private Limited',
//       'duration': 'June 2024 – Jan 2025',
//       'projects': ['Eira', 'Eira Connect'],
//       'bullets': [
//         'Designed and developed mobile applications using Flutter.',
//         'Integrated REST APIs, Firebase services, and Isar DB.',
//         'Implemented responsive UI and clean architecture.'
//       ],
//     },
//     {
//       'title': 'Mobile Application Developer',
//       'company': 'Sanorac Technologies Private Limited',
//       'duration': 'May 2023 – Oct 2023',
//       'projects': ['Vividlipi', 'Degrees Tutorial'],
//       'bullets': [
//         'Developed new features and implemented UI designs in Flutter.',
//         'Integrated Google & Facebook authentication and payment gateways.',
//       ],
//     },
//     {
//       'title': 'Flutter Developer',
//       'company': 'Vugha Technological Solution Private Limited',
//       'duration': 'Apr 2022 – Mar 2023',
//       'projects': ['Ayani', 'Ayani Vendor', 'Ayani Distributor'],
//       'bullets': [
//         'Developed and maintained multi-vendor applications using Flutter and Firebase.',
//         'Implemented CI/CD and handled App Store/Play Store deployments.',
//       ],
//     },
//     {
//       'title': 'Software Developer',
//       'company': 'Garuda Aerospace Private Limited',
//       'duration': 'Jan 2021 – Oct 2021',
//       'projects': ['Garuda Learning Application'],
//       'bullets': [
//         'Developed e-learning application with Firebase integration.',
//         'Implemented authentication and course management modules.',
//       ],
//     },
//   ];
//
//   return Container(
//     key: _resumeKey,
//     // color: Colors.black,
//     decoration: const BoxDecoration(
//       gradient: LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [Colors.black, Color(0xFF0A0A23)],
//       ),
//     ),
//     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SectionTitle('Resume'),
//         const SizedBox(height: 24),
//         Text(
//           'Experience',
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 26,
//           ),
//         ),
//         const SizedBox(height: 24),
//
//         /// EXPERIENCE CARDS
//         Wrap(
//           spacing: 24,
//           runSpacing: 24,
//           children: experiences.map((exp) {
//             return MouseRegion(
//               cursor: SystemMouseCursors.click,
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[900],
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: const [
//                     BoxShadow(color: Colors.black54, blurRadius: 10),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       exp['title'].toString(),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       exp['company']!.toString(),
//                       style: const TextStyle(
//                         color: Colors.white70,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       exp['duration']!.toString(),
//                       style: const TextStyle(
//                         color: Colors.indigoAccent,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//
//                     // Project names as badges
//                     Wrap(
//                       spacing: 6,
//                       runSpacing: 6,
//                       children: (exp['projects'] as List<String>)
//                           .map(
//                             (proj) => Chip(
//                           label: Text(proj),
//                           labelStyle: const TextStyle(color: Colors.white),
//                           backgroundColor: Colors.indigo.shade400,
//                         ),
//                       )
//                           .toList(),
//                     ),
//                     const SizedBox(height: 12),
//
//                     // Responsibilities
//                     ...List.generate(
//                       (exp['bullets'] as List<String>).length,
//                           (i) => Padding(
//                         padding: const EdgeInsets.only(bottom: 6),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text("• ",
//                                 style: TextStyle(color: Colors.white70)),
//                             Expanded(
//                               child: Text(
//                                 (exp['bullets'] as List<String>)[i],
//                                 style: const TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 13,
//                                   height: 1.4,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//
//         const SizedBox(height: 40),
//         const Divider(color: Colors.white24, thickness: 1),
//         const SizedBox(height: 20),
//
//         /// EDUCATION
//         Text(
//           'Education',
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 26,
//           ),
//         ),
//         const SizedBox(height: 20),
//         Container(
//           width: 400,
//           decoration: BoxDecoration(
//             color: Colors.grey[900],
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: const [
//               BoxShadow(color: Colors.black54, blurRadius: 10),
//             ],
//           ),
//           child: ListTile(
//             leading: const Icon(Icons.school_outlined, color: Colors.indigoAccent),
//             title: const Text(
//               'Master of Computer Application',
//               style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//             ),
//             subtitle: const Text(
//               'Periyar Maniammai Institute of Science and Technology\n2017 – 2020',
//               style: TextStyle(color: Colors.white70),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }



//old portfolio section
// Widget _portfolioSection() {
//   final projects = [
//     {'title': 'Eira', 'subtitle': 'Application', 'url': 'https://nagarikapp.gov.np'},
//     {'title': 'Eira Connect', 'subtitle': 'Application', 'url': 'https://play.google.com/store/apps/details?id=com.inspire.nibhuna&pcampaignid=web_share'},
//     {'title': 'Vividlipi', 'subtitle': 'Application', 'url': 'https://play.google.com/store'},
//     {'title': 'Degrees Tutorial', 'subtitle': 'Application', 'url': 'https://tokma.ai'},
//     {'title': 'Ayani', 'subtitle': 'Web', 'url': 'https://play.google.com/store/apps/details?id=com.ayani.prod.vugha&pcampaignid=web_share'},
//     {'title': 'Ayani Vendor', 'subtitle': 'Web', 'url': 'https://play.google.com/store/apps/details?id=com.ayani_vendor.prod.vugha&pcampaignid=web_share'},
//   ];
//
//   return Container(
//     key: _portfolioKey,
//     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
//     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       const SectionTitle('Portfolio'),
//       const SizedBox(height: 12),
//       Wrap(
//         spacing: 16,
//         runSpacing: 16,
//         children: projects.map((p) {
//           return InkWell(
//             onTap: () => _openUrl(p['url']!),
//             child: Container(
//               width: 300,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 150,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Center(child: Text(p['title']!, style: const TextStyle(fontWeight: FontWeight.bold))),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(p['subtitle']!, style: TextStyle(color: Colors.grey[700])),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton.icon(
//                         onPressed: () => _openUrl(p['url']!),
//                         icon: const Icon(Icons.open_in_new),
//                         label: const Text('View'),
//                       ),
//                       ElevatedButton(
//                           onPressed: () => _openUrl('https://github.com/'),
//                           child: const Text('Repo'))
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//       )
//     ]),
//   );
// }
//New one with attractive design


// //attractive designs with project description
// Widget _resumeSection() {
//   final width = MediaQuery.of(context).size.width;
//   final isSmall = width < 900;
//
//   final experiences = [
//     {
//       'title': 'Mobile Application Developer',
//       'company': 'Inspire Clean Energy Private Limited',
//       'duration': 'June 2024 – Jan 2025',
//       'projects': {
//         'Eira': [
//             'Developed Eira Connect, a Flutter-based ticket management app using REST API, Isar DB, and AWS S3 with image capture, secure URL generation, and offline storage.,'
//             'Built Eira Monitoring, an energy tracking app with Syncfusion Charts, intuitive UI, PDF export, and password-protected access.,'
//             'Improved performance, ensured accurate data flow, and maintained stability through debugging, unit testing, and Play Store deployment.'
//      //    'Built an energy monitoring app with real-time data visualization using Syncfusion Charts.',
//      //  'Designed clean and user-friendly screens for easier energy tracking.',
//      //  'Implemented PDF exporting and password-protected access for secure sharing.',
//      // ' Enhanced app speed, performance, and reliability through testing.'
//         ],
//         // 'Eira Connect': [
//         //   'Vendor management application for connecting users and technicians.',
//         //   'Integrated OTP login, push notifications, and technician tracking.',
//         //   'Implemented service ticket creation and workflow automation.',
//         // ],
//       },
//     },
//     {
//       'title': 'Mobile Application Developer',
//       'company': 'Sanorac Technologies Private Limited',
//       'duration': 'May 2023 – Oct 2023',
//       'projects': {
//         'Vividlipi': [
//           'E-learning platform for uploading digital content and video courses.',
//           'Integrated in-app purchases and secure content streaming.',
//           'Built clean UI screens with animations and caching.',
//         ],
//         'Degrees Tutorial': [
//           'Online exam preparation & learning app with quizzes and mock tests.',
//           'Integrated REST APIs with token authentication.',
//           'Designed adaptive UI for mobile and tablet.',
//         ],
//       },
//     },
//     {
//       'title': 'Flutter Developer',
//       'company': 'Vugha Technological Solution Private Limited',
//       'duration': 'Apr 2022 – Mar 2023',
//       'projects': {
//         'Ayani': [
//           'Multi-vendor e-commerce app for buying products online.',
//           'Implemented product search, filter, and checkout flow.',
//           'Added Firebase push notifications and analytics.',
//         ],
//         'Ayani Vendor': [
//           'Vendor application for adding products and managing orders.',
//           'Created analytics dashboard with charts.',
//           'Integrated image upload & product management system.',
//         ],
//         'Ayani Distributor': [
//           'Distributor app for stock management and logistics.',
//           'Implemented delivery tracking and order dispatch features.',
//         ],
//       },
//     },
//     {
//       'title': 'Software Developer',
//       'company': 'Garuda Aerospace Private Limited',
//       'duration': 'Jan 2021 – Oct 2021',
//       'projects': {
//         'Garuda Learning Application': [
//           'E-learning application for drone pilot training.',
//           'Developed Firebase login and course modules.',
//           'Created interactive learning screens and quiz system.',
//         ],
//       },
//     },
//   ];
//
//   return Container(
//     key: _resumeKey,
//     width: double.infinity,
//     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
//     decoration: const BoxDecoration(
//       gradient: LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [Colors.black, Color(0xFF0A0A23)],
//       ),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SectionTitle('Resume'),
//         const SizedBox(height: 32),
//
//         // EXPERIENCE Title
//         const Text(
//           'Experience',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 28,
//           ),
//         ),
//         const SizedBox(height: 28),
//
//         // EXPERIENCE CARD GRID
//         LayoutBuilder(
//           builder: (_, constraints) {
//             final bool isSingleColumn = constraints.maxWidth < 900;
//
//             return Wrap(
//               spacing: 24,
//               runSpacing: 24,
//               children: experiences.map((exp) {
//                 return SizedBox(
//                   width:
//                   isSingleColumn
//                       ? constraints.maxWidth
//                       : (constraints.maxWidth / 2) - 32,
//                   child: _experienceCard(exp),
//                 );
//               }).toList(),
//             );
//           },
//         ),
//
//         const SizedBox(height: 40),
//         const Divider(color: Colors.white30, thickness: 1),
//         const SizedBox(height: 32),
//
//         /// EDUCATION SECTION
//         const Text(
//           'Education',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 28,
//           ),
//         ),
//         const SizedBox(height: 20),
//
//         _educationCard(),
//       ],
//     ),
//   );
// }
//
// /// EXPERIENCE CARD WIDGET
// Widget _experienceCard(Map<String, dynamic> exp) {
//   return AnimatedContainer(
//     duration: const Duration(milliseconds: 300),
//     padding: const EdgeInsets.all(22),
//     decoration: BoxDecoration(
//       color: Colors.white.withOpacity(0.06),
//       borderRadius: BorderRadius.circular(22),
//       border: Border.all(color: Colors.white.withOpacity(0.1)),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.4),
//           blurRadius: 12,
//           offset: const Offset(0, 4),
//         )
//       ],
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Title
//         Text(
//           exp['title'],
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 4),
//
//         // Company
//         Text(
//           exp['company'],
//           style: const TextStyle(color: Colors.white70, fontSize: 14),
//         ),
//         const SizedBox(height: 4),
//
//         // Duration
//         Text(
//           exp['duration'],
//           style: const TextStyle(
//             color: Colors.indigoAccent,
//             fontSize: 13,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//
//         const SizedBox(height: 12),
//
//         // Project Chips
//         // Wrap(
//         //   spacing: 6,
//         //   runSpacing: 6,
//         //   children: (exp['projects'] as Map<String, dynamic>).keys.map((proj) {
//         //     return Chip(
//         //       backgroundColor: Colors.indigo.shade500,
//         //       label: Text(proj, style: const TextStyle(color: Colors.white)),
//         //     );
//         //   }).toList(),
//         // ),
//
//         // const SizedBox(height: 14),
//
//         // PROJECT BULLETS
//         ...(exp['projects'] as Map<String, dynamic>).entries.map((entry) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 8),
//               // Text(
//               //   entry.key,
//               //   style: const TextStyle(
//               //     color: Colors.indigoAccent,
//               //     fontSize: 15,
//               //     fontWeight: FontWeight.bold,
//               //   ),
//               // ),
//               // const SizedBox(height: 6),
//               ...entry.value.map<Widget>((point) {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 6),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("• ",
//                           style: TextStyle(color: Colors.white70)),
//                       Expanded(
//                         child: Text(
//                           point,
//                           style: const TextStyle(
//                             color: Colors.white70,
//                             fontSize: 13,
//                             height: 1.45,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ],
//           );
//         }).toList(),
//       ],
//     ),
//   );
// }

// Widget _blogSection() {
//   final blogs = [
//     {'title': "Flutter vs. Flock: Cross-Platform Evaluation", 'date': 'Nov 18, 2024', 'url': 'https://aakash58.hashnode.dev'},
//     {'title': "Flutter's Impact on Future Cross-Platform Apps", 'date': 'Nov 13, 2024', 'url': 'https://aakash58.hashnode.dev'},
//   ];
//
//   return Container(
//     key: _blogKey,
//     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
//     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       const SectionTitle('Blog'),
//       const SizedBox(height: 12),
//       Column(
//         children: blogs.map((b) {
//           return Card(
//             child: ListTile(
//               title: Text(b['title']!),
//               subtitle: Text(b['date']!),
//               trailing: const Icon(Icons.chevron_right),
//               onTap: () => _openUrl(b['url']!),
//             ),
//           );
//         }).toList(),
//       )
//     ]),
//   );
// }
//
// final _contactFormKey = GlobalKey<FormState>();
// final _nameCtl = TextEditingController();
// final _emailCtl = TextEditingController();
// final _msgCtl = TextEditingController();
//
// Widget _contactSection() {
//   return Container(
//     key: _contactKey,
//     color: Colors.blueAccent.withOpacity(0.06),
//     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
//     child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//       const SectionTitle('Contact'),
//       const SizedBox(height: 8),
//       const Text('Send Message', style: TextStyle(fontSize: 16)),
//       const SizedBox(height: 12),
//       ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 820),
//         child: Form(
//           key: _contactFormKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _nameCtl,
//                 decoration: const InputDecoration(labelText: 'Name'),
//                 validator: (v) => (v?.trim().isEmpty ?? true) ? 'Please enter name' : null,
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: _emailCtl,
//                 decoration: const InputDecoration(labelText: 'Email'),
//                 validator: (v) => (v?.contains('@') ?? false) ? null : 'Enter valid email',
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 controller: _msgCtl,
//                 maxLines: 6,
//                 decoration: const InputDecoration(labelText: 'Message'),
//                 validator: (v) => (v?.trim().length ?? 0) >= 6 ? null : 'Message too short',
//               ),
//               const SizedBox(height: 12),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_contactFormKey.currentState?.validate() ?? false) {
//                     // Replace with sending logic (email/service)
//                     if (kDebugMode) print('Send message: ${_nameCtl.text}');
//                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message sent (mock)')));
//                     _nameCtl.clear();
//                     _emailCtl.clear();
//                     _msgCtl.clear();
//                   }
//                 },
//                 child: const Text('Send Message'),
//               )
//             ],
//           ),
//         ),
//       ),
//     ]),
//   );
// }

// class MiniCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   const MiniCard({required this.title, required this.subtitle, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 220,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white, boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)]),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
//         const SizedBox(height: 6),
//         Text(subtitle, style: const TextStyle(color: Colors.grey)),
//       ]),
//     );
//   }
// }
//
// class ExperienceTile extends StatelessWidget {
//   final String title;
//   final String company;
//   final String duration;
//   final List<String> bullets;
//   const ExperienceTile({required this.title, required this.company, required this.duration, required this.bullets, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: ListTile(
//         leading: const Icon(Icons.work_outline),
//         title: Text('$title — $company'),
//         subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(duration, style: const TextStyle(fontSize: 12, color: Colors.black54)),
//           const SizedBox(height: 8),
//           ...bullets.map((b) => Row(children: [const Text('• ', style: TextStyle(fontSize: 12)), Expanded(child: Text(b, style: const TextStyle(fontSize: 13)))])),
//         ]),
//       ),
//     );
//   }
// }

//old about section
// Widget _aboutSection() {
//   return Container(
//     key: _aboutKey,
//     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SectionTitle('About me'),
//         const SizedBox(height: 12),
//         const Text(
//           'A passionate Flutter developer with strong expertise in cross-platform apps, REST APIs, widgets, and state management solutions. Proven track record in delivering cutting-edge solutions...',
//           style: TextStyle(fontSize: 16, height: 1.5),
//         ),
//         const SizedBox(height: 18),
//         const Text('What I\'m doing', style: TextStyle(fontWeight: FontWeight.w600)),
//         const SizedBox(height: 12),
//         Wrap(
//           spacing: 12,
//           runSpacing: 12,
//           children: const [
//             MiniCard(title: 'Mobile Apps', subtitle: 'Professional Android & iOS development'),
//             // MiniCard(title: 'Web development', subtitle: 'High-quality web apps'),
//             // MiniCard(title: 'UI/UX Design', subtitle: 'Modern, user-friendly design'),
//             // MiniCard(title: 'Backend Development', subtitle: 'Scalable backend services'),
//           ],
//         ),
//         const SizedBox(height: 18),
//         const Text('Skills', style: TextStyle(fontWeight: FontWeight.w600)),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 50,
//           children: [
//             Tooltip(message:"Flutter",child:  Image.asset('assets/flutter.png',height: 70,width: 70,fit: BoxFit.fitHeight,)),//Chip(label:),
//             // Chip(label: Text('Flutter')),
//             Tooltip(message:"Kotlin",child:  Image.asset('assets/kotlin_Icon.png',height: 70,width: 70,fit: BoxFit.fitHeight,)),//Chip(label:),
//             Tooltip(message:"Python",child:  Image.asset('assets/python.png',height: 70,width: 70,fit: BoxFit.fitHeight,)),//Chip(label:),
//             Tooltip(message:"Firebase",child:  Image.asset('assets/firebase.png',height: 70,width: 70,fit: BoxFit.fitHeight,)),//Chip(label:),
//           ],
//         ),
//         const SizedBox(height: 16),
//         const Text('Tools', style: TextStyle(fontWeight: FontWeight.w600)),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 50,
//           children: [
//             Tooltip(message:"Android Studio",child: Image.asset('assets/androidStudio.png',height: 70,width: 70,fit: BoxFit.fitHeight,)),//Chip(label:)
//             // Chip(label: Text('Flutter')),
//             Tooltip(message:"Xcode",child: Image.asset('assets/xcode.png',height: 70,width: 70,fit: BoxFit.fitHeight,)),//Chip(label:)
//             Tooltip(message:"VS Code",child:  Image.asset('assets/vscode.png',height: 70,width: 70,fit: BoxFit.fitHeight,)),//Chip(label:),
//             Tooltip(message:"Postman",child:  Image.asset('assets/postman.png',height: 70,width: 70,fit: BoxFit.fitHeight,)),//Chip(label:),
//           ],
//         )
//       ],
//     ),
//   );
// }

//old resume section
// Widget _resumeSection() {
//   return Container(
//     key: _resumeKey,
//     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
//     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       const SectionTitle('Resume'),
//       const SizedBox(height: 12),
//       const SizedBox(height: 12),
//       const Text('Experience', style: TextStyle(fontWeight: FontWeight.w600)),
//       const SizedBox(height: 8),
//       ExperienceTile(
//         title: 'Mobile Application Developer',
//         company: 'Inspire Clean Energy Private Limited',
//         duration: 'June 2024 - Jan 2025',
//         bullets: const [
//           'Designing and developing mobile applications using Flutter.',
//         ],
//       ),
//       ExperienceTile(
//         title: 'Mobile Application Developer',
//         company: 'Sanorac Technologies Private Limited',
//         duration: 'May 2023 — October 2023',
//         bullets: const [
//           'Developed new features and implemented UI designs.',
//           'Integrated Google and Facebook sign-in.',
//         ],
//       ),
//       ExperienceTile(
//         title: 'Flutter Developer',
//         company: 'Vugha Technological Solution Private Limited',
//         duration: 'April 2022 — March 2023',
//         bullets: const [
//           'Developed new features and implemented UI designs.',
//           'Integrated Google and Facebook sign-in.',
//         ],
//       ),
//       ExperienceTile(
//         title: 'Software Developer',
//         company: 'Garuda Aerospace Private Limited',
//         duration: 'Jan 2021 — October 2021',
//         bullets: const [
//           'Developed new features and implemented UI designs.',
//           'Integrated Google and Facebook sign-in.',
//         ],
//       ),
//       const SizedBox(height: 8),
//       const Text('Education', style: TextStyle(fontWeight: FontWeight.w600)),
//       const SizedBox(height: 8),
//       Card(
//         child: ListTile(
//           title: const Text('Master of Computer Application'),
//           subtitle: const Text('Periyar Maniammai Institute of Science and Technology\n2017 — 2020'),
//           leading: const Icon(Icons.school_outlined),
//         ),
//       ),
//       // ElevatedButton.icon(
//       //   onPressed: () => _openUrl('https://example.com/aakash_resume.pdf'),
//       //   icon: const Icon(Icons.download_outlined),
//       //   label: const Text('Download CV'),
//       // ),
//     ]),
//   );
// }

// class PortfolioPage extends StatelessWidget {
//   final List<Map<String, dynamic>> projects = [
//     {
//       'title': 'Eira',
//       'description': 'A Flutter app for Monitor Energy levels, Charts, and synchronization.',
//       'tech': ['Flutter', 'Bloc Cubit', 'FL_Charts'],
//     },
//     {
//       'title': 'Eira Connect',
//       'description': 'A Flutter app for managing service tickets with image capture, offline storage, and synchronization.',
//       'tech': ['Flutter', 'Bloc Cubit', 'Isar DB', 'Camera Plugin'],
//     },
//     {
//       'title': 'Vividlipi',
//       'description': 'A Flutter app for managing service tickets with image capture, offline storage, and synchronization.',
//       'tech': ['Flutter', 'Bloc Cubit', 'Isar DB', 'Camera Plugin'],
//     },
//     {
//       'title': 'Expense Tracker',
//       'description': 'A personal finance tracker built with Flutter using local database and clean UI.',
//       'tech': ['Flutter', 'Provider', 'SQLite'],
//     },
//   ];
//
//   PortfolioPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[850],
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Header
//             Container(
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height*0.5,
//               padding: EdgeInsets.only(left: 18,right: 18,top: 40,bottom: 30),
//               // color: Colors.grey[900],
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Align(alignment: Alignment.centerLeft,
//                     child: Text('Halith Hamja', style: TextStyle(fontSize: 30,
//                         fontWeight: FontWeight.bold,color: Colors.grey[400])),
//                   ),
//                   SizedBox(height: 5),
//                   Align(alignment: Alignment.centerLeft,
//                     child: Text('Mobile Application Developer', style: TextStyle(fontSize: 28,
//                         fontWeight: FontWeight.bold,color: Colors.grey[400])),
//                   ),
//                   SizedBox(height: 8),
//                   Text('Passionate about building smooth, scalable mobile apps using Flutter, Bloc, and Isar.',
//                       textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[400])),
//                   SizedBox(height: 16),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.center,
//                   //   children: [
//                   //     IconButton(onPressed: () {}, icon: Icon(Icons.code,color: Colors.grey[400])),
//                   //     IconButton(onPressed: () {}, icon: Icon(Icons.language,color: Colors.grey[400])),
//                   //     IconButton(onPressed: () {}, icon: Icon(Icons.mail,color: Colors.grey[400])),
//                   //   ],
//                   // ),
//                 ],
//               ),
//             ),
//
//             // Skills Section
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.white60,
//               ),
//               margin: EdgeInsets.symmetric(horizontal: 8),
//               padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
//
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Technical Skills', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 16),
//                   Wrap(
//                     spacing: 32,
//                     runSpacing: 16,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Languages: Dart, Kotlin, Java'),
//                           Text('Frameworks: Flutter, Jetpack Compose'),
//                           Text('State Management: Bloc, Cubit, Provider'),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Database: Isar DB, SQLite, Firebase'),
//                           Text('Tools: Android Studio, Git, Postman'),
//                           Text('API: REST, Google Maps SDK'),
//                         ],
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//
//             // Projects Section
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.white60
//               ),
//               margin: EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 8),
//               padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Projects', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 24),
//                   Column(
//                     children: projects.map((project) {
//                       return Card(
//                         color: Colors.grey[600],
//                         margin: EdgeInsets.symmetric(vertical: 8),
//                         child: Padding(
//                           padding: EdgeInsets.all(16),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(project['title'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                               SizedBox(height: 8),
//                               Text(project['description'], style: TextStyle(color: Colors.grey[400])),
//                               SizedBox(height: 8),
//                               Text('Tech: ' + (project['tech'] as List<String>).join(', '), style: TextStyle(color: Colors.grey[500])),
//                             ],
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   )
//                 ],
//               ),
//             ),
//
//             // Contact Section
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
//               // color: Colors.grey[850],
//               child: Column(
//                 children: [
//                   Text('Contact', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.grey,)),
//                   SizedBox(height: 8),
//                   Text('Interested in working together or have a project idea?', style: TextStyle(color: Colors.grey[400])),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Launch email
//                     },
//                     child: Text('Get in Touch'),
//                   ),
//                   SizedBox(height: 16),
//                   Text('© 2025 Hamja. All rights reserved.', style: TextStyle(color: Colors.grey[500])),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class portfolio extends StatefulWidget {
//   const portfolio({super.key});
//
//   @override
//   State<portfolio> createState() => _portfolioState();
// }
//
// class _portfolioState extends State<portfolio> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Halith Hamja"),
//         leading: IconButton(onPressed: (){
//
//         }, icon: Icon(Icons.arrow_back_sharp)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.network(
//                 "https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExcHV2cm8zdm1uYnQ3bmZndG15anZoNDV4Y2swZHhpaXIwampya3ByOSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/jYh9UDh2OE7XW/giphy.gif"
//               ,fit: BoxFit.fitWidth,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
