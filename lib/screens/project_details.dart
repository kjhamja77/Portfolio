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
    images = widget.screenshots;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    for(final path in widget.screenshots){
      precacheImage(AssetImage(path), context);
    }
    super.didChangeDependencies();
  }

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


  Widget _content() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),

            const SizedBox(height: 10),
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

            _carouselSection(),
            const SizedBox(height: 30),

            Text(
              widget.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 32),

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
        ],
      ),
    );
  }

  Widget _carouselSection() {
    return Column(
      children: [
        widget.screenshots.isEmpty? SizedBox()
            :SizedBox(
      height: 450,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
            child: ClipRRect(borderRadius: BorderRadius.circular(20),
              child:
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