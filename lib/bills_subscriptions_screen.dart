import 'package:flutter/material.dart';
import 'expense_habits_screen.dart';

class BillsSubscriptionsScreen extends StatefulWidget {
  const BillsSubscriptionsScreen({super.key});

  @override
  _BillsSubscriptionsScreenState createState() => _BillsSubscriptionsScreenState();
}

class _BillsSubscriptionsScreenState extends State<BillsSubscriptionsScreen> {
  List<Map<String, dynamic>> autoDebits = [

  ];

  void _addNewBill() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Bill"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Bill Name"),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: "Due Date (e.g., 15 Apr 2025)"),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Amount (₹)"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    dateController.text.isNotEmpty &&
                    amountController.text.isNotEmpty) {
                  double? amount = double.tryParse(amountController.text);
                  if (amount != null) {
                    setState(() {
                      autoDebits.add({
                        "name": nameController.text,
                        "dueDate": dateController.text,
                        "amount": amount,
                      });
                    });
                    Navigator.pop(context);
                  }
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    ).then((_) {
      nameController.dispose();
      dateController.dispose();
      amountController.dispose();
    });
  }

  Widget _buildAutoDebitItem(String name, String dueDate, double amount, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.teal, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Due: $dueDate", style: const TextStyle(color: Colors.grey)),
            ],
          ),
          Row(
            children: [
              Text(
                "₹${amount.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    autoDebits.removeAt(index);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

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
              const Text(
                "Bills & Subscriptions",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Auto-Debit from Your Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    "Add New Bill",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: _addNewBill,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: autoDebits.length,
                  itemBuilder: (context, index) {
                    final bill = autoDebits[index];
                    return _buildAutoDebitItem(
                      bill["name"] as String,
                      bill["dueDate"] as String,
                      (bill["amount"] as num).toDouble(),
                      index,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
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
                      MaterialPageRoute(builder: (context) => const ExpenseHabitsScreen()),
                    );
                  },
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
                      MaterialPageRoute(builder: (context) => const ExpenseHabitsScreen()),
                    );
                  },
                  child: const Text(
                    "Skip for now",
                    style: TextStyle(color: Colors.teal, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
