import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_donation_app/providers/user_provider.dart';
import 'package:online_donation_app/services/local_storage_service.dart';
import 'package:online_donation_app/views/home_screen.dart';
import 'package:online_donation_app/views/onboarding_screen1.dart';
import 'package:online_donation_app/views/onboarding_screen2.dart';
import 'package:online_donation_app/views/signin_screen.dart';
import 'package:online_donation_app/views/signup_screen.dart';
import 'package:provider/provider.dart';  // Import the provider package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   bool isOnboardingDone = await LocalStorageService.isOnboardingDone();
  runApp(MyApp(isOnboardingDone: isOnboardingDone));
}
  // runApp(MyApp());
//}

class MyApp extends StatelessWidget {
   final bool isOnboardingDone;
   MyApp({required this.isOnboardingDone});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online Donation App',
        theme: ThemeData(primarySwatch: Colors.blue),
        // initialRoute: '/login',
        initialRoute: isOnboardingDone ? '/login' : '/onboarding1',
        routes: {
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


    
     