import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thaaja/deep/PrivacyPolicy.dart';
import 'package:thaaja/deep/ResponsibleDisclosurePage.dart';
import 'package:thaaja/deep/ReturnRefund.dart';
import 'package:thaaja/deep/t&c.dart';

// Main Help Center Page
class HelpCenterpage extends StatefulWidget {
  const HelpCenterpage({super.key});

  @override
  _HelpCenterpageState createState() => _HelpCenterpageState();
}

class _HelpCenterpageState extends State<HelpCenterpage> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, how can we help you?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  categoryCard('General', 'Basic questions about Restate', Icons.grid_view, 0,PrivacyPolicyPage() ),
                  categoryCard('Sellers', 'All you need to know about selling', Icons.currency_exchange, 1,PrivacyPolicyPage() ),
                  categoryCard('Buyers', 'Everything you need to know about buying', CupertinoIcons.cart, 2,PrivacyPolicyPage() ),
                  categoryCard('Agents', 'How agents can work with Restate', CupertinoIcons.person, 3,PrivacyPolicyPage() ),
                  categoryCard('Privacy Policy', 'Our privacy practices', Icons.escalator_warning, 4,PrivacyPolicyPage() ),
                  categoryCard('Responsible Disclosure', 'Security issue reporting guidelines', Icons.disc_full, 5, ResponsibleDisclosurePolicyPage()),
                  categoryCard('Return & Refund Policy', 'How we handle returns', Icons.replay_circle_filled, 6, ReturnRefundPage()),
                  categoryCard('Terms and Conditions', 'Our service terms', Icons.crisis_alert, 7,TermsAndConditionsPage() ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryCard(String title, String subtitle, IconData icon, int index, Widget destinationPage) {
    bool isSelected = selectedIndex == index;

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 1,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color.fromRGBO(102, 102, 102, 0.12),
          child: Icon(icon, color: Colors.red),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        tileColor: isSelected ? Colors.green[50] : null,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isSelected ? Colors.green : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          Get.to(destinationPage); // ✅ Correct
          // Navigation using Get
        },
      ),
    );
  }
}
