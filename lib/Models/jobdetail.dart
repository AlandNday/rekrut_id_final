// lib/app/data/models/job_detail_model.dart Ensure correct path to your Job model

import 'package:rekrut_id_final/Models/jobmodel.dart';

class JobDetail {
  final Job job; // The basic job information
  final String description;
  final List<String> keyResponsibilities;
  final List<String> professionalSkills;
  final List<Job> relatedJobs; // A list of other Job objects

  JobDetail({
    required this.job,
    required this.description,
    this.keyResponsibilities = const [],
    this.professionalSkills = const [],
    this.relatedJobs = const [],
  });

  // Factory constructor for creating a JobDetail from an API response JSON
  factory JobDetail.fromJson(Map<String, dynamic> json) {
    return JobDetail(
      job: Job.fromJson(
        json['job'] as Map<String, dynamic>,
      ), // Parse nested Job object
      description: json['description'] as String,
      // Handle potential nulls for lists using ?? []
      keyResponsibilities: List<String>.from(
        json['key_responsibilities'] as List? ?? [],
      ), // Corrected key to snake_case
      professionalSkills: List<String>.from(
        json['professional_skills'] as List? ?? [],
      ), // Corrected key to snake_case
      relatedJobs:
          (json['related_jobs'] as List? ??
                  []) // Corrected key to snake_case, handle null list
              .map((item) => Job.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }

  // ToJson method if you need to send JobDetail to an API (e.g., for creating/updating)
  Map<String, dynamic> toJson() {
    return {
      'job': job.toJson(),
      'description': description,
      'key_responsibilities': keyResponsibilities,
      'professional_skills': professionalSkills,
      'related_jobs': relatedJobs.map((j) => j.toJson()).toList(),
    };
  }
}
