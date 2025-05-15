import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_donation_app/providers/user_provider.dart';
import 'package:online_donation_app/views/home_screen.dart';
import 'package:online_donation_app/views/signin_screen.dart';
import 'package:online_donation_app/views/signup_screen.dart';
import 'package:provider/provider.dart';  // Import the provider package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online Donation App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignUpScreen(),
          '/home': (context) => HomeScreen(), 
        },
      ),
    );
  }
}


    
     