class JobModel {
  final String id;
  final String title;
  final String salaryRange;
  final String location;
  final String locationType; // 'Remote', 'On-site', 'Multiple locations'
  final DateTime postedOn;
  final DateTime expiresOn;
  final String postedBy;
  final String? previousBump;
  final String? nextBump;
  final int views;
  final int applications;
  final int shares;
  final int messages;
  final int saved;
  final int invitations;
  final bool isFeatured;
  final String status; // 'scheduled', 'active', 'expired', 'draft'

  JobModel({
    required this.id,
    required this.title,
    required this.salaryRange,
    required this.location,
    required this.locationType,
    required this.postedOn,
    required this.expiresOn,
    required this.postedBy,
    this.previousBump,
    this.nextBump,
    required this.views,
    required this.applications,
    required this.shares,
    required this.messages,
    required this.saved,
    required this.invitations,
    this.isFeatured = false,
    required this.status,
  });
}
