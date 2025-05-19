import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_donation_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp(String name,  String email, String password , BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
       // Update the display name
      await userCredential.user?.updateDisplayName(name);
      

        // Update the UserProvider after successful sign-up
    final user = userCredential.user;
    if (user != null) {
      Fluttertoast.showToast(msg: "Sign up successful!");

       // Access the UserProvider and update the user
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(user);

      return user;
    }
    return null;
      
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<User?> login(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the UserProvider after successful login
    final user = userCredential.user;
    if (user != null) {


      Fluttertoast.showToast(msg: "Login successful!");

        // Access the UserProvider and update the user
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(user);
      return user;
    }
    return null;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Fluttertoast.showToast(msg: "Logged out!");
  }
}
