import 'package:flutter/material.dart';
import 'package:overlay_loading/component/loading_screen.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新頁面'),
        // 自動添加返回按鈕
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text('這是新頁面的內容'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          LoadingScreen().show(context: context, text: 'Loading...');
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
