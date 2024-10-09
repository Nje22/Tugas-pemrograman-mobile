// pages/main_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(Icons.add), // Menggunakan Icon, bukan Icons
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home), // Tambahkan const
            ),
            const SizedBox(width: 20), // Tambahkan titik koma
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.list), // Tambahkan const dan titik koma
            ),
          ],
        ),
      ),
    );
  }
}
