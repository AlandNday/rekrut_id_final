import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rekrut_id_final/Models/jobmodel.dart';
import 'package:http/http.dart' as http;

class JobboardController extends GetxController {
  final searchQuery = ''.obs;
  final selectedLocation = 'Anywhere (Global)'.obs;
  final selectedCategories = <String>[].obs;
  final selectedJobTypes = <String>[].obs;
  final selectedExperienceLevels = <String>[].obs;
  final selectedPostedTimes = <String>[].obs;
  final salaryRange = const RangeValues(10, 90).obs; // Represents $10K to $90K
  final selectedTags = <String>[].obs;
  final sortOption = 'Sort By Latest'.obs;

  // Job data
  final RxList<Job> allJobs = <Job>[].obs; // Master list of all jobs
  final RxList<Job> filteredJobs =
      <Job>[].obs; // Jobs displayed in UI after filtering

  // API base URL - IMPORTANT: Use your Laravel development server IP or URL
  final String _baseUrl =
      'https://backend-rekruit-id-production.up.railway.app/api/jobs'; // For Android emulator, use 10.0.2.2. For iOS simulator/real device, use your machine's IP.

  @override
  void onInit() {
    super.onInit();
    fetchJobs(); // Fetch jobs from API on init

    // Initial filtering when the controller is ready
    applyFilters();

    // Listen to changes in filter observables and re-apply filters
    ever(searchQuery, (_) => applyFilters());
    ever(selectedLocation, (_) => applyFilters());
    ever(selectedCategories, (_) => applyFilters());
    ever(selectedJobTypes, (_) => applyFilters());
    ever(selectedExperienceLevels, (_) => applyFilters());
    ever(selectedPostedTimes, (_) => applyFilters());
    ever(salaryRange, (_) => applyFilters());
    ever(selectedTags, (_) => applyFilters());
    ever(sortOption, (_) => applyFilters());
  }

  /// Fetches jobs from the Laravel API with detailed logging.
  Future<void> fetchJobs() async {
    print('--- API Call Started ---');
    print('Request URL: $_baseUrl');
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      print('Response Status Code: ${response.statusCode}');
      print(
        'Response Body (first 500 chars): ${response.body.substring(0, response.body.length > 500 ? 500 : response.body.length)}...',
      ); // Log a snippet

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['data'] is List) {
          final List<Job> fetchedJobs = (responseData['data'] as List)
              .map((jobJson) => Job.fromJson(jobJson))
              .toList();
          allJobs.assignAll(fetchedJobs);
          applyFilters(); // Apply filters once jobs are fetched
          print('Successfully loaded ${fetchedJobs.length} jobs.');
        } else {
          print(
            'API Response data is not a list under "data" key: ${responseData['data']}',
          );
          Get.snackbar(
            'Error',
            'Unexpected API response format. Data key is not a list.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        print(
          'Failed to load jobs. Server responded with status code: ${response.statusCode}',
        );
        // Optionally, show a GetX snackbar or dialog for error
        Get.snackbar(
          'Error',
          'Failed to load jobs. Status code: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error fetching jobs: $e');
      // Optionally, show a GetX snackbar or dialog for error
      Get.snackbar(
        'Error',
        'An error occurred while fetching jobs: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      print('--- API Call Finished ---');
    }
  }

  // --- Methods to update filter state (remain mostly the same) ---
  void toggleCategory(String category, bool? isSelected) {
    if (isSelected ?? false) {
      selectedCategories.add(category);
    } else {
      selectedCategories.remove(category);
    }
    applyFilters();
  }

  void toggleJobType(String jobType, bool? isSelected) {
    if (isSelected ?? false) {
      selectedJobTypes.add(jobType);
    } else {
      selectedJobTypes.remove(jobType);
    }
    applyFilters();
  }

  void toggleExperienceLevel(String level, bool? isSelected) {
    if (isSelected ?? false) {
      selectedExperienceLevels.add(level);
    } else {
      selectedExperienceLevels.remove(level);
    }
    applyFilters();
  }

  void togglePostedTime(String time, bool? isSelected) {
    if (isSelected ?? false) {
      selectedPostedTimes.add(time);
    } else {
      selectedPostedTimes.remove(time);
    }
    applyFilters();
  }

  void toggleTag(String tag, bool isSelected) {
    if (isSelected) {
      selectedTags.add(tag);
    } else {
      selectedTags.remove(tag);
    }
    applyFilters();
  }

