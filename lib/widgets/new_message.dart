import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// This widget allows users to compose and send a new message.
// It includes a text field for entering the message and a button to submit it.
class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

// State class for the NewMessage widget.
// Manages the text field input and submission behavior.
class _NewMessageState extends State<NewMessage> {
  // Controller to manage and listen to changes in the TextField input.
  final _messageController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the widget tree.
    // This prevents memory leaks by cleaning up resources.
    _messageController.dispose();
    super.dispose();
  }

  // Function to handle the submission of the message.
  void submitMessage() async {
    // Retrieve the text entered by the user.
    final enteredMessage = _messageController.text;

    // If the entered message is empty or contains only whitespace, do nothing.
    if (enteredMessage.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();

    // Fetch the currently authenticated user from Firebase Authentication.
// The '!' operator asserts that the current user is not null.
    final user = FirebaseAuth.instance.currentUser!;

// Fetch the user's document from the 'users' collection in Firestore using the user's unique ID (uid).
// This is done to retrieve additional user data like username and profile image.
    final userData = await FirebaseFirestore.instance
        .collection(
            'users') // Reference to the 'users' collection in Firestore.
        .doc(user.uid) // Reference to the document with the user's UID.
        .get(); // Get the document snapshot asynchronously.

// Add a new document to the 'chat' collection in Firestore with the message and user details.
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage, // The message text entered by the user.
      'createdAt': Timestamp
          .now(), // The current timestamp to record when the message was created.
      'userId': user.uid, // The UID of the user sending the message.
      'username': userData
          .data()!['user'], // The username of the user, fetched from Firestore.
      'userImage': userData.data()![
          'image'], // The user's profile image URL, fetched from Firestore.
    });

    // Clear the TextField after the message is submitted.
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 11),
      // A row that contains the TextField for message input and a submit button.
      child: Row(
        children: [
          // Expanded widget allows the TextField to occupy the available width.
          Expanded(
            child: TextField(
              // Binds the TextField to the controller to retrieve and manage input text.
              controller: _messageController,
              // Capitalizes the first letter of each sentence automatically.
              textCapitalization: TextCapitalization.sentences,
              // Enables automatic correction of text input.
              autocorrect: true,
              // Enables text suggestions while typing.
              enableSuggestions: true,
              // Sets a hint in the TextField to guide the user.
              decoration: const InputDecoration(labelText: 'Send a message...'),
            ),
          ),
          // IconButton to submit the message when pressed.
          IconButton(
              onPressed: submitMessage,
              // Sets the button color to match the secondary color of the current theme.
              color: Theme.of(context).colorScheme.primary,
              // Uses a send icon to visually indicate the submit action.
              icon: const Icon(Icons.send_outlined))
        ],
      ),
    );
  }
}
