class ProjectScreenshot {
  final String id;
  final String path;
  ProjectScreenshot({required this.id, required this.path});
}

class Project {
  final String title;
  final String subtitle;
  final String tagline;
  final String description;
  final String brief;
  final String image;
  final List<ProjectScreenshot> screenshots;
  final String github;
  final String playstore;
  final String appstore;

  Project({
    required this.title,
    required this.subtitle,
    required this.tagline,
    required this.description,
    required this.brief,
    required this.image,
    required this.screenshots,
    required this.github,
    required this.playstore,
    required this.appstore,
  });
}
