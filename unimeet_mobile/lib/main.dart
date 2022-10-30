import 'package:flutter/material.dart';
import 'package:unimeet_mobile/screens/chat_screen.dart';
import 'package:unimeet_mobile/screens/login_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/sing_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Gang Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ChatScreen(),
      initialRoute: WelcomeScreen.screenRoute,
      routes: {
        WelcomeScreen.screenRoute: (context) => const WelcomeScreen(),
        LoginScreen.screenRoute: (context) => const LoginScreen(),
        SingUpScreen.screenRoute: (context) => const SingUpScreen(),
        ChatScreen.screenRoute: (context) => const ChatScreen(),
      },
    );
  }
}
