// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class Users extends StatelessWidget {
//   const Users({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       appBar: AppBar(
//         title: const Text('Users'),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       ),
//       body: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('Users').snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Text('somthing went wrong');
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             }

//             if (snapshot.data == null) {
//               return Text('No Data');
//             }
//             final users = snapshot.data!.docs;

//             return ListView.builder(
//                 itemCount: users.length,
//                 itemBuilder: (context, index) {
//                   final user = users[index];
//                   return ListTile(
//                     title: user['username'],
//                     subtitle: user['email'],
//                   );
//                 });
//           }),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pushReplacementNamed(context, 'home'))
        ],
        title: const Text('Users'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No users found'),
              );
            }

            final users = snapshot.data!.docs;

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(user['username'] ?? 'Unknown'),
                  subtitle: Text(user['email'] ?? 'No email provided'),
                );
              },
            );
          }),
    );
  }
}
