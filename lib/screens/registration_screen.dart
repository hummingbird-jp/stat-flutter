import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stat_flutter/components/thin_circular_progress_indicator.dart';
import 'package:stat_flutter/utils/constants.dart';
import 'package:stat_flutter/screens/team_screen.dart';
import 'package:stat_flutter/components/rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  String? displayName;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Hero(
                  tag: 'Stat! logo',
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/logo.jpg'),
                    radius: 50.0,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 200.0,
                    maxWidth: 400.0,
                  ),
                  child: TextField(
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
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 200.0,
                    maxWidth: 400.0,
                  ),
                  child: TextField(
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
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 200.0,
                    maxWidth: 400.0,
                  ),
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      displayName = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintStyle: kHintTextStyle,
                      hintText: 'What do people call you?',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Hero(
                  tag: 'register button',
                  child: RoundedButton(
                    color: Theme.of(context).colorScheme.secondary,
                    label: 'Register',
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await _auth
                            .createUserWithEmailAndPassword(
                                email: email, password: password)
                            .then((result) {
                          return result.user!.updateProfile(
                            displayName: displayName,
                          );
                        });
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pushNamed(context, TeamScreen.id);
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        throw (FirebaseAuthException);
                      }
                    },
                  ),
                ),
              ],
            ),
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
    );
  }
}
