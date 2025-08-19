import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdatesScreen extends StatelessWidget {
  const UpdatesScreen({super.key});

  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color lightBlue1 = Color(0xFF64B5F6);
  static const Color lightBlue2 = Color(0xFF90CAF9);

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser?.email ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Updates'),
        //backgroundColor: primaryBlue,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("notifications")
            //  show only notifications that belong to this user (no "all")
            .where("recipients", arrayContains: userEmail)
            //.where('email', isEqualTo: userEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Something went wrong.",
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No updates available"));
          }

          //  sort by string date descending (latest first)
          final notifications = snapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList()
            ..sort((a, b) {
              final aDate = a['date'] ?? '';
              final bDate = b['date'] ?? '';
              return bDate.compareTo(aDate);
            });

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: notifications.length,
            itemBuilder: (_, i) => _buildCard(notifications[i]),
          );
        },
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> n) {
    final String dateStr =
        '${n["date"] ?? ""}  ${n["time"] ?? ""}';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [lightBlue1, lightBlue2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          title: Text(
            n["title"] ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                n["body"] ?? "",
                style: const TextStyle(color: Colors.white, height: 1.3),
              ),
              const SizedBox(height: 8),
              Text(
                dateStr,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
