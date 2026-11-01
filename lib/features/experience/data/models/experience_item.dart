class ExperienceItem {
  final String role;
  final String company;
  final String period;
  final String location;
  final String description;
  final List<String> highlights;
  final List<String> technologies;
  final bool isCurrent;

  const ExperienceItem({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.description,
    required this.highlights,
    required this.technologies,
    this.isCurrent = false,
  });
}
