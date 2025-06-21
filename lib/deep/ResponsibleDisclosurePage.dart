import 'package:flutter/material.dart';

class ResponsibleDisclosurePolicyPage extends StatelessWidget {
  const ResponsibleDisclosurePolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsible Disclosure Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            SectionTitle('Introduction'),
            SectionContent(
              'At Thaaja, we prioritize the privacy and security of our users. We understand the value of the security research community and welcome responsible disclosures of vulnerabilities that may impact the integrity, confidentiality, or availability of our systems.\n\n'
                  'This policy outlines our commitment to engage with ethical hackers and researchers constructively and describes the framework under which security vulnerabilities may be reported to us in a responsible manner.',
            ),

            SectionTitle('Eligibility for Recognition'),
            SectionContent(
              'To be eligible for recognition in our Hall of Fame or any public acknowledgment, your disclosure must meet the following conditions:\n'
                  '1. You must be the first person to responsibly report a qualifying vulnerability.\n'
                  '2. The reported issue must involve a security risk capable of:\n'
                  '   • Compromising private user data.\n'
                  '   • Circumventing system security controls.\n'
                  '   • Allowing unauthorized access to systems or data.\n'
                  '3. The report must be made in good faith and must adhere to the Rules of Engagement and Programme Terms listed herein.',
            ),

            SectionTitle('Types of Recognition'),
            SectionContent(
              '• Hall of Fame Listing on our official website (with researcher’s consent).\n'
                  '• Letter of Appreciation from Thaaja’s security team.\n'
                  '• Public or private recognition on social media (optional).\n'
                  '• Other forms of gratitude at Thaaja’s discretion.\n\n'
                  'Note: No monetary rewards or bug bounties are currently offered under this program.',
            ),

            SectionTitle('Rules of Engagement'),
            SectionContent(
              '1. You will allow reasonable time for us to investigate and remediate the vulnerability before any public disclosure.\n'
                  '2. You will not exploit the vulnerability in any way, including demonstrating additional impact (e.g., data extraction, system compromise).\n'
                  '3. Use of automated tools or scanners is strictly prohibited. Reports generated from such tools will not be accepted.\n'
                  '4. Avoid any actions that could negatively impact Thaaja\'s users, services, or infrastructure, including denial of service, spamming, or brute force attempts.\n'
                  '5. You must not:\n'
                  '   • Violate any applicable laws or regulations.\n'
                  '   • Breach or attempt to breach any third-party rights or agreements.\n'
                  '6. You will not publicly disclose any vulnerability details without explicit written permission from Thaaja.\n'
                  '7. Only use test accounts for the purpose of discovering bugs. Do not attempt to access or modify actual user accounts or data.',
            ),

            SectionTitle('Programme Terms'),
            SectionContent(
              'Thaaja, at its sole discretion, determines:\n'
                  '• The validity of a reported vulnerability.\n'
                  '• Whether a vulnerability qualifies for recognition.\n'
                  '• The scope and impact of each report.\n\n'
                  'Reports must:\n'
                  '• Describe a vulnerability in one of the applications or services listed in the Scope.\n'
                  '• Include detailed steps to reproduce the issue (screenshots, videos, or written instructions).\n'
                  '• Be submitted via our official reporting channel (see “How to Report”).\n\n'
                  'Inadvertent access to sensitive data (if any) must be disclosed immediately within your report. We may take legal action against any individual who exploits or weaponizes discovered vulnerabilities.\n\n'
                  'Thaaja reserves the right to:\n'
                  '• Retain communication records related to reported vulnerabilities.\n'
                  '• Modify or terminate this program at any time without notice.\n'
                  '• Evaluate reports based on risk level, exploitability, quality, and business impact.',
            ),

            SectionTitle('Scope'),
            SectionContent(
              'This policy applies to the following digital assets and services:\n'
                  '• Thaaja Android App\n'
                  '• Thaaja iOS App\n'
                  '• Thaaja Delivery Partner App\n'
                  '• Thaaja Vendor App\n'
                  '• thaaja.in and all its subdomains\n'
                  '• thaaja.com and all its subdomains\n'
                  '• Any cloud infrastructure owned by Narayanadri Innovations Pvt Ltd',
            ),

