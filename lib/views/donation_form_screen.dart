import 'package:flutter/material.dart';

class DonationFormScreen extends StatelessWidget {
  final String category;

  DonationFormScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donate to $category"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter Donation Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: "Full Name"),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Donation Amount"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Message (Optional)"),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implement donation logic here
                  print("Donation successful!");
                },
                child: Text("Donate Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
