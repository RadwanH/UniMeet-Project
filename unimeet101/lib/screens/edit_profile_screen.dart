import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unimeet101/resources/auth_methods.dart';
import 'package:unimeet101/utils/colors.dart';
import 'package:unimeet101/utils/global_variables.dart';
import 'package:unimeet101/utils/utils.dart';
import 'package:unimeet101/widgets/text_field_input.dart';

class EditProfileScreen extends StatefulWidget {
  final Map userDataa;
  // final String displayname;
  // final String bio;
  // final String university;
  const EditProfileScreen({
    super.key,
    required this.userDataa,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _bioController = TextEditingController();
  TextEditingController _displaynameController = TextEditingController();
  TextEditingController _universityController = TextEditingController();

  Uint8List? _image;
  bool _isLoading = false;
  String imageUrl = "";

  var userData = {};

  @override
  void initState() {
    super.initState();
    print(imageUrl);
    userData = widget.userDataa;
    //var username = userData['displayname'];

    _displaynameController.text = userData['displayname'];
    _bioController.text = userData['bio'];
    _universityController.text = userData['university'];
    imageUrl = userData['photoUrl']!;
    //print(imageUrl);
  }

  @override
  void dispose() {
    super.dispose();
    // _bioController.dispose();
    // _displaynameController.dispose();
    // _universityController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void editProfile() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().editProfile(
      displayname: _displaynameController.text,
      university: _universityController.text,
      bio: _bioController.text,
      file: _image!,
      uid: userData['uid'],
    );

    setState(
      () {
        _isLoading = false;
      },
    );
    showSnackBar(res, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: mobileBackgroundColor,
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
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
                  // circuler profile image
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(imageUrl),
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
                      ),
                      textEditingController: _displaynameController,
                      hintText: "Your name",
                      textInputType: TextInputType.text),
                  const SizedBox(
                    height: 30,
                  ),

                  //text field input for name
                  TextFieldInput(
                      iconPic: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.badge),
                      ),
                      textEditingController: _bioController,
                      hintText: "Your bio",
                      textInputType: TextInputType.text),
                  const SizedBox(
                    height: 30,
                  ),

                  //text field input for name
                  TextFieldInput(
                      iconPic: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.badge),
                      ),
                      textEditingController: _universityController,
                      hintText: "Your university",
                      textInputType: TextInputType.text),
                  const SizedBox(
                    height: 30,
                  ),

                  ElevatedButton(
                    onPressed: editProfile,
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
                              'Save',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    ),
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
