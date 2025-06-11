import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rekrut_id_final/infrastructure/navigation/routes.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  // Define static color constants for consistency and easy modification.
  static const Color primaryColor = Color(0xFF4A148C); // Dark purple background
  static const Color accentColor = Color(
    0xFFE040FB,
  ); // Vibrant pink/light purple for accents
  static const Color textColor = Colors.white; // General text color
  static const Color secondaryTextColor = Color(
    0xFFB39DDB,
  ); // Lighter purple for subtle text/icons
  static const Color cardColor = Color(
    0xFF6A1B9A,
  ); // Slightly lighter purple for card backgrounds

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
            _buildHeroSection(), // Large introductory section with title and buttons
            _buildJobCategorySection(), // Section for job categories/types
            _buildCompanyLogosSection(), // Section showcasing partner companies
            _buildWorkEnvironmentSection(), // Section about work environment benefits
            _buildAcademySection(), // Section for the academy/knowledge sharing
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
          const Text(
            'R',
            style: TextStyle(
              color: accentColor,
              fontSize: 30,
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
                  _buildNavLink('Home', 'HOME'),
                  _buildNavLink('Company', ''),
                  _buildNavLink('Jobs and vacancies', 'JOBBOARD'),
                  _buildNavLink('Contact', ''),
                  _buildNavLink('About Us', ''),
                ],
              ),
            ),
          ),

          // Register/Login buttons
          Row(
            children: [
              _buildTextButton('Register', () {}),
              const SizedBox(width: 10),
              _buildElevatedButton('Login', () {}),
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
          switch (text) {
            case 'Jobs and vacancies':
              Get.toNamed(Routes.JOBBOARD);
              break; // Don't forget 'break' to exit the switch
            case 'About Us':
              Get.toNamed(Routes.ABOUTUS);
              break; // Don't forget 'break' to exit the switch
            case 'Contact':
              Get.toNamed(Routes.CONTACTUS);
              break; // Don't forget 'break' to exit the switch
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

  /// Builds the main hero section with the large headline and call-to-action buttons.
  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.all(40.0),
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
              _buildElevatedButton(
                'Start',
                () {},
                icon: Icons.arrow_outward,
              ), // Elevated button with icon
              const SizedBox(width: 20), // Spacing between buttons
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: accentColor,
                    width: 2,
                  ), // Border color and width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'About Us',
                  style: TextStyle(color: accentColor, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the section displaying job categories (Asama, Figma) and job listings.
  Widget _buildJobCategorySection() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the top
        children: [
          // Asama Category Card
          Expanded(
            child: _buildCategoryCard(
              title: 'Asama',
              description:
                  'For managing all your work, planning, tasks, team coordination and projects, Asama is essential.',
              icon: Icons
                  .design_services, // Placeholder icon, replace with actual design
              iconColor: Colors.orange,
              buttonText: 'Let us about your needs',
            ),
          ),
          const SizedBox(width: 30), // Spacing between cards
          // Figma Category Card
          Expanded(
            child: _buildCategoryCard(
              title: 'Figma',
              description:
                  'By integrating all the design and workflow elements into a simple layout Figma is the best way to work.',
              icon: Icons.brush, // Placeholder icon
              iconColor: Colors.pink,
              buttonText: 'Tell us about your needs',
            ),
          ),
          const SizedBox(width: 30), // Spacing between cards
          // Job Listing Cards Column
          Expanded(
            child: Column(
              children: [
                _buildJobListingCard(
                  jobTitle: 'Regional Creative Facilitator',
                  company: 'Asama - RekrutID Co',
                  location: 'New York, USA',
                  salary: '\$20000-\$32000',
                  logoColor:
                      Colors.yellow, // Placeholder color for company logo
                ),
                const SizedBox(height: 30), // Spacing between job listings
                _buildJobListingCard(
                  jobTitle: 'Forward Security Director',
                  company: 'Hotels & Tourims',
                  location: 'New York, USA',
                  salary: '\$40000-\$42000',
                  logoColor:
                      Colors.redAccent, // Placeholder color for company logo
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget for creating a job category card.
  Widget _buildCategoryCard({
    required String title,
    required String description,
    required IconData icon,
    required Color iconColor,
    required String buttonText,
  }) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon with background
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2), // Light background for icon
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, size: 30, color: iconColor),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
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
    required String jobTitle,
    required String company,
    required String location,
    required String salary,
    required Color logoColor, // Placeholder for company logo's dominant color
  }) {
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
            children: [
              // Placeholder for company logo
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color:
                      logoColor, // Use provided color as a placeholder background
                  borderRadius: BorderRadius.circular(10),
                ),
                // In a real app, this would be an Image.asset or NetworkImage
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jobTitle,
                      style: const TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      company,
                      style: TextStyle(color: secondaryTextColor, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.bookmark_border,
                color: secondaryTextColor,
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
                  Icon(Icons.location_on, color: secondaryTextColor, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    location,
                    style: TextStyle(color: secondaryTextColor, fontSize: 14),
                  ),
                ],
              ),
              // Salary info
              Text(
                salary,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildElevatedButton('Apply Now', () {}), // Apply button
        ],
      ),
    );
  }

  /// Builds the section displaying partner company logos.
  Widget _buildCompanyLogosSection() {
    // List of company names to display as placeholders for logos.
    final List<String> companies = [
      'Triple Whale',
      'Handcash',
      'AscendEX',
      'TROVE MATE',
      'Vera',
      'flywallet',
      'SOCLLY',
      'Rycrypto',
      'dorphin',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // This is the large 'Y' like shape on the left.
              // In a real application, this would likely be an SVG asset or a custom painter
              // to replicate the exact complex shape from the design.
              Container(
                width: 100, // Approximate width
                height: 200, // Approximate height
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(
                    0.3,
                  ), // Faded accent color as background
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                child: Center(
                  child: Text(
                    'Shape Placeholder', // Text as a temporary representation
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 40), // Spacing between shape and logos
              // Company logos displayed using a Wrap widget for flexible layout.
              Expanded(
                child: Wrap(
                  spacing: 40.0, // Horizontal spacing between logos
                  runSpacing: 40.0, // Vertical spacing between rows of logos
                  alignment:
                      WrapAlignment.center, // Center align logos in the wrap
                  children: companies
                      .map((name) => _buildCompanyLogoPlaceholder(name))
                      .toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50), // Spacing before buttons
          // Action buttons below the logos
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildElevatedButton(
                'What work?',
                () {},
                icon: Icons.arrow_outward,
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
                  'Talk with us',
                  style: TextStyle(color: accentColor, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 400, // Fixed height for image placeholder
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // This `color` acts as a placeholder for the image.
                // In a real app, replace this with `DecorationImage`
                // using `Image.asset('assets/images/your_image.png')`
                color: secondaryTextColor.withOpacity(0.3),
              ),
              child: const Center(
                child: Text(
                  'Image Placeholder 1',
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
          ),
          const SizedBox(width: 40), // Spacing between image and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                _buildElevatedButton('About Us', () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the "/academy" section with text and an image.
  Widget _buildAcademySection() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                _buildElevatedButton('Open Courses', () {}),
              ],
            ),
          ),
          const SizedBox(width: 40), // Spacing between text and image
          Expanded(
            child: Container(
              height: 400, // Fixed height for image placeholder
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // This `color` acts as a placeholder for the image.
                // In a real app, replace this with `DecorationImage`
                // using `Image.asset('assets/images/your_image_2.png')`
                color: secondaryTextColor.withOpacity(0.3),
              ),
              child: const Center(
                child: Text(
                  'Image Placeholder 2',
                  style: TextStyle(color: textColor),
                ),
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
              _buildElevatedButton('Download App', () {}, icon: Icons.download),
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
