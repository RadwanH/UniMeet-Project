import 'package:flutter/material.dart';
import 'package:unimeet_mobile/screens/login_screen.dart';
import 'package:unimeet_mobile/screens/sing_up_screen.dart';
import 'package:unimeet_mobile/widgets/my_button.dart';
import 'package:unimeet_mobile/widgets/unimeet_brand.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Container(
                    height: 180.0,
                    child: Image.asset('images/UniMeetLogo.png'),
                  ),
                  UnimeetBrand(),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              MyButton(
                color: const Color(0xFFFFC107),
                title: 'Sing in',
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.screenRoute);
                },
              ),
              MyButton(
                color: const Color(0xFF07F7FF),
                title: 'Sing up',
                onPressed: () {
                  Navigator.pushNamed(context, SingUpScreen.screenRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
