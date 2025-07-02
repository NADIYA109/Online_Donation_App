// import 'package:flutter/material.dart';
// import 'donation_form_screen.dart';

// class CategoryDetailsScreen extends StatelessWidget {
//   final String category;

//   CategoryDetailsScreen({required this.category});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("$category",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
//       ),
//       // body: Padding(
//       //   padding: const EdgeInsets.all(16.0),
//       //   child: Column(
//       //     crossAxisAlignment: CrossAxisAlignment.start,
//       //     children: [
//       //       Text(
//       //         "$category",
//       //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       //       ),
//       //       SizedBox(height: 10),
//             // Text(
//             //   "Details about $category and how your donations can help.",
//             //   style: TextStyle(fontSize: 16),
//             // ),
//             Spacer(),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => DonationFormScreen(category: category)),
//                   );
//                 },
//                 child: Text("Donate Now"),
//               ),
//             ),
//             );
//          },
          
        
      
    
//   }


// import 'package:flutter/material.dart';
// import 'donation_form_screen.dart';

// class CategoryDetailsScreen extends StatelessWidget {
//   final String category;

//   CategoryDetailsScreen({required this.category});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           category, // shows the selected category name
//           style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const Spacer(),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => DonationFormScreen(category: category),
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blueAccent,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: const Text(
//                   "Donate Now",
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:online_donation_app/views/donation_screen.dart';
import 'donation_form_screen.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String category;

  CategoryDetailsScreen({required this.category});

  final Map<String, String> categoryImages = {
    'Education': 'assets/education.jpg',
    'Healthcare': 'assets/medical.jpg',
    'Disaster Relief': 'assets/disaster.jpeg',
    'Community Support': 'assets/community.jpg',
    'Animal Welfare': 'assets/animal.jpeg',
  };

  final Map<String, String> categoryDescriptions = {
  'Education': 'Education is the most powerful tool to transform lives. Unfortunately, millions of children around the world are still deprived of basic learning due to poverty. Your donation can help break this cycle. It can provide school supplies, books, uniforms, and digital learning tools to underprivileged students. With your support, we can build classrooms in rural areas, train passionate teachers, and run awareness campaigns for the importance of education. Every rupee you contribute is a step towards creating a literate, confident, and empowered generation that can shape a better tomorrow.',

  'Healthcare': 'Healthcare is a basic human right, yet it remains a distant dream for many. Every day, people suffer or die from preventable diseases just because they cannot afford treatment. Your generous support can help provide life-saving surgeries, medicines, and diagnostic tests to those in need. It can also fund health camps in remote villages, support maternal and child care, and strengthen hospitals with essential equipment. When you donate, you don’t just give money — you give someone a chance at life, a moment of relief, and a future of hope.',

  'Disaster Relief': 'Natural disasters can strike without warning and turn lives upside down in seconds. From floods to earthquakes, fires to pandemics, millions lose their homes, loved ones, and livelihoods every year. In such times of crisis, your donation becomes a lifeline. It helps deliver emergency food, clean water, temporary shelter, warm clothing, and medical support to affected families. But more than that, it gives them strength to stand again. Your help ensures that recovery is faster, organized, and filled with dignity for those rebuilding their lives.',

  'Community Support': 'Strong communities build strong nations. Many communities still lack access to clean water, proper sanitation, basic education, and livelihood opportunities. Your contribution can make a real difference by supporting grassroots development initiatives like building toilets, setting up vocational training centers, ensuring clean drinking water, and empowering women through self-help groups. Investing in communities means creating long-term solutions that uplift entire families, promote equality, and ensure that no one is left behind. Together, we can build a world where every community thrives.',

  'Animal Welfare': 'Animals too deserve love, care, and protection. Sadly, thousands of animals suffer daily due to abandonment, abuse, or injury. By donating to animal welfare, you help rescue helpless animals, provide them with food, shelter, and medical care, and give them a second chance at life. Your support also strengthens awareness drives, sterilization programs, and campaigns against cruelty. Whether it’s saving a street dog, caring for injured birds, or supporting animal shelters — every small act of kindness helps build a compassionate society for all living beings.',
  };

  @override
  Widget build(BuildContext context) {
    final imageUrl = categoryImages[category]!;
    final description = categoryDescriptions[category]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 80), // Give space for button
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top image
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              // Description
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Fixed bottom button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DonationFormScreen(category: category),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Donate Now",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

