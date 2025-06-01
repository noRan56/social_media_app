import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DrawerHeader(
            child: Icon(
              Icons.person_2_rounded,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: ListTile(
              leading: Icon(Icons.home,
                  color: Theme.of(context).colorScheme.inversePrimary),
              title: Text("H O M E"),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: ListTile(
              leading: Icon(Icons.person_2,
                  color: Theme.of(context).colorScheme.inversePrimary),
              title: Text("P R O F I L E"),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'profile');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: ListTile(
              leading: Icon(Icons.group,
                  color: Theme.of(context).colorScheme.inversePrimary),
              title: Text("U S E R S"),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'users');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: ListTile(
                leading: Icon(Icons.logout,
                    color: Theme.of(context).colorScheme.inversePrimary),
                title: Text("L O G O U T"),
                onTap: () {
                  Navigator.pop(context);
                  logOut();
                }),
          ),
        ],
      ),
    );
  }
}
