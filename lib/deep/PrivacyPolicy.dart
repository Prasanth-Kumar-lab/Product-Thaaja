import 'package:flutter/material.dart';
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);
  final String _title = 'Privacy Policy';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Colors.green[700],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: PrivacyPolicyContent(),
      ),
    );
  }
}
class PrivacyPolicyContent extends StatelessWidget {
  const PrivacyPolicyContent({Key? key}) : super(key: key);
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
  }
  Widget bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Effective Date: 15-05-2025",
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
        const SizedBox(height: 16),
        Text(
          "As a \"Company,\" \"we,\" \"our,\" or \"us\", Thaaja, operated by Narayanadri Innovations Pvt Ltd, we value your trust and are committed to protecting the privacy of our users (\"you,\" \"your\"). This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application \"Thaaja,\" an e-commerce platform providing organic products, including vegetables, dairy items, fruits, and other related categories, through both subscription-based and non-subscription services.",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        sectionTitle("1. Information We Collect"),
        bulletPoint("Full name"),
        bulletPoint("Contact details (phone number, email address, delivery address)"),
        bulletPoint("Payment information (processed securely via third-party payment gateways)"),
        bulletPoint("Government-issued identification where required for legal compliance"),
        bulletPoint("Device info, log data, and usage statistics"),
        bulletPoint("Data from third-party sources like payment gateways or social media platforms"),
        sectionTitle("2. How We Use Your Information"),
        bulletPoint("Create and manage user accounts"),
        bulletPoint("Process and fulfil orders"),
        bulletPoint("Manage subscription services"),
        bulletPoint("Provide customer support"),
        bulletPoint("Enable deliveries to your specified address"),
        bulletPoint("Offer tailored product recommendations"),
        bulletPoint("Analyze usage trends for performance enhancements"),
        bulletPoint("A/B testing new features"),
        bulletPoint("Monitor user engagement"),
        bulletPoint("Enforce our terms and conditions"),
        bulletPoint("Prevent fraud or misuse of our services"),
        bulletPoint("Comply with legal obligations and respond to lawful requests"),
        sectionTitle("3. Data Sharing & Disclosure"),
        bulletPoint("With service providers like delivery partners, payment gateways, IT, and cloud hosting providers, marketing platforms"),
        bulletPoint("For legal or regulatory reasons, as required by law, subpoena, or legal process"),
        bulletPoint("During mergers, acquisitions, or asset sales, where your data may be transferred as part of the transaction"),
        sectionTitle("4. Data Security Measures"),
        bulletPoint("Data encryption in transit and at rest"),
        bulletPoint("Secure authentication protocols"),
        bulletPoint("Regular security audits and assessments"),
        Text(
          "Note: No method is 100% secure; we cannot guarantee absolute security of your information.",
          style: TextStyle(fontSize: 16),
        ),
        sectionTitle("5. Data Retention & Deletion"),
        bulletPoint("We retain your personal information for as long as necessary to provide services, comply with legal obligations, resolve disputes, and enforce our agreements"),
        bulletPoint("Upon your request or account termination, we will delete or anonymize your data, subject to legal or regulatory retention requirements"),
        sectionTitle("6. User Rights & Choices"),
        bulletPoint("Access: Request a copy of your personal data"),
        bulletPoint("Correction: Request corrections to inaccurate or incomplete data"),
        bulletPoint("Deletion: Request deletion of your data"),
        bulletPoint("Opt-out: Opt-out of marketing communications"),
        bulletPoint("Data Portability: Request transfer of your data to another service"),
        bulletPoint("For any of these rights, contact us at legal@thaaja.in"),
        sectionTitle("7. Third-Party Links & Services"),
        Text(
          "Our app may contain links to third-party websites, applications, or services. We are not responsible for the privacy practices or content of such external services. We encourage you to review their privacy policies before interacting with them.",
          style: TextStyle(fontSize: 16),
        ),
        sectionTitle("8. Children’s Privacy"),
        Text(
          "Our services are not intended for individuals under the age of 18. We do not knowingly collect or solicit personal data from minors. If we learn that we have collected data from a minor, we will delete it promptly.",
          style: TextStyle(fontSize: 16),
        ),
        sectionTitle("9. International Data Transfers"),
        Text(
          "If you are accessing our services from outside India, please note that your data may be transferred to and processed in India or other jurisdictions. By using the app, you consent to such transfers, subject to this Privacy Policy.",
          style: TextStyle(fontSize: 16),
        ),
        sectionTitle("10. Changes to This Privacy Policy"),
        Text(
          "We may update this Privacy Policy from time to time to reflect changes in our practices or legal requirements. We will notify you of significant changes through the app or by other means. Continued use of the app after such changes constitutes your acceptance of the revised policy.",
          style: TextStyle(fontSize: 16),
        ),
        sectionTitle("11. Contact Information"),
        Text(
          "Company Name: Narayanadri Innovations Pvt Ltd\n"
              "Address: Hyderabad, Telangana - 501301\n"
              "Email: legal@thaaja.in",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
