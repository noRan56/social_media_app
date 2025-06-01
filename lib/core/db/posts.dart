import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');

  Future<void> addPost(String data) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': data,
      'Timestamp': Timestamp.now(),
      'Likes': []
    });
  }

  Stream<QuerySnapshot> getPosts() {
    final posts = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('Timestamp', descending: true)
        .snapshots();
    return posts;
  }
}
