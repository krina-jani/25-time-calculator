import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  Future<void> _launchUrl(BuildContext context, String urlString) async {
    final Uri uri = Uri.parse(urlString);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open $urlString')),
          );
        }
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $urlString')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Color(0xFF0F172A)),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x29000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.shield_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 14),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Emperor Smart Solutions',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFE2E8F0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 12,
                            runSpacing: 6,
                            children: [
                              Text(
                                'Effective Date: September 21, 2026',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Last Updated: September 21, 2026',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Intro card
                  _buildTextCard(
                    text:
                        'Emperor Smart Solutions ("we", "us", "our", or "Company") develops and publishes mobile applications, including utility and productivity applications available through Google Play and other supported platforms.\n\n'
                        'This Privacy Policy explains how we handle information in our mobile applications.\n\n'
                        'This Privacy Policy is intended to apply to our applications that link to this policy, including our utility applications such as calculators, converters, productivity tools, document utilities, and similar applications.\n\n'
                        'By using one of our applications, you acknowledge the practices described in this Privacy Policy.',
                  ),
                  const SizedBox(height: 14),

                  // 1. Information We Collect
                  _buildSectionCard(
                    title: '1. Information We Collect',
                    content:
                        'The information handled by an application depends on the features and services used in that particular application.\n\n'
                        'Information You Provide:\n'
                        'Our basic utility applications generally do not require users to create an account, provide their name, email address, phone number, or other personal information. If a particular application provides a feature that requires information to be entered or selected by the user, that information is used only for the functionality provided by that application.\n\n'
                        'Information Processed Locally:\n'
                        'Many of our utility applications perform their primary functions directly on the user\'s device. For example, calculations, text counting, conversions, and similar utility functions may be performed locally without sending the entered information to our servers. Where an application processes files, images, documents, or text locally, such content may remain on the user\'s device unless the application specifically explains that a feature requires transmission to another service.',
                    icon: Icons.info_outline,
                    accentColor: const Color(0xFF2563EB),
                  ),
                  const SizedBox(height: 14),

                  // 2. Advertising and Third-Party Services
                  _buildSectionCard(
                    title: '2. Advertising and Third-Party Services',
                    content:
                        'Some of our applications may display advertisements provided by third-party advertising services, such as Google AdMob.\n\n'
                        'Third-party advertising providers may collect or process certain information from the device, such as advertising identifiers, device information, approximate location information, diagnostic information, or information relating to advertising and app interactions, depending on the services and configuration used by the particular application.\n\n'
                        'Such information may be used for purposes including:\n'
                        '• Providing and displaying advertisements\n'
                        '• Measuring advertising performance\n'
                        '• Preventing fraud and abuse\n'
                        '• Improving advertising services\n'
                        '• Providing personalized or non-personalized advertising, where applicable\n\n'
                        'The data practices of third-party services are governed by their respective privacy policies and applicable settings. We recommend that users review the privacy information provided by the relevant third-party service.',
                    icon: Icons.ads_click,
                    accentColor: const Color(0xFF7C3AED),
                  ),
                  const SizedBox(height: 14),

                  // 3. Analytics and Other Third-Party Services
                  _buildSectionCard(
                    title: '3. Analytics and Other Third-Party Services',
                    content:
                        'Some applications may use third-party services for purposes such as:\n'
                        '• Application performance monitoring\n'
                        '• Crash reporting\n'
                        '• Usage analytics\n'
                        '• Security\n'
                        '• Advertising\n'
                        '• Improving application functionality\n\n'
                        'The particular third-party services used may vary between applications. Where third-party SDKs collect or share information, the applicable data practices will be reflected in the relevant application\'s Google Play Data Safety information.',
                    icon: Icons.analytics_outlined,
                    accentColor: const Color(0xFF0D9488),
                  ),
                  const SizedBox(height: 14),

                  // 4. How We Use Information
                  _buildSectionCard(
                    title: '4. How We Use Information',
                    content:
                        'Depending on the particular application and its features, information may be used to:\n'
                        '• Provide and operate application features\n'
                        '• Process calculations, conversions, documents, text, or other user requests\n'
                        '• Improve application functionality\n'
                        '• Detect and resolve technical problems\n'
                        '• Monitor application performance\n'
                        '• Prevent fraud, abuse, or security issues\n'
                        '• Display and measure advertisements\n'
                        '• Comply with applicable legal obligations\n\n'
                        'We do not use information for purposes that are materially different from those described in this Privacy Policy without providing appropriate disclosure where required.',
                    icon: Icons.settings_suggest_outlined,
                    accentColor: const Color(0xFFEA580C),
                  ),
                  const SizedBox(height: 14),

                  // 5. Data Sharing
                  _buildSectionCard(
                    title: '5. Data Sharing',
                    content:
                        'We do not sell users\' personal information as part of the normal operation of our basic utility applications.\n\n'
                        'Information may be processed or shared with service providers when necessary to operate specific application features or third-party services. For example, advertising, analytics, crash-reporting, hosting, security, or other technology providers may process information according to their own terms and privacy policies.\n\n'
                        'The specific data practices of each application depend on the features and third-party services included in that application.',
                    icon: Icons.share_outlined,
                    accentColor: const Color(0xFF0284C7),
                  ),
                  const SizedBox(height: 14),

                  // 6. Data Security
                  _buildSectionCard(
                    title: '6. Data Security',
                    content:
                        'We take reasonable measures appropriate to the nature of the information and services involved to protect information against unauthorized access, alteration, disclosure, or destruction.\n\n'
                        'However, no method of electronic storage or transmission over the internet can be guaranteed to be completely secure.',
                    icon: Icons.lock_outline,
                    accentColor: const Color(0xFF16A34A),
                  ),
                  const SizedBox(height: 14),

                  // 7. Data Retention and Deletion
                  _buildSectionCard(
                    title: '7. Data Retention and Deletion',
                    content:
                        'For utility applications that process information locally on the device, we generally do not receive or retain that locally processed information on our servers.\n\n'
                        'Information handled by third-party services may be retained according to the respective service provider\'s policies and applicable legal requirements.\n\n'
                        'If a particular application provides an account, cloud storage, or another feature involving server-side data, that application may have additional data retention and deletion practices applicable to that feature. Where applicable, users may contact us using the contact information below to ask questions about personal information handled by us.',
                    icon: Icons.auto_delete_outlined,
                    accentColor: const Color(0xFFDC2626),
                  ),
                  const SizedBox(height: 14),

                  // 8. Children's Privacy
                  _buildSectionCard(
                    title: '8. Children\'s Privacy',
                    content:
                        'Our applications are not intended to knowingly collect personal information from children in violation of applicable laws.\n\n'
                        'If an application is specifically intended for children or directed toward children, additional privacy and data-handling requirements may apply to that application.\n\n'
                        'Parents or guardians who believe that a child has provided personal information to us may contact us using the contact information provided below.',
                    icon: Icons.child_care_outlined,
                    accentColor: const Color(0xFFDB2777),
                  ),
                  const SizedBox(height: 14),

                  // 9. Permissions
                  _buildSectionCard(
                    title: '9. Permissions',
                    content:
                        'Some applications may request Android permissions when a particular feature requires them. Permissions are requested only when necessary for the relevant functionality.\n\n'
                        'The permissions requested by an application may vary depending on its features. Users can manage applicable permissions through Android device settings.',
                    icon: Icons.security_outlined,
                    accentColor: const Color(0xFF4F46E5),
                  ),
                  const SizedBox(height: 14),

                  // 10. External Links
                  _buildSectionCard(
                    title: '10. External Links',
                    content:
                        'Our applications or privacy pages may contain links to external websites or social media platforms. These external services are operated independently from Emperor Smart Solutions and have their own privacy policies and terms.\n\n'
                        'We are not responsible for the privacy practices of external websites or services.',
                    icon: Icons.open_in_new_outlined,
                    accentColor: const Color(0xFF059669),
                  ),
                  const SizedBox(height: 14),

                  // 11. Changes to This Privacy Policy
                  _buildSectionCard(
                    title: '11. Changes to This Privacy Policy',
                    content:
                        'We may update this Privacy Policy from time to time to reflect changes in our applications, services, legal requirements, or privacy practices.\n\n'
                        'When we make changes, we will update the Last Updated date shown at the top of this page. Users are encouraged to periodically review this Privacy Policy.',
                    icon: Icons.update_outlined,
                    accentColor: const Color(0xFFD97706),
                  ),
                  const SizedBox(height: 14),

                  // 12 & 13. Contact Us & Social Profiles Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFCBD5E1), width: 1.2),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x08000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '12. Contact Us & 13. Social Profiles',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'If you have questions, concerns, or requests regarding this Privacy Policy or our applications, you can contact us:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF334155),
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Emperor Smart Solutions',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Contact Phone Tile with Logo
                        InkWell(
                          onTap: () => _launchUrl(context, 'tel:+916354351080'),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    'assets/icons/contact.png',
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.cover,
                                    errorBuilder: (ctx, err, st) =>
                                        const Icon(Icons.phone, color: Colors.green),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Text(
                                    'Phone: +91 63543 51080',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF16A34A),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Instagram Tile with Logo
                        InkWell(
                          onTap: () => _launchUrl(
                            context,
                            'https://www.instagram.com/emperorsmartsolutions?stkn=eng4aTNpcWZqbWE=',
                          ),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    'assets/icons/instagram.png',
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.cover,
                                    errorBuilder: (ctx, err, st) =>
                                        const Icon(Icons.camera_alt, color: Colors.pink),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Text(
                                    'Instagram: Emperor Smart Solutions',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFE1306C),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // LinkedIn Tile with Logo
                        InkWell(
                          onTap: () => _launchUrl(
                            context,
                            'https://www.linkedin.com/company/emperor-smart-solutions/',
                          ),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    'assets/icons/linkedin.png',
                                    width: 32,
                                    height: 32,
                                    fit: BoxFit.cover,
                                    errorBuilder: (ctx, err, st) =>
                                        const Icon(Icons.work, color: Color(0xFF0A66C2)),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Text(
                                    'LinkedIn: Emperor Smart Solutions',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0A66C2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // 14. Application-Specific Information
                  _buildSectionCard(
                    title: '14. Application-Specific Information',
                    content:
                        'This Privacy Policy is designed as a common policy for applications published by Emperor Smart Solutions.\n\n'
                        'Because different applications may provide different features, permissions, advertising services, analytics services, or other functionality, the actual data practices of a particular application may differ.\n\n'
                        'Users should also review the relevant application\'s Google Play listing and Data Safety information.',
                    icon: Icons.apps_outlined,
                    accentColor: const Color(0xFF475569),
                  ),
                  const SizedBox(height: 24),

                  // Copyright Footer
                  const Center(
                    child: Text(
                      '© 2026 Emperor Smart Solutions. All rights reserved.',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextCard({required String text}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1.2),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF334155),
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String content,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 22, color: accentColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF334155),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
