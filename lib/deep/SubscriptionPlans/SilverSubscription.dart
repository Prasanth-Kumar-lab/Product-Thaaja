import 'package:flutter/material.dart';
import 'package:thaaja/payment/paymentController.dart';
import 'package:get/get.dart';
class SilverSubscription extends StatefulWidget {
  const SilverSubscription({super.key});

  @override
  _SilverSubscriptionState createState() => _SilverSubscriptionState();
}

class _SilverSubscriptionState extends State<SilverSubscription> {
  String? selectedDays = '7'; // Default selected days
  final List<String> daysOptions = ['7', '15', '30', '45'];

  // Pricing based on days
  final Map<String, int> pricing = {
    '7': 499,
    '15': 799,
    '30': 1199,
    '45': 1499,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Silver Subscription Plans',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green[50]!,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Days Selection Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
                child: DropdownButton<String>(
                  value: selectedDays,
                  isExpanded: true,
                  underline: const SizedBox(), // Remove default underline
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  items: daysOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text('$value Days Plan'),// - ₹${pricing[value]}
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDays = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Premium Single Banner
              _buildPremiumBanner(),
              const SizedBox(height: 20),
              // Subscribe Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () async {
                    final paymentController = Get.put(PaymentController()); // Inject controller

                    int? amount = pricing[selectedDays]; // Get amount based on selected days

                    if (amount != null) {
                      bool success = await paymentController.openCheckout(amount.toDouble());

                      if (success) {
                        // Navigate or show a success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Subscription Successful!")),
                        );
                      } else {
                        // Payment failed
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Payment Failed. Please try again.")),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Subscribe Now - ₹${pricing[selectedDays]}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Plan Details Section
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Plan Benefits:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildBenefitItem(Icons.check_circle, 'Daily fresh items delivery'),
                          _buildBenefitItem(Icons.check_circle, 'Premium quality products'),
                          _buildBenefitItem(Icons.check_circle, 'Flexible delivery schedule'),
                          _buildBenefitItem(Icons.check_circle, 'Exclusive member discounts'),
                          _buildBenefitItem(Icons.check_circle, 'Priority customer support'),
                          _buildBenefitItem(Icons.check_circle, 'Free delivery on all orders'),
                          _buildBenefitItem(Icons.check_circle, 'Early access to new products'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumBanner() {
    return Container(
      width: double.infinity,
      height: 220, // Slightly taller for better visual impact
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage(
            'assets/Onboarding1.png',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black54,
            BlendMode.darken,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative elements
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFFC0C0C0).withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFFC0C0C0),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.star,
                color: Color(0xFFC0C0C0),
                size: 30,
              ),
            ),
          ),

          // Ribbon badge
          Positioned(
            left: 0,
            top: 20,
            child: Container(
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red[700],
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(4),
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(2, 0),
                  ),
                ],
              ),
              child:Text(
                'LIMITED TIME',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          // Main content
          // Main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                'Silver MEMBERSHIP',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Vegetables - Upto 2kgs free',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Fruits - Upto 1kg free',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildBenefitItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}