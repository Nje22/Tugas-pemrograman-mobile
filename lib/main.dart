import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengelolaan Keuangan',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, dynamic>> transactions = [
    {'amount': 2000000, 'category': 'Salary', 'type': 'income'},
    {'amount': 20000, 'category': 'Food', 'type': 'outcome'},
  ];

  void _addTransaction(String category, int amount, String type) {
    setState(() {
      transactions.add({'amount': amount, 'category': category, 'type': type});
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalIncome = transactions
        .where((transaction) => transaction['type'] == 'income')
        .fold<int>(
            0, (sum, transaction) => sum + (transaction['amount'] as int));

    int totalOutcome = transactions
        .where((transaction) => transaction['type'] == 'outcome')
        .fold<int>(
            0, (sum, transaction) => sum + (transaction['amount'] as int));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengelolaan Keuangan'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text('October 2022',
                    style: TextStyle(color: Colors.white, fontSize: 24)),
                const SizedBox(height: 10),
                Text('Income: Rp $totalIncome',
                    style: const TextStyle(color: Colors.white)),
                Text('Outcome: Rp $totalOutcome',
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  title: Text('${transaction['category']}'),
                  subtitle: Text('Rp ${transaction['amount']}'),
                  trailing: Icon(
                    transaction['type'] == 'income'
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                    color: transaction['type'] == 'income'
                        ? Colors.green
                        : Colors.red,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logika untuk menambah transaksi baru
          // Di sini, Anda bisa menampilkan dialog untuk menambah transaksi
          _addTransaction('New Category', 100000, 'income');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
