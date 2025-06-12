import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rekrut_id_final/Models/jobmodel.dart';
import 'package:rekrut_id_final/infrastructure/navigation/routes.dart';
import 'package:rekrut_id_final/presentation/Jobboard/controllers/jobboard.controller.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  static const Color primaryColor = Color(0xFF4A148C); // Dark purple background
  static const Color accentColor = Color(0xFFE040FB);
  static const Color textColor = Colors.white;
  static const Color secondaryTextColor = Color(0xFFB39DDB);
  static const Color cardColor = Color(0xFF6A1B9A);

  @override
  Widget build(BuildContext context) {
    // Inject JobboardController here so it's available for this screen
    final JobboardController jobboardController =
        Get.find<JobboardController>();

    // Scaffold provides the basic visual structure for the material design app.
    return Scaffold(
      backgroundColor: primaryColor, // Set the main background color
      body: SingleChildScrollView(
        // SingleChildScrollView allows the content to be scrollable if it overflows,
        // which is good for ensuring content is always visible on different screen sizes.
        child: Column(
          children: [
            _buildHeader(), // Top navigation and branding
            _buildHeroSection(), // Large introductory section with title and buttons
            Padding(
              padding: const EdgeInsets.only(left: 140, right: 100),
              child: _buildJobCategorySection(
                jobboardController,
              ), // Pass the controller
            ), // Section for job categories/types
            _buildCompanyLogosSection(), // Section showcasing partner companies
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align content to the top
              children: [
                Expanded(child: _buildWorkEnvironmentSection()),
                Expanded(child: _buildAcademySection()),
              ],
            ), // Section about work environment benefits
            // Section for the academy/knowledge sharing
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
          // Branding Logo
          Transform.rotate(
            angle: 270,
            child: const Text(
              'R',
              style: TextStyle(
                color: Colors.white,
                fontSize: 80,
                fontWeight: FontWeight.w700,
              ),
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
                  _buildNavLink('Home', 'HOME'),
                  _buildNavLink('Jobs', 'JOBBOARD'),
                  _buildNavLink(
                    'Contact us',
                    'CONTACTUS',
                  ), // Added route for Contact Us
                ],
              ),
            ),
          ),

          // Register/Login buttons
          Row(
            children: [
              _buildTextButton('Register', () {}),
              const SizedBox(width: 10),
              _buildElevatedButton('Login', Colors.white, () {}),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper widget for creating navigation text buttons.
  Widget _buildNavLink(String text, String Route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextButton(
        onPressed: () {
          switch (Route) {
            // Changed to use Route parameter
            case 'JOBBOARD':
              Get.toNamed(Routes.JOBBOARD);
              break;
            case 'ABOUTUS':
              Get.toNamed(Routes.ABOUTUS);
              break;
            case 'CONTACTUS':
              Get.toNamed(Routes.CONTACTUS);
              break;
            case 'HOME':
              Get.toNamed(
                Routes.HOME,
              ); // Assuming you want to navigate to home itself
              break;
            default:
              break;
          }
        },
        child: Text(
          text,
          style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 16),
        ),
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
    Color color,
    VoidCallback onPressed, {
    IconData? icon,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Button background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ), // Rounded corners
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Make the row take minimum space
        children: [
          if (icon != null)
            Icon(icon, color: Colors.black, size: 18), // Optional icon
          if (icon != null)
            const SizedBox(width: 8), // Spacing between icon and text
          Text(text, style: TextStyle(color: Colors.black, fontSize: 16)),
        ],
      ),
    );
  }

  /// Builds the main hero section with the large headline and call-to-action buttons.
  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.only(left: 150, top: 100, bottom: 40),
      alignment: Alignment.centerLeft, // Align content to the left
      // minHeight ensures the section has a minimum height, adjusting dynamically
      constraints: BoxConstraints(minHeight: Get.height * 0.4),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align text to the start (left)
        children: [
          // Main headlines
          const Text(
            'Looking for the right job?',
            style: TextStyle(
              color: textColor,
              fontSize: 60,
              fontWeight: FontWeight.bold,
              height: 1.2, // Line height for better readability
            ),
          ),
          const SizedBox(height: 10), // Spacing between lines
          const Text(
            'Chances are you\'ll find it\nat RekrutID',
            style: TextStyle(
              color: textColor,
              fontSize: 60,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 30), // Spacing before buttons
          // Action buttons
          Row(
            children: [
              _buildElevatedButton('Start', Colors.white, () {
                Get.toNamed(Routes.JOBBOARD);
              }, icon: Icons.arrow_outward), // Elevated button with icon
              const SizedBox(width: 20), // Spacing between buttons
              // OutlinedButton removed as per original comment
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the section displaying job categories (Asama, Figma, Development) and job listings.
  Widget _buildJobCategorySection(JobboardController jobboardController) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align children to the top
      children: [
        Column(
          children: [
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryCard(
                  title: 'Asama',
                  image:
                      'https://res.cloudinary.com/dh1btqzox/image/upload/v1749698297/asana_ogdm1i.png',
                  description:
                      'managing all your work, planning, tasks, team coordination and projects using Asama.',
                  icon: Icons
                      .design_services, // Placeholder icon, replace with actual design
                  iconColor: Colors.orange,
                  buttonText: 'Let us about your needs',
                ),
                const SizedBox(width: 30), // Spacing between cards
                // Figma Category Card
                _buildCategoryCard(
                  title: 'Figma',
                  image:
                      'https://res.cloudinary.com/dh1btqzox/image/upload/v1749698304/figma_ofc9q9.png',
                  description:
                      'integrating all the design and workflow elements into a simple layout in Figma',
                  icon: Icons.brush, // Placeholder icon
                  iconColor: Colors.pink,
                  buttonText: 'Tell us about your needs',
                ),
              ],
            ),
            _buildCategoryCard(
              // This card is centered in the original code, hence not in a Row
              title: 'Development',
              image:
                  'https://res.cloudinary.com/dh1btqzox/image/upload/v1749698301/code_aj0j2t.png',
              description: 'To develop sites and applications ',
              icon: Icons
                  .design_services, // Placeholder icon, replace with actual design
              iconColor: Colors.orange,
              buttonText: 'Let us about your needs',
            ),
            const SizedBox(height: 40), // Spacing after category cards
            _buildElevatedButton(
              'Tell us about your skills',
              accentColor,
              () {},
            ),
            const SizedBox(height: 40),
          ],
        ),
        const SizedBox(
          width: 100,
        ), // Adjusted spacing between category cards and job listings
        // Job Listing Cards Column
        Expanded(
          // Use Expanded to allow job listings to take available space
          child: Obx(() {
            // Use Obx to react to changes in filteredJobs
            final List<Job> recentJobs = jobboardController.filteredJobs
                .take(2)
                .toList();
            if (recentJobs.isEmpty) {
              return const Center(
                child: Text(
                  'No recent jobs available.',
                  style: TextStyle(color: textColor, fontSize: 18),
                ),
              );
            }
            return Column(
              children: [
                const SizedBox(height: 60), // Align with category cards
                ...recentJobs.map(
                  (job) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: 30.0,
                    ), // Spacing between job listings
                    child: _buildJobListingCard(
                      jobID: job.id,
                      jobTitle: job.title,
                      company: job.company,
                      location: job.location,
                      salary: job.salary,
                      logoColor: Colors
                          .blueAccent, // You might want to map company to a specific color or use an actual logo
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  /// Helper widget for creating a job category card.
  Widget _buildCategoryCard({
    required String title,
    required String description,
    required IconData icon,
    required String image,
    required Color iconColor,
    required String buttonText,
  }) {
    return Container(
      padding: const EdgeInsets.all(0),
      width: 300,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon with background
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(image)),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(color: secondaryTextColor, fontSize: 16),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// Helper widget for creating a job listing card.
  Widget _buildJobListingCard({
    required String jobID,
    required String jobTitle,
    required String company,
    required String location,
    required String salary,
    required Color logoColor, // Placeholder for company logo's dominant color
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 599,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Placeholder for company logo
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: logoColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      company[0], // Display first letter of company name as logo
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobTitle,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        company,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.bookmark_border,
                  color: Colors.black,
                ), // Bookmark icon
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Location info
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.black,
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      location,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
                // Salary info
                Text(
                  salary,
                  style: const TextStyle(
                    color: Colors
                        .black, // Changed to black for visibility on white card
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildElevatedButton('Apply Now', accentColor, () {
              Get.toNamed(Routes.JOB_DETAIL, arguments: jobID);
            }), // Apply button
          ],
        ),
      ),
    );
  }

  /// Builds the section displaying partner company logos.
  Widget _buildCompanyLogosSection() {
    // List of company names to display as placeholders for logos.
    return Container(
      color: const Color.fromARGB(62, 24, 177, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60),
        child: Column(
          children: [
            // Action buttons below the logos
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Image.network(
                    'https://res.cloudinary.com/dh1btqzox/image/upload/v1749698277/62beb4986f50ddd864c0a59e_forme-wrap.svg_nyq8te.png',
                  ),
                ),
                const SizedBox(width: 300),
                Column(
                  children: [
                    Image.network(
                      'https://res.cloudinary.com/dh1btqzox/image/upload/v1749698536/div_2_cnelet.png',
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        _buildElevatedButton('want work?', Colors.white, () {
                          Get.toNamed(Routes.JOBBOARD);
                        }, icon: Icons.arrow_outward),
                        const SizedBox(width: 20),
                        OutlinedButton(
                          onPressed: () {
                            Get.toNamed(Routes.CONTACTUS);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: accentColor,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'Talk with us',

                            style: TextStyle(color: accentColor, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper widget for creating a placeholder for a company logo.
  Widget _buildCompanyLogoPlaceholder(String name) {
    return Container(
      width: 120,
      height: 60,
      decoration: BoxDecoration(
        color: cardColor.withOpacity(
          0.5,
        ), // Semi-transparent card color for placeholder
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          name.toUpperCase(), // Display company name as placeholder text
          textAlign: TextAlign.center,
          style: TextStyle(
            color: secondaryTextColor.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  /// Builds the "It's also about creating the best work environment" section with image and text.
  Widget _buildWorkEnvironmentSection() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: AspectRatio(
        aspectRatio: 16 / 9, // Adjust as needed for desired image aspect ratio
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://res.cloudinary.com/dh1btqzox/image/upload/v1749698291/b0bac2dfc523ad081176ec591dda8634f7572dbe_tpcqm4.png',
                  fit: BoxFit.cover, // Ensures the image fills the space
                ),
              ),
            ),
            // Text and Button Overlay
            Padding(
              padding: const EdgeInsets.all(
                30.0,
              ), // Padding for the content over the image
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center content vertically
                children: [
                  const Text(
                    'It\'s also about creating the\nbest work environment.',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildElevatedButton('About Us', Colors.white, () {
                    Get.toNamed(Routes.ABOUTUS); // Navigate to About Us route
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the "/academy" section with text and an image.
  Widget _buildAcademySection() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: AspectRatio(
        aspectRatio: 16 / 9, // Adjust as needed for desired image aspect ratio
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://res.cloudinary.com/dh1btqzox/image/upload/v1749698293/academy_qfdgpe.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),

                  // Placeholder for the image. Replace with Image.asset or NetworkImage. Placeholder color
                ),
              ),
            ),
            // Text and Button Overlay
            Padding(
              padding: const EdgeInsets.all(
                30.0,
              ), // Padding for the content over the image
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center content vertically
                children: [
                  const Text(
                    '/academy',
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Sharing knowledge and\ngrowing as a community',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildElevatedButton('Open Courses', Colors.white, () {}),
                ],
              ),
            ),
          ],
        ),
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
          const Text(
            'Your Life will\nnever be the same',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 40),
          // Buttons in the footer
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildElevatedButton(
                'Download App',
                Colors.white,
                () {},
                icon: Icons.download,
              ),
              const SizedBox(width: 20),
              OutlinedButton(
                onPressed: () {},
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
                  'Get in touch',
                  style: TextStyle(color: accentColor, fontSize: 16),
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
        ],
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
