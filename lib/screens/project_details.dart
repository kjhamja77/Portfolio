import 'package:flutter/material.dart';

class ProjectDetailsPage extends StatefulWidget {
  final String projectName;
  final String description;
  final String tagline;
  final String logoPath;
  final List<dynamic> screenshots;
  final List<String> techStack;

  const ProjectDetailsPage({
    super.key,
    required this.projectName,
    required this.tagline,
    required this.description,
    required this.logoPath,
    required this.screenshots,
    required this.techStack,
  });

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  late List<dynamic> images;

  @override
  void initState() {
    // TODO: implement initState
    images = widget.screenshots;
    // images = widget.screenshots.map((e)=>Image.asset(e,
    //   gaplessPlayback: true,
    //   errorBuilder: (context, error, stackTrace) => Container(
    //     color: Colors.grey[900],
    //     child: Icon(Icons.broken_image, color: Colors.red, size: 48),
    //   ),)).toList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    for(final path in widget.screenshots){
      precacheImage(AssetImage(path), context);
    }
    super.didChangeDependencies();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   images.clear();
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A23),
      body: Stack(
        children: [
          _backgroundGradient(),
          _content(),
        ],
      ),
    );
  }

  /// ---------------- BACKGROUND GRADIENT ----------------
  Widget _backgroundGradient() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Color(0xFF0A0A23)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }


  /// ---------------- MAIN CONTENT ----------------
  Widget _content() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Back button
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),

            const SizedBox(height: 10),

            /// Project Logo
            Row(
              children: [
                Hero(
                  tag: widget.projectName,
                  child: Image.asset(widget.logoPath,height: 120,width: 120,),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.projectName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(widget.tagline,style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),)
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Screenshot carousel
            _carouselSection(),
            const SizedBox(height: 30),

            /// Description
            Text(
              widget.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 32),

            /// Tech Stack
            const Text(
              "Technologies & Tools",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _techStackChips(),
          ],
        ),
      ),
    );
  }
  Widget _techStackChips() {
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          SizedBox(
            width: double.infinity,
            height: 120,
            // color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
            itemCount: widget.techStack.length,
            itemBuilder: (context,index){
              final stack = widget.techStack[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                  child: _techCard(stack));
            }),
          ),
        ],
      );
}

  Widget _techCard(String icon) {
    final tech = icon.split(RegExp(r'[/.]'));
    final fileNameNoExt = tech[tech.length - 2];
    final withCap = fileNameNoExt[0].toUpperCase()+fileNameNoExt.substring(1);
    return Container(
      width: 130,
      // height: 100,
      padding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(icon, height: 50,width: 50,fit: BoxFit.cover,),
          SizedBox(height: 10),
          Text(withCap, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          // SizedBox(height: 6),
          // Text(desc, style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  /// ---------------- IMAGE CAROUSEL ----------------
  Widget _carouselSection() {
    return Column(
      children: [
        widget.screenshots.isEmpty? SizedBox()
            :SizedBox(
      height: 450,
      width: double.infinity,
      child: ListView.builder(
        // controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          // var images = widget.screenshots[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
            child: ClipRRect(borderRadius: BorderRadius.circular(20),
              child:
              // images[index]
              Image.asset(widget.screenshots[index],
                key: UniqueKey(),
                fit: BoxFit.fitHeight,height: 400, gaplessPlayback: true,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[900],
              child: Icon(Icons.broken_image, color: Colors.red, size: 48),
            )),
            ),
          );
        },
      ),
    ),
        const SizedBox(height: 12),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
//
// class ProjectDetailsPage extends StatelessWidget {
//   final String title;
//   final String description;
//   final List<String> techStack;
//   final List<String> features;
//   final List<String> screenshots; // list of image asset paths or network images
//
//   const ProjectDetailsPage({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.techStack,
//     required this.features,
//     this.screenshots = const [],
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Project Title
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//
//             const SizedBox(height: 12),
//
//             // Description
//             Text(
//               description,
//               style: const TextStyle(fontSize: 16, height: 1.4),
//             ),
//
//             const SizedBox(height: 20),
//
//             // Tech Stack Section
//             const Text(
//               "Tech Stack",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//
//             const SizedBox(height: 10),
//
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: techStack
//                   .map((item) => Chip(
//                 label: Text(item),
//                 backgroundColor: Colors.blue.shade50,
//               ))
//                   .toList(),
//             ),
//
//             const SizedBox(height: 25),
//
//             // Features Section
//             const Text(
//               "Key Features",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//
//             const SizedBox(height: 10),
//
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: features
//                   .map(
//                     (feature) => Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 4),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Icon(Icons.check_circle,
//                           size: 18, color: Colors.green),
//                       const SizedBox(width: 8),
//                       Expanded(child: Text(feature)),
//                     ],
//                   ),
//                 ),
//               )
//                   .toList(),
//             ),
//
//             const SizedBox(height: 25),
//
//             // Screenshots Section
//             if (screenshots.isNotEmpty) ...[
//               const Text(
//                 "Screenshots",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 12),
//
//               SizedBox(
//                 height: 200,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: screenshots.length,
//                   separatorBuilder: (_, __) => const SizedBox(width: 12),
//                   itemBuilder: (context, index) {
//                     return ClipRRect(
//                       borderRadius: BorderRadius.circular(12),
//                       child: Image.network(
//                         screenshots[index],
//                         width: 300,
//                         height: 200,
//                         fit: BoxFit.cover,
//                         errorBuilder: (_, __, ___) => Container(
//                           width: 300,
//                           height: 200,
//                           color: Colors.grey.shade300,
//                           child: const Icon(Icons.image_not_supported),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//
//               const SizedBox(height: 30),
//             ],
//
//             // Back Button
//             Center(
//               child: ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 style: ElevatedButton.styleFrom(
//                   padding:
//                   const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: const Text(
//                   "Back to Projects",
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }
// }
