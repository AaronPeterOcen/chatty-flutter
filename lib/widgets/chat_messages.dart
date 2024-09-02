import 'package:chatfl/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// FlutterError
class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(
              'chat') // Reference to the 'chat' collection in Firestore.
          .orderBy(
            'createdAt', // Sort messages by their 'createdAt' field.
            descending: true, // Sort in ascending order (oldest first).
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
          reverse: true,
          padding: const EdgeInsets.only(bottom: 35, left: 13.5, right: 13.5),
          itemCount: listText.length, // Number of messages to display.
          itemBuilder: (context, index) {
            // listText[index].data()['text'], // Display the message text.
            final chatMsg = listText[index].data();
            final nextChatMsg =
                index + 1 < listText.length ? listText[index + 1].data() : null;
            final currentMsgUserId = chatMsg['userId'];
            final nextMsgUserId =
                nextChatMsg != null ? nextChatMsg['userId'] : null;

            final nextUserIsSame = nextMsgUserId == currentMsgUserId;

            if (nextUserIsSame) {
              return MessageBubble.next(
                message: chatMsg['text'],
                isMe: authUser.uid == currentMsgUserId,
              );
            } else {
              return MessageBubble.first(
                  userImage: chatMsg['userImage'],
                  username: chatMsg['username'],
                  message: chatMsg['text'],
                  isMe: authUser.uid == currentMsgUserId);
            }
          },
        );
      },
    );
  }
}
