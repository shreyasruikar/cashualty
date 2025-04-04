import 'package:flutter/material.dart';
import 'sign_in_screen.dart'; // Make sure the path is correct

class ExpenseHabitsScreen extends StatefulWidget {
  const ExpenseHabitsScreen({super.key});

  @override
  _ExpenseHabitsScreenState createState() => _ExpenseHabitsScreenState();
}

class _ExpenseHabitsScreenState extends State<ExpenseHabitsScreen> {
  final List<Map<String, dynamic>> categories = [
    {"name": "Travel", "icon": Icons.card_travel},
    {"name": "Food", "icon": Icons.fastfood},
    {"name": "Entertainment", "icon": Icons.movie},
    {"name": "Shopping", "icon": Icons.shopping_bag},
    {"name": "Other", "icon": Icons.category},
    {"name": "Household", "icon": Icons.home},
    {"name": "Communication", "icon": Icons.phone},
    {"name": "Insurance", "icon": Icons.security},
    {"name": "Education", "icon": Icons.school},
    {"name": "Personal", "icon": Icons.person},
  ];

  Set<String> selectedCategories = {}; // Track selected categories

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Expense Habits",
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Category Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategories.contains(category["name"]);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedCategories.remove(category["name"]);
                        } else {
                          selectedCategories.add(category["name"]);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.teal.withOpacity(0.2) : Colors.white,
                        border: Border.all(color: isSelected ? Colors.teal : Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(category["icon"], size: 30, color: Colors.teal),
                          const SizedBox(height: 5),
                          Text(category["name"], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Full-width Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  // Navigate to the SignInScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()),
                  );
                },
                child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
