import 'package:flutter/material.dart';
import 'bank_details_screen.dart'; // Import the BankDetailsScreen

class BankSelectionScreen extends StatefulWidget {
  const BankSelectionScreen({super.key});

  @override
  State<BankSelectionScreen> createState() => _BankSelectionScreenState();
}

class _BankSelectionScreenState extends State<BankSelectionScreen> {
  int? _selectedBankIndex; // Track selected bank

  final List<String> bankLogos = [
    "assets/images/sbilogo.png",
    "assets/images/hdfclogo.png",
    "assets/images/citilogo.png",
    "assets/images/hsbclogo.png",
    "assets/images/axislogo.png",
    "assets/images/icicilogo.png",
    "assets/images/barclayslogo.png",
    "assets/images/idbilogo.png",
    "assets/images/boblogo.png",
  ];

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

              // Large "Select Your Bank" text at the top
              const Text(
                "Select Your Bank",
                style: TextStyle(
                  fontSize: 40, // Bigger text
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 30),

              // Bank Grid
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: bankLogos.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedBankIndex = index; // Select only one bank
                        });
                      },
                      child: _buildBankIcon(bankLogos[index], index == _selectedBankIndex),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // Full-width "Continue" button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedBankIndex != null ? Colors.teal : Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _selectedBankIndex != null
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BankDetailsScreen()),
                    );
                  }
                      : null, // Disable button if no bank is selected
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.white, fontSize: 18),
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

  Widget _buildBankIcon(String imagePath, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.teal.withOpacity(0.2) : Colors.white,
        border: Border.all(color: isSelected ? Colors.teal : Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
