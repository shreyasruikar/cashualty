import 'package:flutter/material.dart';
import 'home_screen.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final tripNameController = TextEditingController();
  final memberController = TextEditingController();
  final amountController = TextEditingController();

  String selectedSplitType = "Equal";
  List<String> members = [];
  Map<String, List<Map<String, dynamic>>> payments = {};
  Map<String, TextEditingController> individualControllers = {};

  String currentTrip = '';
  bool tripCreated = false;
  double _totalPaymentAmount = 0;

  void addMember() {
    final name = memberController.text.trim();
    if (name.isNotEmpty && !members.contains(name)) {
      setState(() {
        members.add(name);
        memberController.clear();
      });
    }
  }

  void createTrip() {
    if (_formKey.currentState!.validate()) {
      if (tripNameController.text.trim().isNotEmpty && members.isNotEmpty) {
        setState(() {
          currentTrip = tripNameController.text.trim();
          payments[currentTrip] = [];
          tripCreated = true;
        });
      }
    }
  }

  void addPayment() {
    if (!_formKey.currentState!.validate()) return;

    final enteredAmount = double.tryParse(amountController.text.trim());
    if (enteredAmount == null) return;

    if (selectedSplitType == "Individual") {
      final totalContribution = members.fold(0.0, (sum, member) {
        final controller = individualControllers[member];
        final val = double.tryParse(controller?.text ?? '0') ?? 0;
        return sum + val;
      });

      if (totalContribution != enteredAmount) {
        _showContributionError(totalContribution, enteredAmount);
        return;
      }
    }

    _processPayment(enteredAmount);
  }

  void _processPayment(double amount) {
    Map<String, double> splitDetails = {};

    if (selectedSplitType == "Equal") {
      final splitAmount = amount / members.length;
      for (var member in members) {
        splitDetails[member] = splitAmount;
      }
    } else {
      for (var member in members) {
        final controller = individualControllers[member];
        final val = double.tryParse(controller?.text ?? '0') ?? 0;
        splitDetails[member] = val;
      }
    }

    setState(() {
      payments[currentTrip]!.add(splitDetails.map((k, v) => MapEntry(k, {'amount': v})));
      amountController.clear();
      individualControllers.clear();
    });
  }

  void _showContributionError(double totalContribution, double tripAmount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contribution Error'),
        content: Text(
          'Total contributions: ₹${totalContribution.toStringAsFixed(2)}\n'
              'Payment amount: ₹${tripAmount.toStringAsFixed(2)}\n\n'
              'Contributions must exactly match the payment amount!',
        ),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildIndividualSplitFields() {
    return Column(
      children: members.map((member) {
        individualControllers[member] = TextEditingController();
        return TextFormField(
          controller: individualControllers[member],
          decoration: InputDecoration(
            labelText: "$member's amount",
            errorStyle: const TextStyle(fontSize: 12),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Enter amount';
            final amount = double.tryParse(value);
            if (amount == null || amount <= 0) return 'Invalid amount';
            return null;
          },
        );
      }).toList(),
    );
  }

  Widget buildTripSummary() {
    Map<String, double> totalPerPerson = {};
    for (var payment in payments[currentTrip]!) {
      payment.forEach((name, item) {
        totalPerPerson[name] = (totalPerPerson[name] ?? 0) + (item['amount'] ?? 0);
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          'Final Split Summary:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...totalPerPerson.entries.map(
              (e) => Card(
            elevation: 2,
            child: ListTile(
              title: Text(e.key),
              trailing: Text("₹${e.value.toStringAsFixed(2)}"),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            child: const Text("Request Payment"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("Trip Manager", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!tripCreated) ...[
                const Text("Create New Trip", style: TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                TextFormField(
                  controller: tripNameController,
                  decoration: const InputDecoration(
                    labelText: "Trip Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter trip name';
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: memberController,
                        decoration: const InputDecoration(
                          labelText: "Add Member",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (tripCreated) return null;
                          if (value == null || value.isEmpty) return 'Enter member name';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: addMember,
                      child: const Text("Add"),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: members.map((m) => Chip(label: Text(m))).toList(),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: createTrip,
                  child: const Text("Create Trip"),
                ),
              ] else ...[
                Text("Trip: $currentTrip", style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                const Text("New Payment", style: TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    labelText: "Total Amount",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter amount';
                    final amount = double.tryParse(value);
                    if (amount == null || amount <= 0) return 'Invalid amount';
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Split Type Dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Split Type:", style: TextStyle(fontSize: 16)),
                    DropdownButton<String>(
                      value: selectedSplitType,
                      onChanged: (val) => setState(() => selectedSplitType = val!),
                      items: const [
                        DropdownMenuItem(value: "Equal", child: Text("Equal")),
                        DropdownMenuItem(value: "Individual", child: Text("Individual")),
                      ],
                    ),
                  ],
                ),

                if (selectedSplitType == "Individual") _buildIndividualSplitFields(),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: addPayment,
                  child: const Text("Add Payment"),
                ),
                const SizedBox(height: 30),
                if (payments[currentTrip]!.isNotEmpty) buildTripSummary(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}