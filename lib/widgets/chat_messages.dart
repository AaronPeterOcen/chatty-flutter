import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// FlutterError
class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(
              'chat') // Reference to the 'chat' collection in Firestore.
          .orderBy(
            'createdAt', // Sort messages by their 'createdAt' field.
            descending: false, // Sort in ascending order (oldest first).
          )
          .snapshots(), // Listen for real-time updates from Firestore.
      builder: (context, chatSnapshot) {
        // While waiting for the data, show a loading spinner.
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(), // Loading indicator.
          );
        }

        // Check if there's no data or the chat is empty and show a message.
        if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
          return const Center(
            child:
                Text('No messages yet'), // Display when no messages are found.
          );
        }

        // Handle errors and display an error message.
        if (chatSnapshot.hasError) {
          return const Center(
            child: Text('Something went wrong!!!'), // Display on error.
          );
        }

        // Extract the list of chat documents from the snapshot.
        final listText = chatSnapshot.data!.docs;
        return ListView.builder(
          itemCount: listText.length, // Number of messages to display.
          itemBuilder: (context, index) => Text(
            listText[index].data()['text'], // Display the message text.
          ),
        );
      },
    );
  }
}
