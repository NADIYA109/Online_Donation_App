import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_donation_app/views/payment_screen.dart';

class DonationFormScreen extends StatefulWidget {
  final String category;

  const DonationFormScreen({super.key, required this.category});

  @override
  State<DonationFormScreen> createState() => _DonationFormScreenState();
}

class _DonationFormScreenState extends State<DonationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();


  late String currentDate;
  late String currentTime;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    currentDate = DateFormat('dd-MM-yyyy').format(now);
    currentTime = DateFormat('hh:mm a').format(now);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _amountController.dispose();
    _messageController.dispose();
    
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proceeding to Payment...')),
      );
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Form'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Category: ${widget.category}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
               // Full Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: Colors.black),   
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), 
                  ),
                  ),
                
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),   
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), 
                  ),
                  ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              // Phone Number
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.black),   
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), 
                  ),
                  ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              // Donation Amount
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Donation Amount (₹)', prefixText: '₹ ',
                labelStyle: TextStyle(color: Colors.black),  
                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black), 
                ),),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter donation amount';
                  }
                  if (double.tryParse(value.trim()) == null || double.parse(value.trim()) <= 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              // Message (optional)
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Message (optional)',
                  labelStyle: TextStyle(color: Colors.black),   
                  focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), 
                  ),),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Text('Date: $currentDate',
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              Text('Time: $currentTime',
                  style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  //onPressed: _submitForm,
                  onPressed: () {
                     if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,MaterialPageRoute(
                           builder: (_) => PaymentScreen(
                             name: _nameController.text,
                              email: _emailController.text,
                               phone: _phoneController.text,
                                amount: _amountController.text, 
                                ),
      ),
    );
  }
},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'Donate Now',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
