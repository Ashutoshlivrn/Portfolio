class ProjectItem {
  final String id;
  final String title;
  final String tagline;
  final String description;
  final List<String> tags;
  final String category;
  final String? githubUrl;
  final String? liveUrl;
  final String stats;
  final bool isFeatured;

  const ProjectItem({
    required this.id,
    required this.title,
    required this.tagline,
    required this.description,
    required this.tags,
    required this.category,
    this.githubUrl,
    this.liveUrl,
    required this.stats,
    this.isFeatured = false,
  });
}
