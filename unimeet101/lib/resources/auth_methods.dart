import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unimeet101/models/user.dart' as model;
import 'package:unimeet101/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // signup user

  Future<String> signUpUser({
    required String displayname,
    required String university,
    required String username,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (displayname.isNotEmpty ||
          university.isNotEmpty ||
          username.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // add user to our database

        model.User user = model.User(
            displayname: displayname,
            uid: cred.user!.uid,
            photoUrl: photoUrl,
            university: university,
            username: username,
            email: email,
            bio: bio,
            followers: [],
            following: []);

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJason(),
            );

        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email format is invalid';
      } else if (err.code == 'weak-password') {
        res = 'Password should be at least 6 characters long';
      } else if (err.code == 'email-already-in-use') {
        res = 'Email already in use';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

// Edit profile
// Future<String> editProfile({
//     required String displayname,
//     required String email,
//     required String password,
//     required String bio,
//     required Uint8List file,
//   }) async {
//     String res = "Some error occurred";
//     try {
//       if (displayname.isNotEmpty ||
//           email.isNotEmpty ||
//           password.isNotEmpty ||
//           bio.isNotEmpty ||
//           file != null) {
//         //edit user data
//         // UserCredential cred = await _auth.createUserWithEmailAndPassword (
//         //     email: email, password: password);

//         // print(cred.user!.uid);

//         String photoUrl = await StorageMethods()
//             .uploadImageToStorage('profilePics', file, false);

//         // add user to our database

//         model.User user = model.User(
//             displayname: displayname,
//             uid: cred.user!.uid,
//             photoUrl: photoUrl,
//             university: university,
//             username: username,
//             email: email,
//             bio: bio,
//             followers: [],
//             following: []);

//         await _firestore.collection('users').doc(cred.user!.uid).set(
//               user.toJason(),
//             );

//         res = 'success';
//       }
//     } on FirebaseAuthException catch (err) {
//       if (err.code == 'invalid-email') {
//         res = 'The email format is invalid';
//       } else if (err.code == 'weak-password') {
//         res = 'Password should be at least 6 characters long';
//       } else if (err.code == 'email-already-in-use') {
//         res = 'Email already in use';
//       }
//     } catch (err) {
//       res = err.toString();
//     }

//     return res;
//   }

  //logging in user

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some Error occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please fill all the fields';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        res = 'No such a user! please recheck the email';
      } else if (err.code == 'wrong-password') {
        res = 'Wrong password! please recheck your password';
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
