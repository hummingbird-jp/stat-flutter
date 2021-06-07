import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stat_flutter/screens/welcome_screen.dart';

class UserInfoDrawer extends StatelessWidget {
  const UserInfoDrawer({
    Key? key,
    required this.loggedInUser,
    required FirebaseAuth auth,
  })  : _auth = auth,
        super(key: key);

  final User? loggedInUser;
  final FirebaseAuth _auth;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(
              '${loggedInUser!.email}',
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
            accountName: Text(
              '${_auth.currentUser!.displayName}',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Log out',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
            onTap: () async {
              await _auth.signOut();
              Navigator.pushNamed(context, WelcomeScreen.id);
            },
          ),
        ],
      ),
    );
  }
}
