import 'package:flutter/material.dart';
import 'donation_form_screen.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String category;

  CategoryDetailsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$category Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$category",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Details about $category and how your donations can help.",
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DonationFormScreen(category: category)),
                  );
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
