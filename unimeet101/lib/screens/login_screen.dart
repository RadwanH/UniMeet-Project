import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimeet101/resources/auth_methods.dart';
import 'package:unimeet101/screens/signup_screen.dart';
import 'package:unimeet101/utils/colors.dart';
import 'package:unimeet101/utils/global_variables.dart';
import 'package:unimeet101/utils/utils.dart';
import 'package:unimeet101/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      //
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            alignment: Alignment.center,
            padding: MediaQuery.of(context).size.width > webScreenSize
                ? EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 3)
                : const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Flexible(child: Container(), flex: 2),
                  // logo
                  //Image.asset('assets/images/UniMeetLogo.png'),
                  SvgPicture.asset(
                    'assets/icons/unit.svg',
                    //color: primaryColor,
                    height: 350,
                  ),

                  const SizedBox(
                    height: 64,
                  ),
                  //text field input for email
                  TextFieldInput(
                    iconPic: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.person),
                      //child: Icon(Icons.iconPic),
                    ),
                    textEditingController: _emailController,
                    hintText: "Email address",
                    textInputType: TextInputType.emailAddress,
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  // password field
                  TextFieldInput(
                    textEditingController: _passwordController,
                    hintText: "Password",
                    textInputType: TextInputType.text,
                    isPass: true,
                    iconPic: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  // button login

                  // InkWell(
                  //   onTap: loginUser,
                  //   child: Container(
                  //     width: double.infinity,
                  //     alignment: Alignment.center,
                  //     padding: const EdgeInsets.symmetric(
                  //       vertical: 12,
                  //     ),
                  //     decoration: const ShapeDecoration(
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(4),
                  //           ),
                  //         ),
                  //         color: blueColor),
                  //     child: _isLoading
                  //         ? const Center(
                  //             child: CircularProgressIndicator(
                  //               color: primaryColor,
                  //             ),
                  //           )
                  //         : const Text('Log in'),
                  //   ),
                  // ),
                  ElevatedButton(
                    onPressed: loginUser,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          : const Text(
                              'LOGIN',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  //Flexible(child: Container(), flex: 2),
                  // transition
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: const Text("Don't have an account ? "),
                      ),
                      GestureDetector(
                        onTap: navigateToSignUp,
                        child: Container(
                          // ignore: sort_child_properties_last
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
