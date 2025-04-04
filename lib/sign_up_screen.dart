import 'package:flutter/material.dart';
import 'main.dart'; // Access registeredUsers
import 'bank_selection_screen.dart'; // Redirect here after registration

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Username", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                onPressed: () {
                  final username = usernameController.text.trim();
                  final password = passwordController.text.trim();

                  if (username.isNotEmpty && password.isNotEmpty) {
                    registeredUsers.add({
                      'username': username,
                      'password': password,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Registration successful!"),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // Redirect to BankSelectionScreen after sign up
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const BankSelectionScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill in all fields."),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
