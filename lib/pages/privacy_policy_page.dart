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
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Color(0xFF1E293B)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
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
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.shield_outlined,
                            color: Color(0xFF2563EB),
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time Calculator Privacy Policy',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Emperor Smart Solutions',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 28, color: Color(0xFFE2E8F0)),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Effective Date: Sept 21, 2026',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF475569),
                          ),
                        ),
                        Text(
                          'Last Updated: Sept 21, 2026',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Policy Sections
              _buildSectionCard(
                title: '1. Information Collection',
                content:
                    'Time Calculator is built as an offline-first utility application. We do not collect, request, transmit, store, or process any personal identification information, device identifiers, or user data.',
                icon: Icons.folder_off_outlined,
              ),
              const SizedBox(height: 14),
              _buildSectionCard(
                title: '2. Local Processing',
                content:
                    'All time calculations, duration additions, subtractions, and normalizations are performed entirely on your local device. No data is sent to external servers or cloud services.',
                icon: Icons.phonelink_setup_outlined,
              ),
              const SizedBox(height: 14),
              _buildSectionCard(
                title: '3. Advertising & Third-Party Services',
                content:
                    'Time Calculator contains zero advertisements, third-party trackers, ad SDKs, or commercial marketing integrations.',
                icon: Icons.block_outlined,
              ),
              const SizedBox(height: 14),
              _buildSectionCard(
                title: '4. Analytics & Telemetry',
                content:
                    'We do not collect usage statistics, crash logs, behavioral telemetry, or analytical metrics.',
                icon: Icons.analytics_outlined,
              ),
              const SizedBox(height: 14),
              _buildSectionCard(
                title: '5. Data Sharing',
                content:
                    'Since no user data is collected or generated by our app, no data is ever sold, rented, shared, or disclosed to third parties.',
                icon: Icons.share_outlined,
              ),
              const SizedBox(height: 14),
              _buildSectionCard(
                title: '6. Security & Safety',
                content:
                    'Because the application operates 100% offline without network requests, your calculations remain entirely secure and private on your device.',
                icon: Icons.lock_outline,
              ),
              const SizedBox(height: 14),
              _buildSectionCard(
                title: '7. Retention & Deletion',
                content:
                    'We do not retain any user records. Clearing calculations inside the app immediately resets your input state locally.',
                icon: Icons.delete_outline,
              ),
              const SizedBox(height: 14),
              _buildSectionCard(
                title: '8. Children\'s Privacy',
                content:
                    'Our application does not collect personal data from anyone, including children under the age of 13 or 16.',
                icon: Icons.child_care_outlined,
              ),
              const SizedBox(height: 14),
              _buildSectionCard(
                title: '9. Permissions',
                content:
                    'Time Calculator does not request sensitive Android permissions such as Location, Camera, Contacts, Microphone, or Storage.',
                icon: Icons.verified_user_outlined,
              ),
              const SizedBox(height: 14),
              _buildSectionCard(
                title: '10. External Links',
                content:
                    'The About page contains optional external links to our official Instagram, LinkedIn, and Contact dialer. Tapping these links opens your preferred external apps.',
                icon: Icons.open_in_new_outlined,
              ),
              const SizedBox(height: 14),
              _buildSectionCard(
                title: '11. Changes to Privacy Policy',
                content:
                    'We may update this Privacy Policy periodically. Any modifications will be posted here with an updated revision date.',
                icon: Icons.update_outlined,
              ),
              const SizedBox(height: 20),

              // Contact Footer Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '12. Contact Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'If you have questions about this Privacy Policy or Emperor Smart Solutions, please reach out to us:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF475569),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () => _launchUrl(context, 'tel:+916354351080'),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.phone, size: 18, color: Color(0xFF2563EB)),
                            SizedBox(width: 8),
                            Text(
                              '+91 63543 51080',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF2563EB),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _launchUrl(
                          context, 'https://www.instagram.com/emperorsmartsolutions?stkn=eng4aTNpcWZqbWE='),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt, size: 18, color: Color(0xFFE1306C)),
                            SizedBox(width: 8),
                            Text(
                              'Instagram: @emperorsmartsolutions',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFE1306C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _launchUrl(
                          context, 'https://www.linkedin.com/company/emperor-smart-solutions/'),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.work, size: 18, color: Color(0xFF0A66C2)),
                            SizedBox(width: 8),
                            Text(
                              'LinkedIn: Emperor Smart Solutions',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF0A66C2),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF334155)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF475569),
                    height: 1.45,
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
