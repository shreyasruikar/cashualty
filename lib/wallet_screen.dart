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
          title: const Text('Insufficient Balance', style: TextStyle(color: Colors.blue)),
          content: const Text('You do not have enough balance to make this expense.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK', style: TextStyle(color: Colors.blue)),
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
          title: Text(
            isIncome ? 'Add Income' : 'Add Expense',
            style: const TextStyle(color: Colors.blue),
          ),
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
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
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
              child: const Text('Add', style: TextStyle(color: Colors.blue)),
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
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
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
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
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
                    'Available Balance',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Transactions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: transaction['isIncome']
                            ? Colors.blue.shade100
                            : Colors.grey.shade300,
                        child: Icon(
                          transaction['isIncome']
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color: transaction['isIncome']
                              ? Colors.blue.shade800
                              : Colors.black87,
                        ),
                      ),
                      title: Text(
                        transaction['title'] ?? 'Unknown',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        transaction['date'] ?? 'Unknown Date',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      trailing: Text(
                        "${transaction['isIncome'] ? '+' : '-'}₹${transaction['amount'].toStringAsFixed(2)}",
                        style: TextStyle(
                          color: transaction['isIncome']
                              ? Colors.blue.shade800
                              : Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
            backgroundColor: Colors.blue.shade800,
            onPressed: () => _showAddTransactionDialog(true),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            backgroundColor: Colors.grey.shade800,
            onPressed: () => _showAddTransactionDialog(false),
            child: const Icon(Icons.remove, color: Colors.white),
          ),
        ],
      ),
    );
  }
}