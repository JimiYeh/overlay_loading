import 'package:flutter/material.dart';
import 'new_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首頁'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text('這是首頁內容'),
      ),
      // 添加浮動按鈕
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 導航到新頁面
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewScreen()),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
