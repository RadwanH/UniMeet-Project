import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String lastName;
  final String uid;
  final String gender;
  final String username;
  final String email;
  final String bio;
  final List followers;
  final List following;
  final String photoUrl;

  const User({
    required this.name,
    required this.lastName,
    required this.uid,
    required this.photoUrl,
    required this.gender,
    required this.username,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJason() => {
        'uid': uid,
        'name': name,
        'lastName': lastName,
        'gender': gender,
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
      name: snapshot['name'],
      lastName: snapshot['lastName'],
      gender: snapshot['gender'],
      email: snapshot['email'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      photoUrl: snapshot['photoUrl'],
    );
  }
}
