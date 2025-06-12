import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rekrut_id_final/Models/jobmodel.dart';
import 'package:rekrut_id_final/infrastructure/navigation/routes.dart';

import 'controllers/jobboard.controller.dart';

class JobboardScreen extends GetView<JobboardController> {
  const JobboardScreen({super.key});
  // Define static color constants for consistency and easy modification.
  static const Color primaryColor = Color(0xFF4A148C); // Dark purple background
  static const Color accentColor = Color(
    0xFFE040FB,
  ); // Vibrant pink/light purple for accents
  static const Color textColor = Colors.black; // General text color
  static const Color secondaryTextColor = Colors.black;
  // Lighter purple for subtle text/icons
  static Color cardColor =
      Colors.white; // Slightly lighter purple for card backgrounds
  static const Color filterChipColor = Color(
    0xFF8860B7,
  ); // Color for selected filter chips
  static const Color chipTextColor =
      Colors.white; // Text color for filter chips

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic visual structure for the material design app.
    return Scaffold(
      backgroundColor: primaryColor, // Set the main background color
      body: SingleChildScrollView(
        // SingleChildScrollView allows the content to be scrollable if it overflows,
        // which is good for ensuring content is always visible on different screen sizes.
        child: Column(
          children: [
            _buildHeader(), // Top navigation and branding
            _buildJobsPageTitle(), // The "Jobs" page title
            _buildMainContentArea(), // Contains sidebar and job listings
            // _buildTopCompanySection(), // Section for top companies
            _buildFooter(), // Bottom section with links and copyright
          ],
        ),
      ),
    );
  }

  /// Builds the top header bar with logo, navigation links, and action buttons.
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        children: [
          // Branding Logo (stylized 'R' - now "Job Portal")
          const Text(
            'Job Portal',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 50), // Spacing after the logo
          // Navigation links - Wrapped in an Expanded widget and Align for central positioning
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize:
                    MainAxisSize.min, // Make the Row take minimum space
                children: [
                  _buildNavLink('Home'),
                  _buildNavLink('Jobs'),
                  _buildNavLink('Contact Us'),
                ],
              ),
            ),
          ),

          // Login/Register buttons
          Row(
            children: [
              _buildTextButton('Login', () {}),
              const SizedBox(width: 10),
              _buildElevatedButton('Register', () {}),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper widget for creating navigation text buttons.
  Widget _buildNavLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextButton(
        onPressed: () {
          switch (text) {
            case 'Home':
              Get.toNamed(Routes.HOME);
              break;
            case 'Jobs':
              Get.toNamed(Routes.JOBBOARD);
              break; // Don't forget 'break' to exit the switch
            case 'About Us':
              Get.toNamed(Routes.ABOUTUS);
              break; // Don't forget 'break' to exit the switch
            case 'Contact Us':
              Get.toNamed(Routes.CONTACTUS);
              break; // Don't forget 'break' to exit the switch
          }
        },
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

  /// Helper widget for creating a standard text button.
  Widget _buildTextButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }

  /// Helper widget for creating a styled elevated button with optional icon.
  Widget _buildElevatedButton(
    String text,
    VoidCallback onPressed, {
    IconData? icon,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor, // Button background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), // Rounded corners
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Make the row take minimum space
        children: [
          if (icon != null)
            Icon(icon, color: textColor, size: 18), // Optional icon
          if (icon != null)
            const SizedBox(width: 8), // Spacing between icon and text
          Text(text, style: TextStyle(color: textColor, fontSize: 16)),
        ],
      ),
    );
  }

  /// Builds the "Jobs" page title section.
  Widget _buildJobsPageTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      alignment: Alignment.center,
      child: const Text(
        'Jobs',
        style: TextStyle(
          color: Colors.white,
          fontSize: 60,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Builds the main content area, containing the sidebar and job listings.
  Widget _buildMainContentArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the top
        children: [
          // Left Sidebar (Search and Filters)
          Flexible(
            flex: 2, // Takes less space than the job listings
            child: _buildSidebar(),
          ),
          const SizedBox(width: 40), // Spacing between sidebar and job listings
          // Right Job Listings Area
          Flexible(
            flex: 5, // Takes more space
            child: _buildJobListingsArea(),
          ),
        ],
      ),
    );
  }

  /// Builds the left sidebar with search and filter options.
  Widget _buildSidebar() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterSectionTitle('Search by Job Title'),
          Obx(
            () => _buildSearchField(
              'Job Title, Company...',
              controller.searchQuery.value, // Bind to controller's search query
              (value) => controller.searchQuery.value =
                  value, // Update controller on change
            ),
          ),
          const SizedBox(height: 20),

          _buildFilterSectionTitle('Location'),
          Obx(
            () => _buildDropdownField(
              controller
                  .selectedLocation
                  .value, // Bind to controller's selected location
              [
                'Anywhere (Global)',
                'New York, USA',
                'Los Angeles, USA',
                'Ohio, USA',
                'Florida, USA',
                'Boston, USA',
                'Oregon, USA',
              ], // Example options
              (value) => controller.selectedLocation.value =
                  value!, // Update controller on change
            ),
          ),
          const SizedBox(height: 20),

          _buildFilterSectionTitle('Category'),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterOption(
                  'Commerce',
                  10,
                  controller.selectedCategories.contains('Commerce'),
                  (selected) {
                    controller.toggleCategory('Commerce', selected);
                  },
                ),
                _buildFilterOption(
                  'Finance & Operations',
                  10,
                  controller.selectedCategories.contains(
                    'Finance & Operations',
                  ),
                  (selected) {
                    controller.toggleCategory('Finance & Operations', selected);
                  },
                ),
                _buildFilterOption(
                  'Hotels & Tourism',
                  10,
                  controller.selectedCategories.contains('Hotels & Tourism'),
                  (selected) {
                    controller.toggleCategory('Hotels & Tourism', selected);
                  },
                ),
                _buildFilterOption(
                  'Financial Services',
                  10,
                  controller.selectedCategories.contains('Financial Services'),
                  (selected) {
                    controller.toggleCategory('Financial Services', selected);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _buildFilterSectionTitle('Job Type'),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCheckboxFilter(
                  'Full Time',
                  controller.selectedJobTypes.contains('Full Time'),
                  (selected) {
                    controller.toggleJobType('Full Time', selected);
                  },
                ),
                _buildCheckboxFilter(
                  'Part Time',
                  controller.selectedJobTypes.contains('Part Time'),
                  (selected) {
                    controller.toggleJobType('Part Time', selected);
                  },
                ),
                _buildCheckboxFilter(
                  'Contract',
                  controller.selectedJobTypes.contains('Contract'),
                  (selected) {
                    controller.toggleJobType('Contract', selected);
                  },
                ),
                _buildCheckboxFilter(
                  'Seasonal',
                  controller.selectedJobTypes.contains('Seasonal'),
                  (selected) {
                    controller.toggleJobType('Seasonal', selected);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _buildFilterSectionTitle('Experience Level'),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCheckboxFilter(
                  'Associate',
                  controller.selectedExperienceLevels.contains('Associate'),
                  (selected) {
                    controller.toggleExperienceLevel('Associate', selected);
                  },
                ),
                _buildCheckboxFilter(
                  'Mid-Senior',
                  controller.selectedExperienceLevels.contains('Mid-Senior'),
                  (selected) {
                    controller.toggleExperienceLevel('Mid-Senior', selected);
                  },
                ),
                _buildCheckboxFilter(
                  'Director',
                  controller.selectedExperienceLevels.contains('Director'),
                  (selected) {
                    controller.toggleExperienceLevel('Director', selected);
                  },
                ),
                _buildCheckboxFilter(
                  'Executive',
                  controller.selectedExperienceLevels.contains('Executive'),
                  (selected) {
                    controller.toggleExperienceLevel('Executive', selected);
                  },
                ),
                _buildCheckboxFilter(
                  'Fresh Graduate',
                  controller.selectedExperienceLevels.contains(
                    'Fresh Graduate',
                  ),
                  (selected) {
                    controller.toggleExperienceLevel(
                      'Fresh Graduate',
                      selected,
                    );
                  },
                ),
                _buildCheckboxFilter(
                  'Internship',
                  controller.selectedExperienceLevels.contains('Internship'),
                  (selected) {
                    controller.toggleExperienceLevel('Internship', selected);
                  },
                ),
                _buildCheckboxFilter(
                  'Entry Level',
                  controller.selectedExperienceLevels.contains('Entry Level'),
                  (selected) {
                    controller.toggleExperienceLevel('Entry Level', selected);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _buildFilterSectionTitle('Posted Time'),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCheckboxFilter(
                  'Any Time',
                  controller.selectedPostedTimes.contains('Any Time'),
                  (selected) {
                    controller.togglePostedTime('Any Time', selected);
                  },
                ),
                _buildCheckboxFilter(
                  'Last 24 Hours',
                  controller.selectedPostedTimes.contains('Last 24 Hours'),
                  (selected) {
                    controller.togglePostedTime('Last 24 Hours', selected);
                  },
                ),
                _buildCheckboxFilter(
                  'Last 3 Days',
                  controller.selectedPostedTimes.contains('Last 3 Days'),
                  (selected) {
                    controller.togglePostedTime('Last 3 Days', selected);
                  },
                ),
                _buildCheckboxFilter(
                  'Last 7 Days',
                  controller.selectedPostedTimes.contains('Last 7 Days'),
                  (selected) {
                    controller.togglePostedTime('Last 7 Days', selected);
                  },
                ),
                _buildCheckboxFilter(
                  'Last 14 Days',
                  controller.selectedPostedTimes.contains('Last 14 Days'),
                  (selected) {
                    controller.togglePostedTime('Last 14 Days', selected);
                  },
                ),
                _buildCheckboxFilter(
                  'Last 30 Days',
                  controller.selectedPostedTimes.contains('Last 30 Days'),
                  (selected) {
                    controller.togglePostedTime('Last 30 Days', selected);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _buildFilterSectionTitle('Salary'),
          Obx(
            () => _buildSalaryFilter(
              controller.salaryRange.value,
              (range) => controller.salaryRange.value = range,
            ),
          ),
          const SizedBox(height: 20),

          _buildFilterSectionTitle('Tags'),
          Obx(
            () => Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                _buildTagChip(
                  'Design',
                  controller.selectedTags.contains('Design'),
                  (selected) {
                    controller.toggleTag('Design', selected);
                  },
                ),
                _buildTagChip(
                  'Marketing',
                  controller.selectedTags.contains('Marketing'),
                  (selected) {
                    controller.toggleTag('Marketing', selected);
                  },
                ),
                _buildTagChip(
                  'Management',
                  controller.selectedTags.contains('Management'),
                  (selected) {
                    controller.toggleTag('Management', selected);
                  },
                ),
                _buildTagChip(
                  'Soft',
                  controller.selectedTags.contains('Soft'),
                  (selected) {
                    controller.toggleTag('Soft', selected);
                  },
                ),
                _buildTagChip('Art', controller.selectedTags.contains('Art'), (
                  selected,
                ) {
                  controller.toggleTag('Art', selected);
                }),
                _buildTagChip(
                  'Creative',
                  controller.selectedTags.contains('Creative'),
                  (selected) {
                    controller.toggleTag('Creative', selected);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // "WE ARE HIRING" image section
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[700], // Placeholder for the image
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'WE ARE HIRING',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Apply Today!',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 15),
                _buildElevatedButton('Apply', () {}), // Example button
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper for filter section titles.
  Widget _buildFilterSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Helper for search input field.
  Widget _buildSearchField(
    String hintText,
    String currentValue,
    ValueChanged<String> onChanged,
  ) {
    return TextField(
      controller: TextEditingController(text: currentValue)
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: currentValue.length),
        ),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: secondaryTextColor.withOpacity(0.7)),
        filled: true,
        fillColor: primaryColor.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.search, color: secondaryTextColor),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
      ),
      style: const TextStyle(color: textColor),
    );
  }

  /// Helper for dropdown fields.
  Widget _buildDropdownField(
    String currentValue,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: secondaryTextColor.withOpacity(0.3)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentValue,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: secondaryTextColor,
          ),
          dropdownColor: cardColor,
          onChanged: onChanged,
          items: options.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val, style: const TextStyle(color: textColor)),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Helper for filter options with count.
  Widget _buildFilterOption(
    String text,
    int count,
    bool isSelected,
    ValueChanged<bool?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(color: secondaryTextColor, fontSize: 16)),
          Row(
            children: [
              SizedBox(
                width: 24, // Standard checkbox size
                height: 24,
                child: Checkbox(
                  value: isSelected,
                  onChanged: onChanged,
                  activeColor: accentColor,
                  checkColor: primaryColor, // Color of the checkmark
                  materialTapTargetSize:
                      MaterialTapTargetSize.shrinkWrap, // Reduce extra space
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper for checkbox filters.
  Widget _buildCheckboxFilter(
    String text,
    bool isSelected,
    ValueChanged<bool?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          SizedBox(
            width: 24, // Standard checkbox size
            height: 24,
            child: Checkbox(
              value: isSelected,
              onChanged: onChanged,
              activeColor: accentColor,
              checkColor: primaryColor, // Color of the checkmark
              materialTapTargetSize:
                  MaterialTapTargetSize.shrinkWrap, // Reduce extra space
            ),
          ),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(color: secondaryTextColor, fontSize: 16)),
        ],
      ),
    );
  }

  /// Helper for salary filter with slider.
  Widget _buildSalaryFilter(
    RangeValues currentRange,
    ValueChanged<RangeValues> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Salary - \$${currentRange.start.toInt()} - \$${currentRange.end.toInt()}K',
          style: TextStyle(color: secondaryTextColor, fontSize: 16),
        ),
        SliderTheme(
          data: SliderTheme.of(Get.context!).copyWith(
            activeTrackColor: accentColor,
            inactiveTrackColor: secondaryTextColor.withOpacity(0.3),
            thumbColor: accentColor,
            overlayColor: accentColor.withOpacity(0.2),
            valueIndicatorColor: accentColor,
            showValueIndicator: ShowValueIndicator.always,
            trackHeight: 3.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
          ),
          child: RangeSlider(
            values: currentRange,
            min: 0,
            max: 100,
            divisions: 100,
            labels: RangeLabels(
              '\$${currentRange.start.toInt()}K',
              '\$${currentRange.end.toInt()}K',
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  /// Helper for filter tags.
  Widget _buildTagChip(
    String text,
    bool selected,
    ValueChanged<bool> onChanged,
  ) {
    return GestureDetector(
      onTap: () => onChanged(!selected),
      child: Chip(
        label: Text(
          text,
          style: TextStyle(
            color: selected ? chipTextColor : secondaryTextColor,
          ),
        ),
        backgroundColor: selected
            ? filterChipColor
            : cardColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: selected
                ? filterChipColor
                : secondaryTextColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
    );
  }

  /// Builds the right area with job listings.
  Widget _buildJobListingsArea() {
    return Obx(
      () => Column(
        // Wrap with Obx to react to filteredJobs changes
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Showing ${controller.filteredJobs.length} of ${controller.allJobs.length} results',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: cardColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: secondaryTextColor.withOpacity(0.3),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.sortOption.value, // Bind to controller
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: textColor,
                      ),
                      dropdownColor: cardColor,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.sortOption.value =
                              newValue; // Update controller
                        }
                      },
                      items:
                          <String>[
                            'Sort By Latest',
                            'Sort By Oldest',
                            'Sort By Salary',
                          ].map<DropdownMenuItem<String>>((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(
                                val,
                                style: const TextStyle(color: textColor),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Dynamically build job cards based on filteredJobs
          ...controller.filteredJobs
              .map(
                (job) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: _buildJobListingCard(job: job),
                ),
              )
              .toList(),
          if (controller.filteredJobs.isEmpty)
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                'No jobs found matching your criteria.',
                style: TextStyle(color: secondaryTextColor, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }

  /// Helper widget for creating a job listing card (adapted for this design).
  Widget _buildJobListingCard({required Job job}) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                job.postedTime,
                style: TextStyle(color: secondaryTextColor, fontSize: 14),
              ),
              Icon(Icons.bookmark_border, color: secondaryTextColor),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            job.title,
            style: const TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // Company Logo Placeholder (using initial from Job model)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color:
                      Colors.primaries[job.company.hashCode %
                          Colors
                              .primaries
                              .length], // Random color based on company hash
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    job.companyInitial ??
                        job.company.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  job.company,
                  style: TextStyle(color: secondaryTextColor, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: secondaryTextColor, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    job.location,
                    style: TextStyle(color: secondaryTextColor, fontSize: 14),
                  ),
                  const SizedBox(width: 15),
                  Icon(
                    Icons.schedule,
                    color: secondaryTextColor,
                    size: 16,
                  ), // Job type icon
                  const SizedBox(width: 5),
                  Text(
                    job.jobType,
                    style: TextStyle(color: secondaryTextColor, fontSize: 14),
                  ),
                ],
              ),
              Text(
                job.salary,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {
                print("job id :${job.id}");
                Get.toNamed(Routes.JOB_DETAIL, arguments: job.id);
                print("job id :${job.id}");
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: accentColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Job Details',
                style: TextStyle(color: accentColor, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the "Top Company" section.
  // Widget _buildTopCompanySection() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60),
  //     child: Column(
  //       children: [
  //         const Text(
  //           'Top Company',
  //           style: TextStyle(
  //             color: textColor,
  //             fontSize: 40,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         const SizedBox(height: 10),
  //         Text(
  //           'In sed adio, ipsum non sit met, olsit amet, oluptate quio et.',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(color: secondaryTextColor, fontSize: 16),
  //         ),
  //         const SizedBox(height: 40),
  //         GridView.count(
  //           crossAxisCount: 4, // 4 columns as per design
  //           shrinkWrap: true, // Takes minimum space
  //           physics: const NeverScrollableScrollPhysics(), // Disable scrolling
  //           crossAxisSpacing: 30, // Spacing between columns
  //           mainAxisSpacing: 30, // Spacing between rows
  //           children: [
  //             _buildCompanyCard('Bagre', 'B', '2 open jobs'),
  //             _buildCompanyCard('Tesla', 'T', '18 open jobs'),
  //             _buildCompanyCard('McDonald\'s', 'M', '12 open jobs'),
  //             _buildCompanyCard('Apple', 'A', '9 open jobs'),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Helper for building individual company cards in the "Top Company" section.
  Widget _buildCompanyCard(
    String companyName,
    String logoInitial,
    String jobCount,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(
                  0.5,
                ), // Placeholder color for logo background
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  logoInitial,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                companyName,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                jobCount,
                style: TextStyle(color: secondaryTextColor, fontSize: 14),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: accentColor, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
              ),
              child: Text(
                'View All',
                style: TextStyle(color: accentColor, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the footer section with a call-to-action and copyright/social links.
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(40.0),
      color: primaryColor, // Ensure footer background matches primary color
      child: Column(
        children: [
          // "Job" and "Looking for the right job?" text
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Job',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Looking for the right job? Chances\nare you\'ll find it at RekrutID',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40), // Spacing below initial text
          // Footer content organized in a Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Company',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildFooterLink('For Team'),
                    _buildFooterLink('For Individual'),
                    _buildFooterLink('For Freelance'),
                  ],
                ),
              ),
              // Job Categories column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Job Categories',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildFooterLink('Hotels & Tourisms'),
                    _buildFooterLink('Education'),
                    _buildFooterLink('Financial Services'),
                    _buildFooterLink('Commerce'),
                  ],
                ),
              ),
              // Renumeration column (Input field and Subscribe button)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Renumeration',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Your email address',
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                      ),
                      style: const TextStyle(color: textColor),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity, // Make button fill width
                      child: _buildElevatedButton('Subscribe Now', () {}),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 60),
          Divider(color: secondaryTextColor.withOpacity(0.3)), // Separator line
          const SizedBox(height: 20),
          // Copyright and social media icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© RekrutID 2023',
                style: TextStyle(color: secondaryTextColor, fontSize: 14),
              ),
              Row(
                children: [
                  _buildSocialIcon(Icons.facebook),
                  _buildSocialIcon(Icons.tiktok),
                  _buildSocialIcon(Icons.telegram),
                  _buildSocialIcon(Icons.discord),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20), // Spacing for Privacy/Terms links
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildFooterLink('Privacy Policy'),
              const SizedBox(width: 20),
              _buildFooterLink('Terms & Conditions'),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper widget for footer links.
  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero, // Remove default padding
          minimumSize: Size.zero, // Remove minimum size constraints
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Shrink tap target
        ),
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 14)),
      ),
    );
  }

  /// Helper widget for social media icons in the footer.
  Widget _buildSocialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}
