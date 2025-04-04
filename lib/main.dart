import 'package:flutter/material.dart';
import 'cashualty_screen.dart';  // Import the screen file

// --- Global User Model ---


// --- Global Variables ---
String currentUser = "";
List<Map<String, String>> registeredUsers = [];  // [{username: 'abc', password: '123'}, ...]

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,  // Hides debug banner
      home: CashualtyScreen(),  // Calls the stateless widget
    );
  }
}
