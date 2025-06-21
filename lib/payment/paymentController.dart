// payment_controller.dart
import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController {
  late Razorpay _razorpay;
  var isPaymentSuccessful = false.obs;
  var selectedPaymentMethod = 'razorpay'.obs; // default payment method

  Completer<bool>? _paymentCompleter;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar("Success", "Payment Successful");
    isPaymentSuccessful.value = true;
    _paymentCompleter?.complete(true);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("Error", "Payment Failed");
    _paymentCompleter?.complete(false);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("External Wallet", "Wallet: ${response.walletName}");
    _paymentCompleter?.complete(false);
  }

  Future<bool> openCheckout(double amount) async {
    _paymentCompleter = Completer<bool>();

    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': (amount * 100).toInt(),
      'name': 'Thaaja',
      'description': 'Pay to start the contest',
      'prefill': {
        'contact': '9505909402',
        'email': 'bunnyprashanth112@gmail.com',
        'vpa': '9505909402@ybl',
      },
      'method': {
        'upi': true,
        'card': true,
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error: $e');
      _paymentCompleter?.complete(false);
    }

    return await _paymentCompleter!.future;
  }
  void _logCustomerName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final phoneNumber = user.phoneNumber;
      if (phoneNumber != null) {
        final doc = await FirebaseFirestore.instance.collection('Customers').doc(phoneNumber).get();
        if (doc.exists) {
          final customerName = doc['name'];
          print('Order placed by: $customerName ($phoneNumber)');
        } else {
          print('Customer not found for phone: $phoneNumber');
        }
      }
    }
  }

  String generateOrderId() {
    final now = DateTime.now();
    final random = Random().nextInt(10000);
    return "ORD-${now.millisecondsSinceEpoch}-$random";
  }

  // Simulate payment (for Razorpay)
}
