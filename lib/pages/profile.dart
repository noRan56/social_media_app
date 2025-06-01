// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Profile extends StatelessWidget {
//   Profile({super.key});

//   final User? currentUser = FirebaseAuth.instance.currentUser;

//   Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
//     return await FirebaseFirestore.instance
//         .collection('Users')
//         .doc(currentUser!.email)
//         .get();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Theme.of(context).colorScheme.surface,
//         appBar: AppBar(
//           title: Text('Profile'),
//           backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         ),
//         body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//             future: getUserData(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if (snapshot.hasData) {
//                 Map<String, dynamic> data = snapshot.data!.data()!;
//                 return Column(
//                   children: [
//                     Icon(
//                       Icons.person_2_rounded,
//                       color: Theme.of(context).colorScheme.inversePrimary,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     ListTile(
//                       leading: Text(
//                         " Name",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       trailing: Text(
//                         data!['username'],
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     Divider(),
//                     ListTile(
//                       leading: Text(
//                         "Email",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       trailing: Text(
//                         data!['email'],
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               } else {
//                 return Text('No data');
//               }
//             }));
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserData() async {
    if (currentUser == null) return null;
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: currentUser == null
          ? Center(
              child: Text(
                'No user is currently signed in.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  Map<String, dynamic>? data = snapshot.data!.data();
                  if (data == null) {
                    return Center(
                      child: Text('User data not found.'),
                    );
                  }
                  return Column(
                    children: [
                      Text(
                        data!['username'],
                      ),
                      Text(
                        data!['email'],
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: Text('No data available.'),
                  );
                }
              },
            ),
    );
  }
}
