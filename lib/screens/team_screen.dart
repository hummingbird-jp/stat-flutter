import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stat_flutter/components/person_with_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stat_flutter/components/rounded_button.dart';
import 'package:stat_flutter/components/rounded_outline_button.dart';
import 'package:stat_flutter/screens/login_screen.dart';

//enum Status {
//  close,
//  check,
//}

class TeamScreen extends StatefulWidget {
  static const String id = 'team_screen';

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;
  String status;
  bool isUpdateStopped = false;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final tmpUser = _auth.currentUser;
      if (tmpUser != null) {
        loggedInUser = tmpUser;
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException in getCurrencUser: $e');
    } catch (e) {
      print('Other Exception in getCurrentUser: $e');
    }
  }

  void statusStream() async {
    await for (var snapshot in _firestore.collection('statuses').snapshots()) {
      for (var status in snapshot.docs) {
        print(status.data());
      }
    }
  }

  void sendStatus(String status) {
    const updateInterval = Duration(seconds: 5);

    Timer.periodic(updateInterval, (timer) {
      if (isUpdateStopped == false) {
        _firestore.collection('statuses').add({
          'status': status,
          'userEmail': loggedInUser.email,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stat! Flutter'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PersonWithStatus(
                    userImage: NetworkImage(
                        'https://media-exp1.licdn.com/dms/image/C5603AQG7D1xY_YtA6g/profile-displayphoto-shrink_400_400/0/1615853413089?e=1626912000&v=beta&t=aWaLslh_IrP6C-OHWnEYOM_4v5tfv35TgWfM5foBKcs'),
                    status: Icons.close,
                  ),
                ),
                Expanded(
                  child: PersonWithStatus(
                    userImage: NetworkImage(
                        'https://media-exp1.licdn.com/dms/image/C5603AQGGhBt6Ckxytg/profile-displayphoto-shrink_400_400/0/1604068708768?e=1626912000&v=beta&t=vc4GysO1ftX8OUB6psN6XJkuz-QdNfygRx2WrCrPgcA'),
                    status: Icons.check,
                  ),
                ),
                Expanded(
                  child: PersonWithStatus(
                    userImage: NetworkImage(
                        'https://media-exp1.licdn.com/dms/image/C5103AQEQRhS5GU68WA/profile-displayphoto-shrink_400_400/0/1545331992316?e=1626912000&v=beta&t=cJdEYKOYACtwZ0-qRA3S3b_Ddax4NH6Z-1dGGCNmtrg'),
                    status: Icons.close,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            RoundedButton(
              color: Theme.of(context).colorScheme.secondary,
              label: 'RUN!',
              onPressed: () {
                isUpdateStopped = false;
                String status = 'fine';
                sendStatus(status);
              },
            ),
            RoundedOutlineButton(
              color: Theme.of(context).colorScheme.secondary,
              label: 'STOP',
              onPressed: () {
                isUpdateStopped = true;
              },
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text('${loggedInUser.email}'),
              accountName: Text('Test User'),
            ),
            ListTile(
              title: Text(
                'Log out',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () async {
                await _auth.signOut();
                Navigator.pop(context);
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
