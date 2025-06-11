import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/aboutus.controller.dart';

class AboutusScreen extends GetView<AboutusController> {
  const AboutusScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const Text(
          'About Us',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // --- Header Section ---
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Innovation & Excellence: Our Journey',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'We are a passionate team dedicated to delivering cutting-edge solutions and exceptional experiences for our clients worldwide.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // --- Hero Image Section ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://placehold.co/600x300/4CAF50/FFFFFF?text=Our+Team+Working',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Text('Failed to load image')),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // --- Why Choose Us Section ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Why Choose Us?',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 24),
                  _buildFeatureCard(
                    context,
                    Icons.star,
                    'Commitment to Quality',
                    'We ensure every product and service meets the highest standards of excellence.',
                  ),
                  const SizedBox(height: 20),
                  _buildFeatureCard(
                    context,
                    Icons.handshake,
                    'Client-Centric Approach',
                    'Your success is our priority. We partner with you to achieve your goals.',
                  ),
                  const SizedBox(height: 20),
                  _buildFeatureCard(
                    context,
                    Icons.lightbulb_outline,
                    'Innovative Solutions',
                    'Constantly exploring new technologies to bring you the best and most effective solutions.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // --- Video Section ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'See Our Story in Action',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  IconButton(
                    icon: Icon(
                      Icons.play_circle_fill,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 70,
                    ),
                    onPressed: () {
                      // Handle video play action
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Watch our introductory video to learn more about our values and what drives us forward.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // --- Our Values Section ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Core Values',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(height: 24),
                  _buildValueItem(
                    context,
                    'Integrity',
                    'Operating with honesty, transparency, and strong moral principles in all our dealings.',
                  ),
                  const SizedBox(height: 20),
                  _buildValueItem(
                    context,
                    'Collaboration',
                    'Fostering teamwork and mutual respect to achieve shared goals and greater impact.',
                  ),
                  const SizedBox(height: 20),
                  _buildValueItem(
                    context,
                    'Adaptability',
                    'Embracing change and continuously evolving to meet the dynamic needs of the market.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),

            // --- Footer Section (reused from Contact Us for consistency) ---
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 40.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Committed to building a better future through technology and strong partnerships.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  _buildFooterSection(context, 'Company', [
                    'About Us',
                    'Services',
                    'Our Team',
                    'Blog',
                  ]),
                  const SizedBox(height: 24),
                  _buildFooterSection(context, 'Job Opportunities', [
                    'Careers',
                    'Internships',
                    'Open Positions',
                  ]),
                  const SizedBox(height: 32),
                  Text(
                    'Stay Updated!',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Enter your email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          // Handle subscribe logic
                        },
                        child: const Text('Subscribe'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Divider(color: Colors.white30),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '© 2025 Your Company. All rights reserved.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Privacy Policy',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: Colors.white70),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Terms & Conditions',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build feature cards (for 'Why Choose Us')
  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.secondary, size: 40),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  // Helper widget to build value items
  Widget _buildValueItem(
    BuildContext context,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  // Helper widget to build footer sections (Company, Job Opportunities)
  Widget _buildFooterSection(
    BuildContext context,
    String title,
    List<String> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(item, style: Theme.of(context).textTheme.bodyMedium),
            );
          }).toList(),
        ),
      ],
    );
  }
}
