import 'package:flutter/material.dart';
import '../controllers/payment_controller.dart';
import '../services/payment_service.dart';

class PaymentProvider extends ChangeNotifier {
  late final PaymentController controller;

  PaymentProvider() {
    controller = PaymentController(PaymentService());
  }

  PaymentController get paymentController => controller;
}
