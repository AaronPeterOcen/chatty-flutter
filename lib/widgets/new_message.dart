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
  var _messageController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the widget tree.
    // This prevents memory leaks by cleaning up resources.
    _messageController.dispose();
    super.dispose();
  }

  // Function to handle the submission of the message.
  void submitMessage() {
    // Retrieve the text entered by the user.
    final enteredMessage = _messageController.text;

    // If the entered message is empty or contains only whitespace, do nothing.
    if (enteredMessage.trim().isEmpty) {
      return;
    }

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
