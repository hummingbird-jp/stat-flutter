import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Status {
  fine,
  notFine,
}

class StatusBrain {
  final _firestore = FirebaseFirestore.instance;
  static bool isUpdateRunning = true;

  Future<void> sendStatus(User? loggedInUser) async {
    const updateInterval = Duration(seconds: 5);

    Timer.periodic(updateInterval, (timer) async {
      if (isUpdateRunning == true) {
        try {
          Status status = getStatus;

          await _firestore.collection('statuses').add({
            // TODO: calcurate status with poseNet
            'status': status == Status.fine ? 'Fine' : 'Not Fine',
            'userEmail': loggedInUser!.email,
            'timestamp': DateTime.now(),
          });
        } catch (e) {
          rethrow;
        }
      }
    });
  }

  Status get getStatus {
    int pick = Random().nextInt(Status.values.length);
    return Status.values[pick];
  }

  // TODO: implement statusStream
  //void statusStream() async {
  //  await for (var snapshot in _firestore.collection('statuses').snapshots()) {
  //    for (var status in snapshot.docs) {
  //      print(status.data());
  //    }
  //  }
  //}
}