            SectionTitle('How to Report a Vulnerability'),
            SectionContent(
              'To report a vulnerability:\n'
                  '1. Email us at security@thaaja.in with the subject line: "Responsible Disclosure: [Brief Issue Description]".\n'
                  '2. Include:\n'
                  '   • A detailed description of the vulnerability.\n'
                  '   • Proof-of-Concept (PoC) with reproducible steps (screenshots, videos, or written instructions).\n'
                  '   • Your contact details (email and/or phone number).\n'
                  '   • The impact or potential exploit scenario, if known.\n\n'
                  'Reports that are vague or lack actionable information may be disregarded.',
            ),

            SectionTitle('Qualifying Vulnerabilities'),
            SectionContent(
              'We are interested in real security issues that affect the confidentiality, integrity, or availability of user data or Thaaja infrastructure. This includes (but is not limited to):\n'
                  '• Cross-Site Scripting (XSS)\n'
                  '• SQL Injection / NoSQL Injection\n'
                  '• Cross-Site Request Forgery (CSRF)\n'
                  '• Broken Authentication / Session Management\n'
                  '• Remote Code Execution (RCE)\n'
                  '• Server-Side Request Forgery (SSRF)\n'
                  '• Access control issues (IDOR, privilege escalation)\n'
                  '• Business logic flaws with security impact\n'
                  '• Account takeover vulnerabilities\n'
                  '• API or mobile endpoint misconfigurations\n'
                  '• Misconfigured or vulnerable subdomains',
            ),

            SectionTitle('Exclusions'),
            SectionContent(
              'The following are not in scope and generally do not qualify for recognition:\n'
                  '• Reports generated by automated tools or scripts.\n'
                  '• Issues that require man-in-the-middle attacks or physical access.\n'
                  '• Denial-of-Service (DoS) or brute-force attacks.\n'
                  '• SPF, DKIM, DMARC issues or email spoofing.\n'
                  '• Non-exploitable clickjacking or missing X-Frame-Options.\n'
                  '• Self-XSS, or XSS requiring user interaction in browser console.\n'
                  '• TLS/SSL best practices (e.g., cipher suites, HSTS not set).\n'
                  '• Cookie flags missing for non-sensitive cookies.\n'
                  '• Vulnerabilities only exploitable on rooted/jailbroken devices.\n'
                  '• Missing security headers without direct exploit impact.\n'
                  '• Open ports with no proof of exploitability.\n'
                  '• Reports related to third-party apps or platforms.\n'
                  '• Social engineering or phishing simulations.\n'
                  '• Version disclosures or banner information.\n'
                  '• Publicly known CVEs disclosed in the past 90 days without unique context in Thaaja’s services.',
            ),

            SectionTitle('Legal Safe Harbor'),
            SectionContent(
              'If you act in good faith under this policy, we will consider your conduct to be authorized, and we will not initiate legal action against you. We consider this to be “authorized conduct” under the Indian Information Technology Act, 2000 (and amendments), provided all guidelines in this policy are followed.\n\n'
                  'However, we reserve all legal rights against individuals who act maliciously, exploit vulnerabilities for personal or third-party gain, or cause harm to our users or infrastructure.',
            ),

            SectionTitle('Acknowledgements'),
            SectionContent(
              'Thaaja deeply appreciates the efforts of ethical security researchers. While we do not offer financial bounties, we are committed to recognizing valid reports through:\n'
                  '• Inclusion in our Hall of Fame.\n'
                  '• Certificates or letters of appreciation.\n'
                  '• Public acknowledgment via Thaaja’s digital properties (subject to your permission).',
            ),

            SectionTitle('Updates to This Policy'),
            SectionContent(
              'We may update this policy from time to time. Continued participation in the program constitutes your acceptance of the modified terms. Please review this policy periodically.',
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
  }
}

class SectionContent extends StatelessWidget {
  final String content;

  const SectionContent(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: TextAlign.justify,
    );
  }
}
