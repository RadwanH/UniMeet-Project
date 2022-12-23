import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimeet101/resources/auth_methods.dart';
import 'package:unimeet101/screens/login_screen.dart';
import 'package:unimeet101/utils/global_variables.dart';
import 'package:unimeet101/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _displsynameController = TextEditingController();
  final TextEditingController _universityController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    _displsynameController.dispose();
    _universityController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      displsyname: _displsynameController.text,
      university: _universityController.text,
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      file: _image!,
    );
    //print(res);
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // logo
                  //Image.asset('assets/images/UniMeetLogo.png'),

                  // circuler profile image
                  Stack(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              radius: 64,
                              backgroundImage:
                                  AssetImage('assets/images/defaultProf.png'),
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //text field input for name
                  TextFieldInput(
                      iconPic: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.badge),
                        //child: Icon(Icons.iconPic),
                      ),
                      textEditingController: _displsynameController,
                      hintText: "Your name",
                      textInputType: TextInputType.text),

                  const SizedBox(
                    height: 24,
                  ),

                  //text field input for Last name
                  // TextFieldInput(
                  //     iconPic: const Padding(
                  //       padding: EdgeInsets.all(16),
                  //       child: Icon(Icons.badge),
                  //       //child: Icon(Icons.iconPic),
                  //     ),
                  //     textEditingController: _lastNameController,
                  //     hintText: "Enter your last name",
                  //     textInputType: TextInputType.text),

                  // const SizedBox(
                  //   height: 24,
                  // ),

                  //text field input for university
                  TextFieldInput(
                    iconPic: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.school),
                      //child: Icon(Icons.iconPic),
                    ),
                    textEditingController: _universityController,
                    hintText: "Enter your university",
                    textInputType: TextInputType.text,
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  //text field input for username
                  TextFieldInput(
                      iconPic: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.person),
                        //child: Icon(Icons.iconPic),
                      ),
                      textEditingController: _usernameController,
                      hintText: "Enter your username",
                      textInputType: TextInputType.text),

                  const SizedBox(
                    height: 24,
                  ),
                  // user bio
                  TextFieldInput(
                      iconPic: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.history_edu),
                        //child: Icon(Icons.iconPic),
                      ),
                      textEditingController: _bioController,
                      hintText: "Enter your bio",
                      textInputType: TextInputType.text),

                  const SizedBox(
                    height: 24,
                  ),

                  //text field input for email
                  TextFieldInput(
                      isEmail: true,
                      iconPic: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.email),
                        //child: Icon(Icons.iconPic),
                      ),
                      textEditingController: _emailController,
                      hintText: "Email address",
                      textInputType: TextInputType.emailAddress),

                  const SizedBox(
                    height: 24,
                  ),

                  // password field
                  TextFieldInput(
                    iconPic: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Icon(Icons.lock),
                      //child: Icon(Icons.iconPic),
                    ),
                    textEditingController: _passwordController,
                    hintText: "Password",
                    textInputType: TextInputType.text,
                    isPass: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  // button Signup

                  // InkWell(
                  //   onTap: signUpUser,
                  //   child: Container(
                  //     child: _isLoading
                  //         ? const Center(
                  //             child: CircularProgressIndicator(
                  //               color: primaryColor,
                  //             ),
                  //           )
                  //         : const Text('Sign Up'),
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
                  //   ),
                  // ),
                  ElevatedButton(
                    onPressed: signUpUser,
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
                              'REGISTER',
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
                        child: const Text("Already have an account ?  "),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                      GestureDetector(
                        onTap: navigateToLogin,
                        child: Container(
                          // ignore: sort_child_properties_last
                          child: const Text(
                            "Login",
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
