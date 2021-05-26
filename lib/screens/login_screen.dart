import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stat_flutter/components/rounded_outline_button.dart';
import 'package:stat_flutter/constants.dart';
import 'package:stat_flutter/screens/login_failed_screen.dart';
import 'package:stat_flutter/screens/team_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

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
                hintText: 'Enter your email',
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
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Hero(
              tag: 'login button',
              child: RoundedOutlineButton(
                color: Theme.of(context).colorScheme.secondary,
                label: 'Log In',
                onPressed: () async {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);

                    if (user != null) {
                      Navigator.pushNamed(context, TeamScreen.id);
                    }
                  } catch (e) {
                    Navigator.pushNamed(context, LoginFailedScreen.id);
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
