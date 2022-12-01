import 'package:flutter/material.dart';
import 'package:unimeet101/screens/add_post_screen.dart';
import 'package:unimeet101/screens/feed_screen.dart';
import 'package:unimeet101/screens/search_screen.dart';

const webScreenSize = 600;
const homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Center(
    child: Text('notification'),
  ),
  Center(
    child: Text('profile'),
  )
];
