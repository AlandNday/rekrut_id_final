import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rekrut_id_final/Models/jobmodel.dart';
import 'package:rekrut_id_final/infrastructure/navigation/routes.dart';

import 'controllers/job_detail.controller.dart';

class JobDetailScreen extends GetView<JobDetailController> {
  const JobDetailScreen({super.key});

  // Define static color constants for consistency and easy modification.
  static const Color primaryColor = Color(0xFF4A148C); // Dark purple background
  static const Color accentColor = Color(
    0xFFE040FB,
  ); // Vibrant pink/light purple for accents
  static const Color textColor = Colors.black; // General text color
  static const Color secondaryTextColor = Color(
    0xFFB39DDB,
  ); // Lighter purple for subtle text/icons
  static const Color cardColor = Colors.white;
  // Slightly lighter purple for card backgrounds

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top navigation and branding
            _buildJobDetailsPageTitle(), // "Job Details" title
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: accentColor),
                );
              } else if (controller.jobDetail.value == null) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      'Job details not found.',
                      style: TextStyle(color: textColor, fontSize: 18),
                    ),
                  ),
                );
              } else {
                final jobDetail = controller.jobDetail.value!;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 20.0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Main Content Area (left)
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildJobTitleSection(jobDetail.job),
                            const SizedBox(height: 30),
                            _buildJobDescription(jobDetail.description),
                            const SizedBox(height: 30),
                            _buildSectionTitle('Key Responsibilities'),
                            _buildBulletList(jobDetail.keyResponsibilities),
                            const SizedBox(height: 30),
                            _buildSectionTitle('Professional Skills'),
                            _buildBulletList(jobDetail.professionalSkills),
                            const SizedBox(height: 30),
                            _buildSectionTitle('Tags'),
                            _buildTags(jobDetail.job.tags),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40), // Spacing
                      // Right Sidebar (Job Overview, Send Message)
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            _buildJobOverviewCard(jobDetail.job),
                            const SizedBox(height: 30),
                            _buildSendMessageCard(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
            const SizedBox(height: 60),
            Obx(() {
              if (controller.jobDetail.value != null &&
                  controller.jobDetail.value!.relatedJobs.isNotEmpty) {
                return _buildRelatedJobsSection(
                  controller.jobDetail.value!.relatedJobs,
                );
              }
              return const SizedBox.shrink(); // Hide if no related jobs
            }),
            const SizedBox(height: 60),
            _buildFooter(), // Footer
          ],
        ),
      ),
    );
  }

  /// Builds the top header bar with logo, navigation links, and action buttons.

  /// Helper widget for creating navigation text buttons.
  Widget _buildNavLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextButton(
        onPressed: () {
          // Implement navigation logic here (e.g., Get.toNamed('/home'))
        },
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

  /// Helper widget for creating a standard text button.
  Widget _buildTextButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
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

  /// Builds the "Job Details" page title section.
  Widget _buildJobDetailsPageTitle() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 60),
        alignment: Alignment.center,
        child: const Text(
          'Job Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Builds the main job title and company section.
  Widget _buildJobTitleSection(Job job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          job.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors
                    .primaries[job.company.hashCode % Colors.primaries.length],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  job.companyInitial ??
                      job.company.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                job.company,
                style: TextStyle(color: secondaryTextColor, fontSize: 20),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ],
    );
  }

  /// Builds the job description section.
  Widget _buildJobDescription(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Job Description'),
        const SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  /// Helper for building section titles.
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Helper for building bullet point lists.
  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.circle, color: secondaryTextColor, size: 8),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(color: secondaryTextColor, fontSize: 16),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Helper for displaying tags.
  Widget _buildTags(List<String> tags) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: tags
          .map(
            (tag) => Chip(
              label: Text(tag, style: const TextStyle(color: textColor)),
              backgroundColor: cardColor.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
          )
          .toList(),
    );
  }

  /// Builds the "Job Overview" card in the right sidebar.
  Widget _buildJobOverviewCard(Job job) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Job Overview',
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildOverviewRow(Icons.business, 'Company', job.company),
          _buildOverviewRow(Icons.category, 'Category', job.category),
          _buildOverviewRow(
            Icons.work,
            'Job Type',
            job.jobType,
            showDot: job.jobType == 'Permanent',
          ),
          _buildOverviewRow(
            Icons.leaderboard,
            'Experience',
            job.experienceLevel,
          ),
          _buildOverviewRow(Icons.attach_money, 'Offer Salary', job.salary),
          _buildOverviewRow(Icons.location_on, 'Location', job.location),
          const SizedBox(height: 20),
          // Placeholder for map image
        ],
      ),
    );
  }

  /// Helper for building rows in the Job Overview card.
  Widget _buildOverviewRow(
    IconData icon,
    String title,
    String value, {
    bool showDot = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: secondaryTextColor, size: 20),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: secondaryTextColor, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  if (showDot)
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  Text(
                    value,
                    style: const TextStyle(color: textColor, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the "Send Us Message" card.
  Widget _buildSendMessageCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Send Us Message',
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildMessageInputField('Full Name'),
          const SizedBox(height: 15),
          _buildMessageInputField('Email Address'),
          const SizedBox(height: 15),
          _buildMessageInputField('Phone Number'),
          const SizedBox(height: 15),
          _buildMessageInputField('Your Message', maxLines: 5),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: _buildElevatedButton('Send Message', () {}),
          ),
        ],
      ),
    );
  }

  /// Helper for message input fields.
  Widget _buildMessageInputField(String hintText, {int maxLines = 1}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: primaryColor.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
      ),
      style: const TextStyle(color: textColor),
      maxLines: maxLines,
    );
  }

  /// Builds the "Related Jobs" section.
  Widget _buildRelatedJobsSection(List<Job> relatedJobs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          child: _buildSectionTitle('Related Jobs'),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 300, // Fixed height to allow horizontal scrolling
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: relatedJobs.length,
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: _buildRelatedJobCard(job: relatedJobs[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Helper widget for creating a related job listing card (similar to main job card).
  Widget _buildRelatedJobCard({required Job job}) {
    return Container(
      width: 500, // Fixed width for related job cards
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
                          Colors.primaries.length],
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
                controller.currentJobId.value = job.id;
                controller.fetchJobDetail(job.id);
                controller.saveidtostorage(job.id);
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
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Looking for the right job? Chances\nare you\'ll find it at RekrutID',
                  style: TextStyle(color: secondaryTextColor, fontSize: 16),
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
                        color: textColor,
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
                        hintStyle: TextStyle(
                          color: secondaryTextColor.withOpacity(0.7),
                        ),
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
      child: Icon(icon, color: secondaryTextColor, size: 24),
    );
  }
}
