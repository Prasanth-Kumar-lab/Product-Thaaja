import 'package:flutter/material.dart';

class ReturnRefundPage extends StatelessWidget {
  const ReturnRefundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Return & Refund Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            SectionTitle('Effective Date'),
            SectionContent('April 15, 2025'),

            SectionTitle('1. General Policy Overview'),
            SectionContent(
                'At Thaaja, a brand owned and operated by Narayanadri Innovations Pvt Ltd, we are committed to providing our customers with high-quality organic items including but not limited to vegetables, dairy products, fruits, and related categories.\n\n'
                    'Given the perishable nature of many of our products, we have established a clear and comprehensive Return and Refund Policy to address the unique circumstances surrounding the purchase and delivery of these goods. By placing an order through our application, customers agree to the terms and conditions set forth in this policy.'
            ),

            SectionTitle('2. Eligibility for Return'),
            SectionContent(
                'To be eligible for a return, customers must notify Thaaja\'s support team within 2 hours of product delivery. The product must be defective, damaged during delivery, or substantially different from its description. Customers must provide clear photographic evidence to substantiate their claim.\n\n'
                    'Eligible returns must also meet the following criteria:\n'
                    '• The product is in its original packaging.\n'
                    '• The product has not been used or consumed.\n'
                    '• A complaint is raised within the stipulated timeframe.'
            ),

            SectionTitle('3. Items Not Eligible for Return'),
            SectionContent(
                'Due to the perishable nature of many of our products, certain items are exempt from being returned, including:\n'
                    '• Fresh vegetables and fruits once delivered in acceptable condition.\n'
                    '• Dairy products including milk, curd, ghee, and paneer unless found spoiled or tampered.\n'
                    '• Items delivered as part of daily or weekly subscription unless quality issues are proven.\n'
                    '• Any product not reported as defective within the stipulated timeframe.'
            ),

            SectionTitle('4. Refund Policy'),

            SectionSubtitle('4.1 Refund Processing'),
            SectionContent(
                'Approved refunds will be processed through the original method of payment or, where appropriate, credited to the customer\'s Thaaja wallet for future purchases. The refund will be initiated within 7 business days of the approval of the return or dispute resolution.'
            ),

            SectionSubtitle('4.2 Partial Refunds'),
            SectionContent(
                'In certain situations, only partial refunds may be granted:\n'
                    '• Items that are partially consumed but reported defective.\n'
                    '• Minor issues not impacting the product’s overall usability or safety.\n'
                    '• Incorrect but functionally similar substitute products accepted by the customer.'
            ),

            SectionSubtitle('4.3 No Refunds'),
            SectionContent(
                'No refunds will be provided under the following circumstances:\n'
                    '• Customer dissatisfaction due to personal preferences, taste, or appearance.\n'
                    '• Returns initiated after the allowable period.\n'
                    '• Any misuse, mishandling, or improper storage of products post-delivery.'
            ),

            SectionTitle('5. Replacement Policy'),

            SectionSubtitle('5.1 Eligibility for Replacement'),
            SectionContent(
                'Products delivered in a damaged or spoiled condition, or not matching the ordered item, may be eligible for replacement. Requests must be submitted within 2 hours of delivery with valid photographic evidence.'
            ),

            SectionSubtitle('5.2 Replacement Timeframe'),
            SectionContent(
                'Once approved, replacements will be delivered within 48 hours, subject to stock availability. In case the product is out of stock, a refund will be issued instead.'
            ),

            SectionTitle('6. Subscription Orders'),

            SectionSubtitle('6.1 Modifications and Cancellations'),
            SectionContent(
                'Customers may modify or cancel their subscription plan up to 24 hours before the next scheduled delivery. Any modifications or cancellations requested after this period may not be honoured.'
            ),

            SectionSubtitle('6.2 Refund on Subscription Orders'),
            SectionContent(
                'Refunds for subscription orders will be considered only in cases of product quality issues, non-delivery, or service interruptions. Refunds will be issued proportionate to the undelivered portion of the subscription, less any applicable handling charges.'
            ),

            SectionTitle('7. Delivery Disputes'),
            SectionContent(
                'In case of disputes concerning missed deliveries, incorrect items, or delays, the customer must notify Thaaja within 2 hours of the expected delivery time. Proof of non-delivery, incorrect delivery, or damage must be submitted to initiate the investigation. If the dispute is found valid, a refund or redelivery will be arranged.'
            ),

            SectionTitle('8. Communication and Dispute Resolution'),
            SectionContent(
                'Thaaja encourages customers to contact our support team via email at Contact@thaaja.in for any concerns or disputes. We strive to resolve issues amicably within 5 business days. If the customer remains unsatisfied, the matter may be escalated to the company\'s grievance officer for final resolution.'
            ),

            SectionTitle('9. Right to Amend'),
            SectionContent(
                'Narayanadri Innovations Pvt Ltd reserves the right to update or modify this Return and Refund Policy at any time without prior notice. Changes will be effective immediately upon posting on the Thaaja app or website. Continued use of the service after such changes shall constitute acceptance of the updated terms.'
            ),

            SectionTitle('10. Governing Law and Jurisdiction'),
            SectionContent(
                'This policy shall be governed by and construed in accordance with the laws of India. All disputes arising under or in connection with this policy shall be subject to the exclusive jurisdiction of the courts located in Hyderabad, Telangana.'
            ),

            SectionTitle('Special Clause – Lab and Soil Test Report Accuracy Guarantee'),
            SectionContent(
                'At Thaaja, we provide detailed lab and soil test reports for our organic products. If a customer, upon independent verification with a certified laboratory, finds discrepancies in the reports provided by Thaaja, and such discrepancies are material and substantiated by documentation, Thaaja shall issue a refund amounting to 1.5 times the purchase value of the affected product. This claim must be submitted with the third-party lab report within 7 days of purchase.'
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
