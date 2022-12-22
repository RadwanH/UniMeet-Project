import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:unimeet101/models/user.dart' as user_model;
import 'package:unimeet101/providers/user_provider.dart';
import 'package:unimeet101/resources/firestore_methods.dart';
import 'package:unimeet101/screens/comments_screen.dart';
import 'package:unimeet101/utils/colors.dart';
import 'package:unimeet101/utils/global_variables.dart';
import 'package:unimeet101/utils/utils.dart';
import 'package:unimeet101/widgets/like_animation.dart';

class PostCard extends StatefulWidget {
  final snap;

  const PostCard({
    super.key,
    required this.snap,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();

      commentLen = snap.docs.length;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //final User user = Provider.of<UserProvider>(context).getUser;
    final user_model.User? user = Provider.of<UserProvider>(context).getUser;
    if (user == null) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      ));
    }
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(
                5.0,
                5.0,
              ), //Offset
              blurRadius: 50.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Color(0xFF1E1E1E),
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
        ),
        child: Column(
          children: [
            // header section
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 16,
              ).copyWith(right: 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      widget.snap['profImage'],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.snap['username'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (widget.snap['uid'] ==
                          FirebaseAuth.instance.currentUser!.uid) {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shrinkWrap: true,
                              children: [
                                'Delete',
                              ]
                                  .map(
                                    (e) => InkWell(
                                      onTap: () async {
                                        FirestoreMethods()
                                            .deletePost(widget.snap['postId']);
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 16,
                                        ),
                                        child: Text(e),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      } else {}
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: logoColor,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: primaryColor),
                    children: [
                      TextSpan(
                        text: ' ${widget.snap['description']}',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            //IMAGE SECTion
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onDoubleTap: (() async {
                  await FirestoreMethods().likePost(
                      widget.snap['postId'], user.uid, widget.snap['likes']);
                  setState(() {
                    isLikeAnimating = true;
                  });
                }),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          widget.snap['postUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(microseconds: 200),
                      opacity: isLikeAnimating ? 0.5 : 0,
                      child: LikeAnimation(
                        isAnimating: isLikeAnimating,
                        duration: const Duration(
                          microseconds: 400,
                        ),
                        onEnd: () {
                          setState(() {
                            isLikeAnimating = false;
                          });
                        },
                        child: SvgPicture.asset(
                          'assets/icons/star_fill.svg',
                          color: primaryColor,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Like and Comment section

            Row(
              children: [
                LikeAnimation(
                  isAnimating: widget.snap['likes'].contains(user.uid),
                  smallLike: true,
                  child: IconButton(
                    onPressed: () async {
                      await FirestoreMethods().likePost(widget.snap['postId'],
                          user.uid, widget.snap['likes']);
                      setState(() {
                        isLikeAnimating = true;
                      });
                    },
                    icon: widget.snap['likes'].contains(user.uid)
                        ? SvgPicture.asset(
                            'assets/icons/star_fill.svg',
                            color: activeColor,
                            height: 25,
                          )
                        : SvgPicture.asset(
                            'assets/icons/star.svg',
                            color: activeColor,
                            height: 27,
                          ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CommentsScreen(snap: widget.snap),
                    ),
                  ),
                  icon: SvgPicture.asset(
                    'assets/icons/comment.svg',
                    color: activeColor,
                    height: 25,
                  ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(
                //     Icons.send,
                //   ),
                // ),
                // Expanded(
                //   child: Align(
                //     alignment: Alignment.bottomRight,
                //     child: IconButton(
                //       onPressed: () {},
                //       icon: const Icon(
                //         Icons.bookmark_outline,
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),

            //  number of comments
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                    child: Text(
                      '${widget.snap['likes'].length} stars', //stars = likes
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 8),
                    // child: RichText(
                    //   text: TextSpan(
                    //     style: const TextStyle(color: primaryColor),
                    //     children: [
                    //       TextSpan(
                    //         text: snap['username'],
                    //         style: const TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //       TextSpan(
                    //         text: ' ${snap['description']}',
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ),

                  // Num of comments
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'view all ${commentLen} comments',
                        style: const TextStyle(
                          fontSize: 16,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      DateFormat.yMMMd().format(
                        widget.snap['datePublished'].toDate(),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
