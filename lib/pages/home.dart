// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebasetestproject/core/components/app_drawer.dart';
import 'package:firebasetestproject/core/components/app_text_field.dart';
import 'package:firebasetestproject/core/components/liked_button.dart';
import 'package:firebasetestproject/core/components/post_button.dart';
import 'package:firebasetestproject/core/db/posts.dart';

// class Home extends StatefulWidget {
//   final List<String> likes;
//   Home({
//     Key? key,
//     required this.likes,
//   }) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final FirestoreDatabase database = FirestoreDatabase();
//   bool isLiked = false;
//   final TextEditingController newPostController = TextEditingController();
//   final currentUser = FirebaseAuth.instance.currentUser;
//   void postMessage() {
//     if (newPostController.text.isNotEmpty) {
//       String data = newPostController.text;
//       database.addPost(data);
//     }
//     newPostController.clear();
//   }

//   @override
//   void initState() {
//     super.initState();
//     isLiked = widget.likes.contains(currentUser!.email);
//   }

//   void toggleLike() {
//     setState(() {
//       isLiked = !isLiked;
//     });
//   }

// //   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       drawer: AppDrawer(),
//       appBar: AppBar(
//         title: Text(' W A L L'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(25),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: AppTextField(
//                     maxLine: 2,
//                     hintText: 'Say something',
//                     obsecureText: false,
//                     controller: newPostController,
//                   ),
//                 ),
//                 PostButton(onTap: postMessage),
//               ],
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder(
//               stream: database.getPosts(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//                   return Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text('No posts yet, say something now!'),
//                     ),
//                   );
//                 }

//                 final posts = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: posts.length,
//                   itemBuilder: (context, index) {
//                     final post = posts[index];

//                     String message = post['PostMessage'];
//                     String email = post['UserEmail'];
//                     Timestamp timestamp = post['Timestamp'];

//                     bool isLiked = post['Likes'].contains(currentUser!.email);

//                     return Padding(
//                         padding: const EdgeInsets.only(
//                           left: 25,
//                           right: 25,
//                           bottom: 25,
//                         ),
//                         child: Card(
//                           child: ListTile(
//                             leading: LikedButton(
//                                 isLiked: isLiked, onTap: toggleLike),
//                             title: Text(message),
//                             subtitle: Text(
//                               email,
//                               style: TextStyle(
//                                 color: Theme.of(context).colorScheme.secondary,
//                               ),
//                             ),
//                           ),
//                         ));
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirestoreDatabase database = FirestoreDatabase();
  final TextEditingController newPostController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String data = newPostController.text;
      database.addPost(data);
    }
    newPostController.clear();
  }

  void toggleLike(DocumentSnapshot post) async {
    final String userEmail = currentUser!.email!;
    final List<dynamic> likes = post['Likes'] ?? [];

    if (likes.contains(userEmail)) {
      // Unlike the post
      await database.posts.doc(post.id).update({
        'Likes': FieldValue.arrayRemove([userEmail]),
      });
    } else {
      // Like the post
      await database.posts.doc(post.id).update({
        'Likes': FieldValue.arrayUnion([userEmail]),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('WALL'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: AppTextField(
                    maxLine: 2,
                    hintText: 'Say something',
                    obsecureText: false,
                    controller: newPostController,
                  ),
                ),
                PostButton(onTap: postMessage),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: database.getPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No posts yet, say something now!'),
                    ),
                  );
                }

                final posts = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];

                    String message = post['PostMessage'];
                    String email = post['UserEmail'];

                    bool isLiked = post['Likes'].contains(currentUser!.email);

                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        bottom: 25,
                      ),
                      child: Card(
                        child: ListTile(
                          leading: LikedButton(
                            isLiked: isLiked,
                            onTap: () => toggleLike(post),
                          ),
                          title: Text(message),
                          subtitle: Text(
                            email,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
