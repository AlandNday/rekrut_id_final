// lib/app/data/models/job_model.dart
class Job {
  final String title;
  final String company;
  final String location;
  final String salary; // e.g., "$40000-$42000"
  final String postedTime; // e.g., "10 minutes ago", "1 day ago"
  final String jobType; // e.g., "Fulltime", "Part Time"
  final String category; // e.g., "Commerce", "Financial Services"
  final String experienceLevel; // e.g., "Associate", "Mid-Senior"
  final List<String> tags; // e.g., ["Design", "Soft"]
  final String? companyInitial; // Optional, for initial placeholder in UI
  final String id; // Added a unique ID for each job

  Job({
    required this.id, // ID is now required
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.postedTime,
    required this.jobType,
    this.category = 'Other', // Default value if not specified
    this.experienceLevel = 'Entry Level', // Default value if not specified
    this.tags = const [], // Default empty list
    this.companyInitial,
  });

  /// Factory constructor to create a Job from a JSON map (e.g., from an API response).
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] as String,
      title: json['title'] as String,
      company: json['company'] as String,
      location: json['location'] as String,
      salary: json['salary'] as String,
      postedTime: json['posted_time'] as String,
      jobType: json['job_type'] as String,
      category: json['category'] as String? ?? 'Other',
      experienceLevel: json['experienceLevel'] as String? ?? 'Entry Level',
      tags: List<String>.from(json['tags'] as List? ?? []),
      companyInitial: json['companyInitial'] as String?,
    );
  }

  /// Converts the Job object to a JSON map (e.g., for sending to an API).
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'location': location,
      'salary': salary,
      'postedTime': postedTime,
      'jobType': jobType,
      'category': category,
      'experienceLevel': experienceLevel,
      'tags': tags,
      'companyInitial': companyInitial,
    };
  }

  /// Parses the salary string (e.g., "$10000-$20000") into a tuple of (min, max) in thousands.
  (double, double) parseSalaryRange() {
    final cleanSalary = salary.replaceAll(
      RegExp(r'[^\d-]+'),
      '',
    ); // Remove non-numeric except hyphen
    final parts = cleanSalary.split('-');
    if (parts.length == 2) {
      final start = double.tryParse(parts[0]) ?? 0.0;
      final end = double.tryParse(parts[1]) ?? 0.0;
      return (
        start / 1000,
        end / 1000,
      ); // Convert to K for comparison with slider
    }
    return (0.0, 0.0); // Default if parsing fails
  }

  /// Converts the 'postedTime' string (e.g., "10 minutes ago", "1 day ago") into a DateTime object.
  DateTime getPostedDateTime() {
    final now = DateTime.now();
    final parts = postedTime.split(' ');
    if (parts.length >= 2) {
      final value = int.tryParse(parts[0]) ?? 0;
      final unit = parts[1].toLowerCase();

      if (unit.contains('minute')) {
        return now.subtract(Duration(minutes: value));
      } else if (unit.contains('hour')) {
        return now.subtract(Duration(hours: value));
      } else if (unit.contains('day')) {
        return now.subtract(Duration(days: value));
      } else if (unit.contains('week')) {
        return now.subtract(Duration(days: value * 7));
      } else if (unit.contains('month')) {
        return now.subtract(Duration(days: value * 30)); // Approximation
      } else if (unit.contains('year')) {
        return now.subtract(Duration(days: value * 365)); // Approximation
      }
    }
    return now; // Default to now if parsing fails or "Any Time"
  }
}
