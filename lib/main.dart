import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:online_donation_app/providers/payment_provider.dart';
import 'package:online_donation_app/providers/user_provider.dart';
import 'package:online_donation_app/services/local_storage_service.dart';
import 'package:online_donation_app/services/notification_service.dart';
import 'package:online_donation_app/views/home_screen.dart';
import 'package:online_donation_app/views/onboarding_screen1.dart';
import 'package:online_donation_app/views/onboarding_screen2.dart';
import 'package:online_donation_app/views/signin_screen.dart';
import 'package:online_donation_app/views/signup_screen.dart';
import 'package:online_donation_app/views/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization (for Web you must provide options manually)
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBob6-kntfIHYnhuRms10pSUaQeiyex8Qs",
        authDomain: "online-donation-app.firebaseapp.com",
        projectId: "online-donation-app",
        storageBucket: "online-donation-app.appspot.com",
        messagingSenderId: "1077383394491",
        appId: "1:1077383394491:web:93750cd3c6516d8bf6259e",
      ),
    );
  } else {
    // Mobile (Android/iOS) — will auto initialize using google-services.json
    await Firebase.initializeApp();
  }

  // Notifications init
  await NotificationService().initNotifications();

  // Onboarding check
  bool isOnboardingDone = await LocalStorageService.isOnboardingDone();

  runApp(MyApp(isOnboardingDone: isOnboardingDone));
}

class MyApp extends StatelessWidget {
  final bool isOnboardingDone;
  const MyApp({super.key, required this.isOnboardingDone});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online Donation App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: isOnboardingDone ? '/splash' : '/onboarding1',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignUpScreen(),
          '/home': (context) => HomeScreen(),
          '/onboarding1': (context) => OnboardingScreen1(),
          '/onboarding2': (context) => OnboardingScreen2(),
        },
      ),
    );
  }
}
