import 'package:flutter/material.dart';
import 'package:online_donation_app/services/notification_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../views/home_screen.dart';

class PaymentService {
  late Razorpay _razorpay;

  void startPayment({
    required BuildContext context,
    required String name,
    required String email,
    required String phone,
    required String amount,
  }) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (res) => _handleSuccess(context, res, name, email, phone, amount));
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (res) => _handleError(context, res));
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (res) => _handleExternalWallet(context, res));

    var options = {
      'key': 'rzp_test_0huXlLBY2Tyj1D',
      'amount': int.parse(amount) * 100,
      'name': name,
      'description': 'Donation',
      'prefill': {
        'contact': phone,
        'email': email,
      },
      'theme': {'color': '#3399cc'}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handleSuccess(BuildContext context, PaymentSuccessResponse response, String name, String email, String phone, String amount) async {
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    String time = DateFormat('hh:mm a').format(DateTime.now());

    await FirebaseFirestore.instance.collection('donations').add({
      'name': name,
      'email': email,
      'amount': amount,
      'phone': phone,
      'date': date,
      'time': time,
      'paymentId': response.paymentId,
      'status': 'success',
    });

  
  await NotificationService().showLocalThankYou();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
      (route) => false,
    );
  }

  void _handleError(BuildContext context, PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(BuildContext context, ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Wallet Selected: ${response.walletName}")),
    );
  }
}
