import 'package:flutter/material.dart';
import 'group_screen.dart'; // Import your group screen
import 'wallet_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String selectedTab = "Day";

  final List<Map<String, dynamic>> categories = [
    {"name": "Travel", "icon": Icons.card_travel, "color": Colors.greenAccent},
    {"name": "Food", "icon": Icons.fastfood, "color": Colors.tealAccent},
    {"name": "Entertainment", "icon": Icons.movie, "color": Colors.deepPurpleAccent},
    {"name": "Shopping", "icon": Icons.shopping_bag, "color": Colors.blueAccent},
    {"name": "Other", "icon": Icons.category, "color": Colors.grey},
    {"name": "Household", "icon": Icons.home, "color": Colors.orangeAccent},
    {"name": "Communication", "icon": Icons.phone, "color": Colors.pinkAccent},
    {"name": "Insurance", "icon": Icons.security, "color": Colors.indigoAccent},
    {"name": "Education", "icon": Icons.school, "color": Colors.cyanAccent},
    {"name": "Personal", "icon": Icons.person, "color": Colors.yellowAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, // Dark background
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.grey[500],
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() => _currentIndex = value);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Group'),
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _homeTab();
      case 1:
        return const GroupScreen();
      case 2:
        return const WalletScreen();
      case 3:
        return _centerText("Profile Page");
      default:
        return _homeTab();
    }
  }

  Widget _centerText(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 22),
      ),
    );
  }

  Widget _homeTab() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Cashualty",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.tealAccent),
              ),
              Icon(Icons.qr_code, color: Colors.white, size: 28),
            ],
          ),
          const SizedBox(height: 5),
          const Text("stopping cash casualties.", style: TextStyle(fontSize: 14, color: Colors.white70)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ["Day", "Week", "Month"].map((e) => _timePeriodTab(e)).toList(),
          ),
          const SizedBox(height: 20),
          if (selectedTab == "Day") _dayBlock(),
          if (selectedTab == "Week") _weekBlock(),
          if (selectedTab == "Month") _monthBlock(),
        ],
      ),
    );
  }

  Widget _timePeriodTab(String label) {
    final isSelected = selectedTab == label;
    return GestureDetector(
      onTap: () {
        setState(() => selectedTab = label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.tealAccent.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.tealAccent : Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget _dayBlock() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _walletCard("₹2045.2", "5 April 2025"),
            const SizedBox(height: 20),
            const Text("Spend Analysis", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 10),
            _categorySlider(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Transactions", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                Text("See All", style: TextStyle(fontSize: 16, color: Colors.tealAccent)),
              ],
            ),
            const SizedBox(height: 10),
            _transactionItem("Zomato", "-₹420", "Today • 6:32 PM"),
            _transactionItem("Amazon", "-₹1200", "Yesterday • 3:15 PM"),
          ],
        ),
      ),
    );
  }

  Widget _weekBlock() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _walletCard("₹8240.7", "Week Summary"),
            const SizedBox(height: 20),
            const Text("Spend Analysis", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 10),
            _categorySlider(),
          ],
        ),
      ),
    );
  }

  Widget _monthBlock() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _walletCard("₹19220.5", "April 2025 Total"),
            const SizedBox(height: 20),
            const Text("Spend Analysis", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 10),
            _categorySlider(),
          ],
        ),
      ),
    );
  }

  Widget _walletCard(String amount, String date) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.teal.shade400,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.wallet, size: 50, color: Colors.white),
          const SizedBox(height: 10),
          Text(amount, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(date, style: const TextStyle(fontSize: 14, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _categorySlider() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: _categoryCard(
              cat['name'],
              "${(10 + cat['name'].length * 2) % 50 + 10}%",
              cat['icon'],
              cat['color'],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _categoryCard(String title, String percentage, IconData icon, Color color) {
    final percent = int.parse(percentage.replaceAll('%', ''));
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 5),
          Text(percentage, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: percent / 100,
            backgroundColor: Colors.white24,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.white70), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _transactionItem(String title, String amount, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                child: const Icon(Icons.account_balance_wallet, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(time, style: const TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ],
          ),
          Text(amount, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
        ],
      ),
    );
  }
}
