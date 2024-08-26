import 'package:chatfl/screens/authentication.dart';
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
        title: 'FlutterChat',
        theme: ThemeData().copyWith(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 7, 124, 17)),
        ),
        home: const AuthenticationScreen());
  }
}
