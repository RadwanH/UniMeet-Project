import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String displsyname;
  final String uid;
  final String university;
  final String username;
  final String email;
  final String bio;
  final List followers;
  final List following;
  final String photoUrl;

  const User({
    required this.displsyname,
    required this.uid,
    required this.photoUrl,
    required this.university,
    required this.username,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJason() => {
        'uid': uid,
        'name': displsyname,
        'university': university,
        'username': username,
        'email': email,
        'bio': bio,
        'followers': [],
        'following': [],
        'photoUrl': photoUrl,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      displsyname: snapshot['name'],
      university: snapshot['university'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      photoUrl: snapshot['photoUrl'],
    );
  }
}
