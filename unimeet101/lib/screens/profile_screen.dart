import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unimeet101/resources/auth_methods.dart';
import 'package:unimeet101/resources/firestore_methods.dart';
import 'package:unimeet101/screens/edit_profile_screen.dart';
import 'package:unimeet101/screens/login_screen.dart';
import 'package:unimeet101/utils/colors.dart';
import 'package:unimeet101/utils/utils.dart';
import 'package:unimeet101/widgets/follow_button.dart';

import '../utils/global_variables.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      //getting post length
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);

      setState(() {});
    } catch (e) {
      showSnackBar(
        e.toString(),
        context,
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  void navigateToProfileEdit(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) =>
          const EditProfileScreen(uid: 'ogoCrj8he4UWVLSv1zqiUbnzfWN2'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(
                userData['username'],
              ),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () => navigateToProfileEdit(context),
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
            body: MediaQuery.of(context).size.width < webScreenSize
                ? ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(userData['photoUrl']),
                                  radius: 40,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          buildStatColumn(postLen, 'posts'),
                                          buildStatColumn(
                                              followers, 'followers'),
                                          buildStatColumn(
                                              following, 'following'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FirebaseAuth.instance.currentUser!
                                                      .uid ==
                                                  widget.uid
                                              ? FollowButton(
                                                  backgroundColor:
                                                      mobileBackgroundColor,
                                                  borderColor: primaryColor,
                                                  text: 'Sign Out',
                                                  textColor: Colors.grey,
                                                  function: () async {
                                                    await AuthMethods()
                                                        .signOut();
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginScreen(),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : isFollowing
                                                  ? FollowButton(
                                                      text: 'Unfollow',
                                                      backgroundColor:
                                                          Colors.white,
                                                      borderColor: Colors.grey,
                                                      textColor: Colors.black,
                                                      function: () async {
                                                        await FirestoreMethods()
                                                            .followUser(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          userData['uid'],
                                                        );

                                                        setState(() {
                                                          isFollowing = false;
                                                          followers--;
                                                        });
                                                      },
                                                    )
                                                  : FollowButton(
                                                      text: 'Follow',
                                                      backgroundColor:
                                                          Colors.blue,
                                                      borderColor: Colors.blue,
                                                      textColor: Colors.white,
                                                      function: () async {
                                                        await FirestoreMethods()
                                                            .followUser(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          userData['uid'],
                                                        );
                                                        setState(() {
                                                          isFollowing = true;
                                                          followers++;
                                                        });
                                                      },
                                                    )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                userData['displayname'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                userData['university'].toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white30,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  wordSpacing: 16,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.only(
                                top: 16,
                              ),
                              child: Text(
                                userData['bio'],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 50, 49, 49),
                      ),
                      FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('posts')
                              .where('uid', isEqualTo: widget.uid)
                              .get(),
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  (snapshot.data! as dynamic).docs.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 1.5,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                DocumentSnapshot snap =
                                    (snapshot.data! as dynamic).docs[index];

                                return Container(
                                  child: Image(
                                    image: NetworkImage(
                                      snap['postUrl'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            );
                          })),
                    ],
                  )
                : Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: 600,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 66, 65, 65)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(userData['photoUrl']),
                                      radius: 40,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              buildStatColumn(postLen, 'posts'),
                                              buildStatColumn(
                                                  followers, 'followers'),
                                              buildStatColumn(
                                                  following, 'following'),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              FirebaseAuth.instance.currentUser!
                                                          .uid ==
                                                      widget.uid
                                                  ? FollowButton(
                                                      backgroundColor:
                                                          mobileBackgroundColor,
                                                      borderColor: primaryColor,
                                                      text: 'Sign Out',
                                                      textColor: Colors.grey,
                                                      function: () async {
                                                        await AuthMethods()
                                                            .signOut();
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LoginScreen(),
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : isFollowing
                                                      ? FollowButton(
                                                          text: 'Unfollow',
                                                          backgroundColor:
                                                              Colors.white,
                                                          borderColor:
                                                              Colors.grey,
                                                          textColor:
                                                              Colors.black,
                                                          function: () async {
                                                            await FirestoreMethods()
                                                                .followUser(
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                              userData['uid'],
                                                            );

                                                            setState(() {
                                                              isFollowing =
                                                                  false;
                                                              followers--;
                                                            });
                                                          },
                                                        )
                                                      : FollowButton(
                                                          text: 'Follow',
                                                          backgroundColor:
                                                              Colors.blue,
                                                          borderColor:
                                                              Colors.blue,
                                                          textColor:
                                                              Colors.white,
                                                          function: () async {
                                                            await FirestoreMethods()
                                                                .followUser(
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                              userData['uid'],
                                                            );
                                                            setState(() {
                                                              isFollowing =
                                                                  true;
                                                              followers++;
                                                            });
                                                          },
                                                        ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    userData['displayname'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    userData['university'].toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white30,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                      wordSpacing: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  padding: const EdgeInsets.only(
                                    top: 16,
                                  ),
                                  child: Text(
                                    userData['bio'],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 50, 49, 49),
                          ),
                          FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('posts')
                                  .where('uid', isEqualTo: widget.uid)
                                  .get(),
                              builder: ((context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return GridView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      (snapshot.data! as dynamic).docs.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 1.5,
                                    childAspectRatio: 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot snap =
                                        (snapshot.data! as dynamic).docs[index];

                                    return Container(
                                      child: Image(
                                        image: NetworkImage(
                                          snap['postUrl'],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                );
                              })),
                        ],
                      ),
                    ),
                  ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
