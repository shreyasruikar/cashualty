import 'package:flutter/material.dart';
import 'bills_subscriptions_screen.dart'; // Import the next screen

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Large "Bank Details" text at the top
              const Text(
                "Bank Details",
                style: TextStyle(
                  fontSize: 40, // Bigger text
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 30),

              // Account Number Field
              const Text("Account No.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const TextField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // IFSC Code Field
              const Text("IFSC Code", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const TextField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // UPI ID Field
              const Text("UPI ID", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const TextField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Full-width "Continue" button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BillsSubscriptionsScreen()),
                    );
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Skip for now option
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BillsSubscriptionsScreen()),
                    );
                  },
                  child: const Text(
                    "Skip for now",
                    style: TextStyle(color: Colors.teal, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 40), // Extra bottom space
            ],
          ),
        ),
      ),
    );
  }
}
