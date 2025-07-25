import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_donation_app/views/myprofile.dart';
import 'package:online_donation_app/views/signin_screen.dart';

class ProfileScreen extends StatelessWidget{
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.white,
        ),
        body: user == null 
        ? const Center(
          child: Text("No uer info")) 
          : Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size:50, color: Colors.white),
                ),
              const SizedBox(height: 10),
              Text(
                user!.displayName ?? "No Name",
                style: TextStyle(
                  color: Colors.black ,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(user!.email ?? "No email", 
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),),

              SizedBox(height: 30,),
              
              ListTile(
                leading: Icon(Icons.person),
                title: Text("My Profile"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => Myprofile()));

                },
              ),

              ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text("Privacy policy"),
                onTap: () {},
              ),

              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout" , style: TextStyle(
                  color: Colors.redAccent
                ),),

                onTap: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
                },
              ),
              
              
            ],
          )
        );
    
  }

}
