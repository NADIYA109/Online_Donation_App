import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Privacy Policy",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Privacy Policy",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "We respect your privacy and are committed to protecting the personal information you share with us. "
                "This Privacy Policy outlines how we collect, use, and safeguard your data when you use our application.\n\n"
                "1. Information We Collect:\n"
                "- Personal details such as name, email address, and profile photo.\n"
                "- Usage data including device type, operating system, and app usage patterns.\n"
                "- Any information voluntarily provided through feedback forms or support requests.\n\n"
                "2. How We Use Your Information:\n"
                "- To personalize and improve your app experience.\n"
                "- To provide customer support and respond to inquiries.\n"
                "- To analyze app usage for performance improvements.\n"
                "- To send important updates and notifications.\n\n"
                "3. Data Sharing:\n"
                "We do not sell, trade, or rent your personal information to third parties. "
                "We may share your information only when required by law or to protect our legal rights.\n\n"
                "4. Data Security:\n"
                "We implement industry-standard security measures to protect your personal information. "
                "However, no method of transmission over the internet is 100% secure, and we cannot guarantee absolute security.\n\n"
                "5. Third-Party Services:\n"
                "Our app may use third-party services (such as analytics or authentication) that have their own privacy policies. "
                "We recommend reviewing those policies for more information.\n\n"
                "6. Your Rights:\n"
                "- You can update or correct your personal information through the app settings.\n"
                "- You may request the deletion of your account and associated data.\n"
                "- You can opt-out of marketing communications at any time.\n\n"
                "7. Changes to This Privacy Policy:\n"
                "We may update this policy from time to time. We will notify you of any significant changes "
                "through the app or via email.\n\n"
                "By using our application, you agree to this Privacy Policy. If you do not agree, please discontinue using the app.\n\n"
                "Contact Us:\n"
                "If you have any questions or concerns about this Privacy Policy, please contact us at support@onlinedonation.com.",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
