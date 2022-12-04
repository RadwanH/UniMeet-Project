import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimeet101/providers/user_provider.dart';
import 'package:unimeet101/responsive/mobile_screen_layout.dart';
import 'package:unimeet101/responsive/responsive_layout_screen.dart';
import 'package:unimeet101/responsive/web_screen_layout.dart';
import 'package:unimeet101/screens/login_screen.dart';
import 'package:unimeet101/screens/signup_screen.dart';
import 'package:unimeet101/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCSjH2xlkOYWwuU5P-BYTol5FDDYgTQABs',
          appId: '1:652449277539:web:16e19e2e8e823568b53a56',
          messagingSenderId: '652449277539',
          projectId: 'unimeet101',
          storageBucket: 'unimeet101.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Unimeet',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            //iconColor: kPrimaryColor,
            //prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide.none,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
        ),
        home: StreamBuilder(
          //stream: FirebaseAuth.instance.userChanges(), //this gets called when u want to change have password change and stuff
          stream: FirebaseAuth.instance
              .authStateChanges(), //runs only when the user signs in or out
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('snapshot error has occurred'),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
