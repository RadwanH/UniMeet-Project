import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unimeet101/models/user.dart';
import 'package:unimeet101/providers/user_provider.dart';
import 'package:unimeet101/resources/firestore_methods.dart';
import 'package:unimeet101/utils/colors.dart';
import 'package:unimeet101/utils/global_variables.dart';
import 'package:unimeet101/widgets/comment_card.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  final String postId;
  const CommentsScreen({super.key, required this.snap, required this.postId});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    if (user == null) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.white,
      ));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments'),
        centerTitle: false,
      ),
      body: MediaQuery.of(context).size.width < webScreenSize
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.snap['postId'])
                  .collection('comments')
                  .orderBy(
                    'datePublished',
                    descending: true,
                  )
                  .snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: ((context, index) => CommentCard(
                      snap: (snapshot.data! as dynamic).docs[index].data(),
                      postId: widget.snap['postId'])),
                );
              }))
          : Center(
              child: Container(
                alignment: Alignment.center,
                width: 600,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc(widget.snap['postId'])
                        .collection('comments')
                        .orderBy(
                          'datePublished',
                          descending: true,
                        )
                        .snapshots(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }

                      return ListView.builder(
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        itemBuilder: ((context, index) => CommentCard(
                            snap:
                                (snapshot.data! as dynamic).docs[index].data(),
                            postId: widget.snap['postId'])),
                      );
                    })),
              ),
            ),
      bottomNavigationBar: SafeArea(
        child: MediaQuery.of(context).size.width < webScreenSize
            ? Container(
                height: kToolbarHeight,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl),
                      radius: 18,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                              hintText: 'Comment as ${user.username}',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await FirestoreMethods().postComment(
                          widget.snap['postId'],
                          _commentController.text,
                          user.uid,
                          user.displayname,
                          user.photoUrl,
                        );
                        setState(() {
                          _commentController.text = "";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: const Text(
                          "Post",
                          style: TextStyle(
                            color: blueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                heightFactor: 2,
                child: Container(
                  alignment: Alignment.center,
                  width: 600,
                  height: kToolbarHeight,
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.photoUrl),
                        radius: 18,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 8),
                          child: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                                hintText: 'Comment as ${user.username}',
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await FirestoreMethods().postComment(
                            widget.snap['postId'],
                            _commentController.text,
                            user.uid,
                            user.displayname,
                            user.photoUrl,
                          );
                          setState(() {
                            _commentController.text = "";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: const Text(
                            "Post",
                            style: TextStyle(
                              color: blueColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
    ;
  }
}
