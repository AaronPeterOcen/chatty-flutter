import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('chatty'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance
                    .signOut(); // adding log out functionality with the firebaseauth package
              },
              icon: Icon(
                Icons.exit_to_app_rounded,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ))
        ],
      ),
      body: const Center(
        child: Text('user logged in '),
      ),
    );
  }
}

// FlutterError