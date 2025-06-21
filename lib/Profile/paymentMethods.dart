import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thaaja/Profile/addCard.dart';

class PaymentMethodsPage extends StatefulWidget {
  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Payment Method',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Credit & Debit Card',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildPaymentOption('Pay New Card', Icons.credit_card, 0),
            const SizedBox(height: 20),
            Text(
              'More Payment Options',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildPaymentOption('Credit / Debit Cards', Icons.credit_card, 1),
            _buildPaymentOption('Credit / Debit Cards', Icons.credit_card, 2),
            _buildPaymentOption('Apple Pay', Icons.apple, 3),
            _buildPaymentOption('Google Pay', Icons.payment, 4),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Get.to(()=>AddCardPage());
                },
                child: Text(
                  'Add New Card',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(10),
          color: _selectedIndex == index ? Colors.green.withOpacity(0.2) : Colors.white,
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.green),
          title: Text(title, style: TextStyle(fontSize: 16)),
          trailing: Icon(
            _selectedIndex == index ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}