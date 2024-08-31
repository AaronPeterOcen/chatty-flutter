import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chatty'),
      ),
      body: const Center(
        child: Text('loading... '),
      ),
    );
  }
}

// FlutterError