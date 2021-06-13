import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stat_flutter/components/person_with_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stat_flutter/components/rounded_button.dart';
import 'package:stat_flutter/components/rounded_outline_button.dart';
import 'package:stat_flutter/components/user_info_drawer.dart';
import 'package:stat_flutter/utils/bridge_to_js.dart';
import 'package:stat_flutter/utils/constants.dart';
import 'package:stat_flutter/utils/video_brain.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stat_flutter/components/thin_circular_progress_indicator.dart';

final _firestore = FirebaseFirestore.instance;

class TeamScreen extends StatefulWidget {
  const TeamScreen({Key? key}) : super(key: key);

  static const String id = 'team_screen';

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  String? status;
  bool isRunning = false;
  bool isLoading = false;
  bool userAIsInView = false;
  bool userBIsInView = false;
  bool userCIsInView = false;

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

  void getUserALatestStatus() async {
    Stream snapshots = _firestore
        .collection('statuses')
        .where('userEmail', isEqualTo: loggedInUser!.email)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();

    await for (var snapshot in snapshots) {
      for (var status in snapshot.docs) {
        setState(() {
          userAIsInView = status.data()['isInView'];
        });
      }
    }
  }

  IconData getUserAStatusIcon() {
    return userAIsInView == true ? Icons.check : Icons.block;
  }

  IconData getUserBStatusIcon() {
    return userBIsInView == true ? Icons.check : Icons.block;
  }

  IconData getUserCStatusIcon() {
    return userCIsInView == true ? Icons.check : Icons.block;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'YOUR TEAM',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 3.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PersonWithStatus(
                        userImage: const NetworkImage(
                            'https://media-exp1.licdn.com/dms/image/C5603AQG7D1xY_YtA6g/profile-displayphoto-shrink_400_400/0/1615853413089?e=1626912000&v=beta&t=aWaLslh_IrP6C-OHWnEYOM_4v5tfv35TgWfM5foBKcs'),
                        status: getUserAStatusIcon(),
                      ),
                    ),
                    Expanded(
                      child: PersonWithStatus(
                        userImage: const NetworkImage(
                            'https://media-exp1.licdn.com/dms/image/C5103AQEQRhS5GU68WA/profile-displayphoto-shrink_400_400/0/1545331992316?e=1626912000&v=beta&t=cJdEYKOYACtwZ0-qRA3S3b_Ddax4NH6Z-1dGGCNmtrg'),
                        status: getUserBStatusIcon(),
                      ),
                    ),
                    Expanded(
                      child: PersonWithStatus(
                        userImage: const NetworkImage(
                            'https://media-exp1.licdn.com/dms/image/C5603AQGGhBt6Ckxytg/profile-displayphoto-shrink_400_400/0/1604068708768?e=1626912000&v=beta&t=vc4GysO1ftX8OUB6psN6XJkuz-QdNfygRx2WrCrPgcA'),
                        status: getUserCStatusIcon(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                RoundedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                      isRunning = true;
                    });
                    while (isRunning) {
                      VideoBrain _videoBrain = VideoBrain();
                      VideoElement _videoElement =
                          await _videoBrain.getVideoElement();
                      callPoseNet(_videoElement, loggedInUser!.email as String);
                      getUserALatestStatus();
                      await Future.delayed(const Duration(seconds: 5));
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  disabled: isRunning,
                  label: 'RUN',
                  color: Theme.of(context).colorScheme.secondary,
                ),
                RoundedButton(
                  onPressed: () {
                    launch(kGoogleMeetUrl);
                  },
                  disabled: !isRunning,
                  label: 'TALK',
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
            if (isLoading)
              Center(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const ThinCircularProgressIndicator(),
                ),
              )
            else
              Container(),
          ],
        ),
      ),
      drawer: UserInfoDrawer(loggedInUser: loggedInUser, auth: _auth),
    );
  }
}
