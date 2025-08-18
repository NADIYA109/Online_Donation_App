// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:online_donation_app/views/myprofile.dart';
// import 'package:online_donation_app/views/signin_screen.dart';

// class ProfileScreen extends StatefulWidget {
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final User? user = FirebaseAuth.instance.currentUser;
//   File? _profileImage;

//   @override
//   void initState() {
//     super.initState();
//     _loadProfileImage();
//   }

//   Future<void> _loadProfileImage() async {
//     final prefs = await SharedPreferences.getInstance();
//     final imagePath = prefs.getString('profileImagePath');
//     if (imagePath != null && mounted) {
//       setState(() {
//         _profileImage = File(imagePath);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Profile"),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//       ),
//       body: user == null
//           ? const Center(child: Text("No user info"))
//           : Column(
//               children: [
//                 const SizedBox(height: 20),

//                 // Profile Image
//                 CircleAvatar(
//                   radius: 45,
//                   backgroundColor: Colors.grey[300],
//                   backgroundImage:
//                       _profileImage != null ? FileImage(_profileImage!) : null,
//                   child: _profileImage == null
//                       ? Icon(Icons.person, size: 50, color: Colors.white)
//                       : null,
//                 ),

//                 const SizedBox(height: 10),

//                 // Name
//                 Text(
//                   user!.displayName ?? "No Name",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 // Email
//                 Text(
//                   user!.email ?? "No email",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),

//                 const SizedBox(height: 30),

//                 // My Profile Button
//                 ListTile(
//                   leading: Icon(Icons.person),
//                   title: Text("My Profile"),
//                   onTap: () async {
//                     await Navigator.push(
//                         context, MaterialPageRoute(builder: (_) => Myprofile()));

//                     // Reload the image when coming back
//                     _loadProfileImage();
//                   },
//                 ),

//                 ListTile(
//                   leading: Icon(Icons.privacy_tip),
//                   title: Text("Privacy policy"),
//                   onTap: () {},
//                 ),

//                 // Logout
//                 ListTile(
//                   leading: Icon(Icons.logout),
//                   title: Text(
//                     "Logout",
//                     style: TextStyle(color: Colors.redAccent),
//                   ),
//                   onTap: () async {
//                     await FirebaseAuth.instance.signOut();
//                     Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (_) => LoginScreen()),
//                         (route) => false);
//                   },
//                 ),
//               ],
//             ),
//     );
//   }
// }


import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_donation_app/views/privacy_policy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_donation_app/views/myprofile.dart';
import 'package:online_donation_app/views/signin_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  File? _profileImage;
  String? _localName;
  String? _localEmail;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    // Load image path
    final imagePath = prefs.getString('profileImagePath');
    if (imagePath != null) {
      _profileImage = File(imagePath);
    }

    // Load updated name & email if available
    _localName = prefs.getString('name');
    _localEmail = prefs.getString('email');

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: user == null
          ? const Center(child: Text("No user info"))
          : Column(
              children: [
                const SizedBox(height: 20),

                // Profile Image
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                      _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                ),

                const SizedBox(height: 10),

                // Name
                Text(
                  _localName ?? user!.displayName ?? "No Name",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Email
                Text(
                  _localEmail ?? user!.email ?? "No email",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 30),

                // My Profile Button
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("My Profile"),
                  onTap: () async {
                    await Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Myprofile()));

                    // Reload updated data when coming back
                    _loadProfileData();
                  },
                ),

                ListTile(
                  leading: Icon(Icons.privacy_tip),
                  title: Text("Privacy policy"),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => PrivacyPolicyScreen()));


                  },
                ),

                // Logout
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                        (route) => false);
                  },
                ),
              ],
            ),
    );
  }
}