  /// Applies all selected filters and sorting to the job list.
  void applyFilters() {
    List<Job> currentJobs = List<Job>.from(
      allJobs,
    ); // Start with a fresh copy of all jobs

    // 1. Apply Search Query Filter
    if (searchQuery.value.isNotEmpty) {
      currentJobs = currentJobs.where((job) {
        final query = searchQuery.value.toLowerCase();
        return job.title.toLowerCase().contains(query) ||
            job.company.toLowerCase().contains(query) ||
            job.location.toLowerCase().contains(query);
      }).toList();
    }

    // 2. Apply Location Filter
    if (selectedLocation.value != 'Anywhere (Global)') {
      currentJobs = currentJobs
          .where((job) => job.location == selectedLocation.value)
          .toList();
    }

    // 3. Apply Category Filter
    if (selectedCategories.isNotEmpty) {
      currentJobs = currentJobs
          .where((job) => selectedCategories.contains(job.category))
          .toList();
    }

    // 4. Apply Job Type Filter
    if (selectedJobTypes.isNotEmpty) {
      currentJobs = currentJobs
          .where((job) => selectedJobTypes.contains(job.jobType))
          .toList();
    }

    // 5. Apply Experience Level Filter
    if (selectedExperienceLevels.isNotEmpty) {
      currentJobs = currentJobs
          .where(
            (job) => selectedExperienceLevels.contains(job.experienceLevel),
          )
          .toList();
    }

    // 6. Apply Posted Time Filter
    if (selectedPostedTimes.isNotEmpty) {
      final now = DateTime.now();
      currentJobs = currentJobs.where((job) {
        if (selectedPostedTimes.contains('Any Time')) {
          return true; // No filter
        }
        final jobDateTime = job.getPostedDateTime();
        bool matches = false;
        if (selectedPostedTimes.contains('Last 24 Hours')) {
          if (jobDateTime.isAfter(now.subtract(const Duration(hours: 24)))) {
            matches = true;
          }
        }
        if (selectedPostedTimes.contains('Last 3 Days')) {
          if (jobDateTime.isAfter(now.subtract(const Duration(days: 3)))) {
            matches = true;
          }
        }
        if (selectedPostedTimes.contains('Last 7 Days')) {
          if (jobDateTime.isAfter(now.subtract(const Duration(days: 7)))) {
            matches = true;
          }
        }
        if (selectedPostedTimes.contains('Last 14 Days')) {
          if (jobDateTime.isAfter(now.subtract(const Duration(days: 14)))) {
            matches = true;
          }
        }
        if (selectedPostedTimes.contains('Last 30 Days')) {
          if (jobDateTime.isAfter(now.subtract(const Duration(days: 30)))) {
            matches = true;
          }
        }
        return matches;
      }).toList();
    }

    // 7. Apply Salary Range Filter
    final minSalary = salaryRange.value.start * 1000;
    final maxSalary = salaryRange.value.end * 1000;
    currentJobs = currentJobs.where((job) {
      final (jobMin, jobMax) = job.parseSalaryRange();
      return (jobMin * 1000 >= minSalary && jobMin * 1000 <= maxSalary) ||
          (jobMax * 1000 >= minSalary && jobMax * 1000 <= maxSalary) ||
          (jobMin * 1000 < minSalary &&
              jobMax * 1000 >
                  maxSalary); // If job range spans across filter range
    }).toList();

    // 8. Apply Tags Filter
    if (selectedTags.isNotEmpty) {
      currentJobs = currentJobs
          .where((job) => job.tags.any((tag) => selectedTags.contains(tag)))
          .toList();
    }

    // 9. Apply Sorting
    currentJobs.sort((a, b) {
      switch (sortOption.value) {
        case 'Sort By Latest':
          return b.getPostedDateTime().compareTo(a.getPostedDateTime());
        case 'Sort By Oldest':
          return a.getPostedDateTime().compareTo(b.getPostedDateTime());
        case 'Sort By Salary':
          final (aMin, aMax) = a.parseSalaryRange();
          final (bMin, bMax) = b.parseSalaryRange();
          return ((aMin + aMax) / 2).compareTo(
            ((bMin + bMax) / 2),
          ); // Sort by average salary
        default:
          return 0; // No sorting
      }
    });

    // Update the observable filteredJobs list
    filteredJobs.assignAll(currentJobs);
    print('Filtered results count: ${filteredJobs.length}');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
