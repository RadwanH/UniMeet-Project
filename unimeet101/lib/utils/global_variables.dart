import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unimeet101/screens/add_post_screen.dart';
import 'package:unimeet101/screens/feed_screen.dart';
import 'package:unimeet101/screens/profile_screen.dart';
import 'package:unimeet101/screens/search_screen.dart';

const webScreenSize = 600;
List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Center(
    child: Text('notification'),
  ),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
