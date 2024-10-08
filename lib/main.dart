import 'package:chatfl/screens/authentication.dart';
import 'package:chatfl/screens/chat.dart';
import 'package:chatfl/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// adding the firebase packages
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // to update the screen after changing the minsdk version
  WidgetsFlutterBinding.ensureInitialized();
  // adding the firebase plugin  and config
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatty',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 7, 124, 17)),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          if (snapshot.hasData) {
            return const ChatScreen();
          }
          return const AuthenticationScreen();
        },
      ),
    );
  }
}
