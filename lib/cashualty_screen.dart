import 'package:flutter/material.dart';
import 'sign_in_screen.dart'; // Import the SignInScreen

class CashualtyScreen extends StatelessWidget {
  const CashualtyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title at the top-left
              const Padding(
                padding: EdgeInsets.only(top: 35.0),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: 'Cash', style: TextStyle(color: Colors.teal)),
                      TextSpan(text: 'ualty', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),

              // Centered Bigger Image
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/splash1.png',
                    width: MediaQuery.of(context).size.width * 1, // 80% of screen width
                    height: MediaQuery.of(context).size.height * 1, // Adjust height dynamically
                    fit: BoxFit.contain, // Ensure it fits well
                  ),
                ),
              ),

              // CFO Mode Text
              Center(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    children: [
                      TextSpan(text: 'CFO mode: '),
                      TextSpan(text: 'ON', style: TextStyle(color: Colors.teal)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Full-Width Button at the Bottom
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
                      MaterialPageRoute(builder: (context) => const SignInScreen()),
                    );
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20), // Space from bottom
            ],
          ),
        ),
      ),
    );
  }
}
