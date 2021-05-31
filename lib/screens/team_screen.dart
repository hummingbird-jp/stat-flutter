import 'package:flutter/material.dart';
import 'package:stat_flutter/status_brain.dart';
import 'package:stat_flutter/components/person_with_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stat_flutter/components/rounded_button.dart';
import 'package:stat_flutter/components/rounded_outline_button.dart';
import 'package:stat_flutter/components/user_info_drawer.dart';
import 'package:stat_flutter/screens/video_screen.dart';

class TeamScreen extends StatefulWidget {
  static const String id = 'team_screen';

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  String? status;
  bool isInProgress = false;

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
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stat! Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: PersonWithStatus(
                    userImage: NetworkImage(
                        'https://media-exp1.licdn.com/dms/image/C5603AQG7D1xY_YtA6g/profile-displayphoto-shrink_400_400/0/1615853413089?e=1626912000&v=beta&t=aWaLslh_IrP6C-OHWnEYOM_4v5tfv35TgWfM5foBKcs'),
                    status: Icons.close,
                  ),
                ),
                const Expanded(
                  child: PersonWithStatus(
                    userImage: NetworkImage(
                        'https://media-exp1.licdn.com/dms/image/C5603AQGGhBt6Ckxytg/profile-displayphoto-shrink_400_400/0/1604068708768?e=1626912000&v=beta&t=vc4GysO1ftX8OUB6psN6XJkuz-QdNfygRx2WrCrPgcA'),
                    status: Icons.check,
                  ),
                ),
                const Expanded(
                  child: PersonWithStatus(
                    userImage: NetworkImage(
                        'https://media-exp1.licdn.com/dms/image/C5103AQEQRhS5GU68WA/profile-displayphoto-shrink_400_400/0/1545331992316?e=1626912000&v=beta&t=cJdEYKOYACtwZ0-qRA3S3b_Ddax4NH6Z-1dGGCNmtrg'),
                    status: Icons.close,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            RoundedButton(
              color: Theme.of(context).colorScheme.secondary,
              label: 'RUN!',
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Sending your status!'),
                    content: const Text('Press STOP to stop sending.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          StatusBrain.isUpdateRunning = false;
                          Navigator.pop(context);
                        },
                        child: Text(
                          'CANCEL',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          StatusBrain.isUpdateRunning = true;
                          StatusBrain().sendStatus(loggedInUser);
                        },
                        child: Text(
                          'GOT IT!',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // TODO: disable STOP button when running
            RoundedOutlineButton(
              color: Theme.of(context).colorScheme.secondary,
              label: 'STOP',
              onPressed: () {
                StatusBrain.isUpdateRunning = false;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Status sending paused'),
                    content: const Text('Press RUN! to resume.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'GOT IT',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            RoundedButton(
              onPressed: () {
                Navigator.pushNamed(context, VideoScreen.id);
              },
              label: 'START VIDEO',
              color: Theme.of(context).backgroundColor,
            ),
          ],
        ),
      ),
      drawer: UserInfoDrawer(loggedInUser: loggedInUser, auth: _auth),
    );
  }
}
