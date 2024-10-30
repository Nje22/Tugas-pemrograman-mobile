// main.dart
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
      // Set LoginPage sebagai halaman pertama
      home: const LoginPage(),
    );
  }
}

// Halaman Login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Contoh login sederhana, cek username dan password
    if (username == 'admin' && password == '1234') {
      setState(() {
        _errorMessage = ''; // Bersihkan pesan kesalahan
      });
      // Jika login berhasil, navigasikan ke MainPage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } else {
      setState(() {
        _errorMessage =
            'Username atau Password salah'; // Tampilkan pesan kesalahan
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true, // Sembunyikan password
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

// Halaman Utama (Main Page)
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

  void _showAddTransactionDialog(BuildContext context) {
    final _categoryController = TextEditingController();
    final _amountController = TextEditingController();
    String _transactionType = 'income';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Transaksi Baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Jumlah'),
              ),
              DropdownButton<String>(
                value: _transactionType,
                items: [
                  const DropdownMenuItem(
                    value: 'income',
                    child: Text('Pemasukan'),
                  ),
                  const DropdownMenuItem(
                    value: 'outcome',
                    child: Text('Pengeluaran'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _transactionType = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                final String category = _categoryController.text;
                final int amount = int.tryParse(_amountController.text) ?? 0;
                if (category.isNotEmpty && amount > 0) {
                  _addTransaction(category, amount, _transactionType);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
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
          _showAddTransactionDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
