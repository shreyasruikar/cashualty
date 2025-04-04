import 'package:flutter/material.dart';
import 'bills_subscriptions_screen.dart'; // Import the next screen

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  _BankDetailsScreenState createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _accountNoController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();

  String? _validateAccountNo(String? value) {
    if (value == null || value.isEmpty) {
      return "Account number is required";
    }
    if (!RegExp(r'^\d{9,18}$').hasMatch(value)) {
      return "Enter a valid account number (9-18 digits)";
    }
    return null;
  }

  String? _validateIFSC(String? value) {
    if (value == null || value.isEmpty) {
      return "IFSC code is required";
    }
    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(value)) {
      return "Enter a valid IFSC code";
    }
    return null;
  }

  String? _validateUPI(String? value) {
    if (value == null || value.isEmpty) {
      return "UPI ID is required";
    }
    if (!RegExp(r'^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$').hasMatch(value)) {
      return "Enter a valid UPI ID (e.g. yourname@upi)";
    }
    return null;
  }

  void _onContinue() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BillsSubscriptionsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // ✅ Added ScrollView Fix
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                const Text(
                  "Bank Details",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 30),

                const Text("Account No.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _accountNoController,
                  keyboardType: TextInputType.number,
                  autofillHints: null,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  ),
                  validator: _validateAccountNo,
                ),

                const SizedBox(height: 20),

                const Text("IFSC Code", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _ifscController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  autofillHints: null,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  ),
                  validator: _validateIFSC,
                ),

                const SizedBox(height: 20),

                const Text("UPI ID", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _upiController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: null,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  ),
                  validator: _validateUPI,
                ),

                const SizedBox(height: 30),

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
                    onPressed: _onContinue,
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

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

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
