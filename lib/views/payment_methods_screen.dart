import 'package:flutter/material.dart';
import 'package:online_donation_app/views/home_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentMethodScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String amount;

  const PaymentMethodScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.amount,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    

    var options = {
      'key': 'rzp_test_0huXlLBY2Tyj1D', 
      'amount': (int.parse(widget.amount) * 100), // in paise
      'name':  widget.name,
      'description': 'Donation',
      'prefill': {
        'contact': widget.phone,
        'email': widget.email,
      },
      'theme': {
        'color': '#3399cc',
      }
    
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
  

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Successful! ID: ${response.paymentId}")),
    );
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  (route) => false,
);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed! ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Wallet Selected: ${response.walletName}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
      title: const Text("Payment"),
      backgroundColor: Colors.blueAccent,
    ),
    body: const Center(
      child: Text(
        "Opening Razorpay...",
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    ),
    );
  }
}