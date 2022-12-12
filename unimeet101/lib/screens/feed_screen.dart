import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimeet101/utils/colors.dart';
import 'package:unimeet101/utils/global_variables.dart';
import 'package:unimeet101/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 26.0),
      child: Scaffold(
        appBar: width > webScreenSize
            ? null
            : AppBar(
                backgroundColor: width > webScreenSize
                    ? webBackgroundColor
                    : mobileBackgroundColor,
                centerTitle: false,
                title: SvgPicture.asset(
                  'assets/images/unimeet_logo.svg',
                  height: 48,
                ),

                // Image.asset(
                //   'assets/images/uniMeet_brand_.png',
                //   fit: BoxFit.cover,
                //   height: 38,
                // ),
                actions: [
                  Container(
                    padding: EdgeInsets.only(right: 16),
                    child: InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/images/message.svg',
                        height: 30,
                        color: logoColor,
                      ),
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Padding(
                  //     padding: EdgeInsets.only(bottom: 20),
                  //     child: Icon(
                  //       Icons.messenger_outline,
                  //       size: 35,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('datePublished', descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(
                  horizontal: width > webScreenSize ? width * 0.3 : 0,
                  vertical: width > webScreenSize ? 15 : 0,
                ),
                child: PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
