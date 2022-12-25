import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:unimeet101/models/post.dart';
import 'package:unimeet101/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = Uuid().v1();

      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);
      _firestore.collection('posts').doc(postId).set(
            post.toJason(),
          );
      res = 'success';
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

// posting comment to firebase
  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
      } else {
        print("text is empty");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //deleting the posts

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //deleting the comment

  Future<void> deleteComment(String postId, String commentId) async {
    print('here is the deleteComment method before delete');

    CollectionReference subcollection =
        _firestore.collection('posts').doc(postId).collection('comments');

    DocumentReference commentTodelete = subcollection.doc(commentId);

    try {
      commentTodelete.delete();
    } catch (e) {
      print(e.toString());
    }

    // try {
    //   Reference ref =
    //       FirebaseStorage.instance.ref().child('posts').child(postId);
    //   ref.child('comments').child(commentId).delete();
    // } catch (e) {
    //   print(e.toString());
    // }
    print('here is the deleteComment method');

    // try {
    //   print(commentId);
    //   await _firestore.collection('comments').doc(commentId).delete().then(
    //         (doc) => print("Document deleted"),
    //         onError: (e) => print("Error updating document $e"),
    //       );
    // } catch (e) {
    //   print(e.toString());
    // }

    // try {
    //   await _firestore.collection('posts')
    //   .doc('postId')
    //   .collection('comments').ref
    //   .where(field, '==', commentId)
    //   .onSnapshot(snapshot => snapshot.foreEach(result => result.ref.delete()));

    // } catch (e) {
    //   print(e.toString());
    // }
  }

  //following

  Future<void> followUser(
    String uid,
    String followId,
  ) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid]),
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId]),
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid]),
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
