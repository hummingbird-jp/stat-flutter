import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stat_flutter/constants.dart';
import 'package:stat_flutter/screens/team_screen.dart';
import 'package:stat_flutter/components/rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  String? displayName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 200.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'Stat! logo',
              child: CircleAvatar(
                backgroundImage: AssetImage('images/logo.jpg'),
                radius: 50.0,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintStyle: kHintTextStyle,
                hintText: 'What is your email?',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintStyle: kHintTextStyle,
                hintText: 'What is your new password?',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                displayName = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintStyle: kHintTextStyle,
                hintText: 'What do people call you?',
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Hero(
              tag: 'register button',
              child: RoundedButton(
                color: Theme.of(context).colorScheme.secondary,
                label: 'Register',
                onPressed: () async {
                  try {
                    await _auth
                        .createUserWithEmailAndPassword(
                            email: email, password: password)
                        .then((result) {
                      return result.user!.updateProfile(
                        displayName: displayName,
                      );
                    });
                    Navigator.pushNamed(context, TeamScreen.id);
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
