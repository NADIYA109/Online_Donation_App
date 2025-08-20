import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonationHistoryScreen extends StatelessWidget {
  const DonationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userEmail = currentUser?.email ?? "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation History"),
       ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('donations')
            .where('email', isEqualTo: userEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Something went wrong while loading donations.",
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(  
                "No donations found.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final donations = snapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList()
            ..sort((a, b) {
              try {
                final aDate = _parseDate(a['date']);
                final bDate = _parseDate(b['date']);
                return bDate.compareTo(aDate);
              } catch (_) {
                return 0;
              }
            });

          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: donations.length,
            itemBuilder: (context, index) {
              var donation = donations[index];
              return _buildDonationCard(donation);
            },
          );
        },
      ),
    );
  }

  static DateTime _parseDate(String date) {
    final parts = date.split('-'); 
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  Widget _buildDonationCard(Map<String, dynamic> donation) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 85, 173, 246),
              Color.fromARGB(255, 43, 146, 231)  
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "₹${donation["amount"] ?? "0"}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    donation["date"] ?? "",
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  Text(
                    donation["time"] ?? "",
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  color: (donation["status"] ?? "").toLowerCase() == "success"
                      ? Colors.green.withOpacity(0.8)
                      : Colors.red.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  donation["status"] ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Payment ID: ${donation["paymentId"] ?? ""}",
                style: const TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
