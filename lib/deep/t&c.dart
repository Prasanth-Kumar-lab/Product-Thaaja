import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            SectionTitle('Last Updated'),
            SectionContent('15-05-2025'),

            SectionTitle('Welcome'),
            SectionContent(
              'Welcome to Thaaja, an e-commerce platform operated by Narayanadri Innovations Pvt Ltd ("Company," "we," "our," or "us"), dedicated to delivering high-quality organic products such as vegetables, dairy items, fruits, and other related categories through both subscription and non-subscription models. By accessing or using the Thaaja mobile application ("App") or website, you agree to comply with and be bound by these Terms and Conditions ("Terms"). Please read them carefully before using our services.',
            ),

            SectionTitle('1. ACCEPTANCE OF TERMS'),
            SectionContent(
              'By accessing, downloading, installing, or using the App or any services provided through Thaaja, you signify that you have read, understood, and agree to be bound by these Terms. These Terms apply to all users of the App, including without limitation users who are browsers, vendors, customers, merchants, and contributors of content.\n\nIf you do not agree to these Terms, you may not access or use our services. Thaaja reserves the right to modify or update these Terms at any time without prior notice. Continued use of the App following any such changes shall constitute your acceptance of those changes.',
            ),

            SectionTitle('2. ELIGIBILITY AND ACCOUNT REGISTRATION'),
            SectionSubtitle('2.1 Eligibility'),
            SectionContent(
              'You must be at least 18 years of age and capable of forming a binding contract under applicable law to use the App. By using our services, you represent and warrant that you meet these eligibility requirements.',
            ),
            SectionSubtitle('2.2 Account Registration'),
            SectionContent(
              'To access certain features of the App, you may be required to register an account. During registration, you agree to provide accurate, current, and complete information, including but not limited to:\n'
                  '• Full name\n'
                  '• Valid email address\n'
                  '• Mobile number\n'
                  '• Delivery address\n'
                  '• Any other information required for account creation\n\n'
                  'You agree to:\n'
                  '• Maintain the confidentiality of your account credentials.\n'
                  '• Notify us immediately of any unauthorized access or breach of security.\n'
                  '• Be solely responsible for all activities that occur under your account.\n\n'
                  'We reserve the right to suspend, deactivate, or terminate any account found to contain false, incomplete, or misleading information.',
            ),

            SectionTitle('3. SERVICES AND PRODUCTS'),
            SectionSubtitle('3.1 Product Offerings'),
            SectionContent(
              'Thaaja offers a range of organic products including but not limited to fresh vegetables, dairy items, fruits, nuts, and other organic goods. These products are sourced from verified vendors and organic farms to ensure quality and sustainability.',
            ),
            SectionSubtitle('3.2 Subscription & Non-Subscription Services'),
            SectionContent(
              'We offer:\n'
                  '• Subscription Services: Users may subscribe to regular delivery schedules for selected products. Subscriptions may be weekly, bi-weekly, or monthly, depending on availability and user preference.\n'
                  '• Non-Subscription Services: Users may also place one-time orders without a subscription.\n\n'
                  'Subscription services come with additional benefits, including discounted pricing, priority delivery, and exclusive access to new products. Subscription terms may be modified or cancelled per the cancellation policy detailed in Section 4.3.',
            ),
            SectionSubtitle('3.3 Product Descriptions & Quality'),
            SectionContent(
              'We strive to ensure that all product descriptions, pricing, and availability are accurate and up to date. However, we do not guarantee the accuracy, completeness, reliability, or timeliness of product information. In case of any discrepancy, we reserve the right to correct errors or omissions and to change or update information without prior notice.',
            ),

            SectionTitle('4. ORDER PLACEMENT, PAYMENT, AND BILLING'),
            SectionSubtitle('4.1 Order Process'),
            SectionContent(
              'Orders can be placed via the App. Once an order is placed, users will receive a confirmation message detailing the products, prices, and estimated delivery schedule. We reserve the right to reject or cancel orders due to product unavailability, errors in pricing, or any other reason at our sole discretion.',
            ),
            SectionSubtitle('4.2 Pricing & Payment'),
            SectionContent(
              'All prices are listed in INR and are inclusive of applicable taxes unless stated otherwise. We accept payments through various secure modes including UPI, credit/debit cards, digital wallets, and other payment gateways. By providing your payment information, you represent and warrant that you are authorized to use the designated payment method.',
            ),
            SectionSubtitle('4.3 Refunds & Cancellations'),
            SectionContent(
              '• Orders can be canceled before they are processed for dispatch. Subscription cancellations must be made at least 24 hours prior to the next delivery cycle.\n'
                  '• Refunds will be processed for defective, damaged, or wrongly delivered products upon valid claims.\n'
                  '• All refund requests must be made within 48 hours of delivery and are subject to inspection.',
            ),

            SectionTitle('5. USER RESPONSIBILITIES AND PROHIBITED CONDUCT'),
            SectionSubtitle('5.1 User Obligations'),
            SectionContent(
              'As a user of Thaaja, you agree to:\n'
                  '• Use the App for lawful purposes only.\n'
                  '• Provide accurate information and keep your profile updated.\n'
                  '• Maintain the confidentiality of your login credentials.\n'
                  '• Report any suspicious or unauthorized activities promptly.',
            ),
            SectionSubtitle('5.2 Prohibited Conduct'),
            SectionContent(
              'You agree not to:\n'
                  '• Use the App in violation of any applicable laws or regulations.\n'
                  '• Impersonate any person or entity or misrepresent your affiliation.\n'
                  '• Interfere with or disrupt the App or its servers/networks.\n'
                  '• Use automated means to access or collect data from the App.\n'
                  '• Upload or transmit any viruses or harmful code.',
            ),

            SectionTitle('6. INTELLECTUAL PROPERTY'),
            SectionContent(
              'All content, design elements, trademarks, logos, and software used in the App are the intellectual property of Narayanadri Innovations Pvt Ltd or its licensors. Unauthorized use, reproduction, modification, or distribution of any material from Thaaja is strictly prohibited. Users are granted a limited, non-exclusive, non-transferable license to access and use the App for personal, non-commercial use.',
            ),

            SectionTitle('7. LIMITATION OF LIABILITY'),
            SectionContent(
              'To the maximum extent permitted by law, Narayanadri Innovations Pvt Ltd shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, arising from your use of the App, even if we have been advised of the possibility of such damages. Our liability shall in no event exceed the amount paid by you for the product or service giving rise to the claim.',
            ),

            SectionTitle('8. GOVERNING LAW AND DISPUTE RESOLUTION'),
            SectionContent(
              'These Terms shall be governed by and construed in accordance with the laws of India, without regard to its conflict of law provisions. Any disputes arising out of or in connection with these Terms shall be subject to the exclusive jurisdiction of the courts located in Hyderabad, Telangana.',
            ),

            SectionTitle('9. CONTACT INFORMATION'),
            SectionContent(
              'For any queries or concerns regarding these Terms or our services, please contact us:\n'
                  'Company Name: Narayanadri Innovations Pvt Ltd\n'
                  'Address: Hyderabad, Telangana\n'
                  'Email: legal@thaaja.in',
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
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}

class SectionSubtitle extends StatelessWidget {
  final String subtitle;
  const SectionSubtitle(this.subtitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
      child: Text(
        subtitle,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
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
