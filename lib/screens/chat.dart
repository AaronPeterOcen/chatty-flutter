import 'package:chatfl/widgets/chat_messages.dart';
import 'package:chatfl/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupNoticationsPush() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();

    // await fcm.getToken();
    // print(token);

    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();

    setupNoticationsPush();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('chatty'),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
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
        body: const Column(
          children: [
            Expanded(child: ChatMessages()),
            NewMessage(),
          ],
        ));
  }
}

// FlutterError
