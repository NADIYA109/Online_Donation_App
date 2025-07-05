import 'package:flutter/material.dart';
import '../services/payment_service.dart';

class PaymentController with ChangeNotifier {
  final PaymentService _paymentService;

  PaymentController(this._paymentService);

  Future<void> startPayment({
    required BuildContext context,
    required String name,
    required String email,
    required String phone,
    required String amount,
  }) async {
    _paymentService.startPayment(
      context: context,
      name: name,
      email: email,
      phone: phone,
      amount: amount,
    );
  }
}
