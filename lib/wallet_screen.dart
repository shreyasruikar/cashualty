import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double balance = 1820;
  List<Map<String, dynamic>> transactions = [
    {'title': 'Groceries', 'amount': 250, 'isIncome': false, 'date': 'April 1, 2025'},
    {'title': 'Salary', 'amount': 5000, 'isIncome': true, 'date': 'April 1, 2025'},
    {'title': 'Electricity Bill', 'amount': 1200, 'isIncome': false, 'date': 'March 30, 2025'},
    {'title': 'Freelance Work', 'amount': 2000, 'isIncome': true, 'date': 'March 28, 2025'},
  ];

  void _addTransaction(String title, double amount, bool isIncome) {
    if (!isIncome && balance - amount < 0) {
      _showInsufficientBalanceDialog();
      return;
    }
    setState(() {
      balance += isIncome ? amount : -amount;
      transactions.insert(0, {
        'title': title,
        'amount': amount,
        'isIncome': isIncome,
        'date': 'Today',
      });
    });
  }

  void _showInsufficientBalanceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Insufficient Balance'),
          content: const Text('You do not have enough balance to make this expense.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAddTransactionDialog(bool isIncome) {
    TextEditingController titleController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isIncome ? 'Add Income' : 'Add Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String title = titleController.text.trim();
                double? amount = double.tryParse(amountController.text.trim());
                if (title.isNotEmpty && amount != null && amount > 0) {
                  _addTransaction(title, amount, isIncome);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Wallet',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '₹${balance.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'available balance',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: transaction['isIncome'] ? Colors.green.shade100 : Colors.red.shade100,
                        child: Icon(
                          transaction['isIncome'] ? Icons.arrow_downward : Icons.arrow_upward,
                          color: transaction['isIncome'] ? Colors.green : Colors.red,
                        ),
                      ),
                      title: Text(transaction['title'] ?? 'Unknown'),
                      subtitle: Text(transaction['date'] ?? 'Unknown Date'),
                      trailing: Text(
                        "${transaction['isIncome'] ? '+' : '-'}₹${transaction['amount'].toStringAsFixed(2)}",
                        style: TextStyle(
                          color: transaction['isIncome'] ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () => _showAddTransactionDialog(true),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () => _showAddTransactionDialog(false),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
