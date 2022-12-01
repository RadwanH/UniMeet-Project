import 'package:flutter/material.dart';
import 'package:unimeet101/screens/add_post_screen.dart';
import 'package:unimeet101/screens/feed_screen.dart';

const webScreenSize = 600;
const homeScreenItems = [
  FeedScreen(),
  Center(
    child: Text('chat'),
  ),
  AddPostScreen(),
  Center(
    child: Text('notification'),
  ),
  Center(
    child: Text('profile'),
  )
];
