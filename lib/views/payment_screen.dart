import 'package:flutter/material.dart';
import 'package:online_donation_app/providers/payment_provider.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String amount;

  const PaymentScreen({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.amount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PaymentProvider>(context, listen: false);
      final controller = provider.paymentController;
      controller.startPayment(
        context: context,
        name: widget.name,
        email: widget.email,
        phone: widget.phone,
        amount: widget.amount,
      );
    });
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
