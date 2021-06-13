import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stat_flutter/components/rounded_outline_button.dart';
import 'package:stat_flutter/utils/constants.dart';
import 'package:stat_flutter/screens/login_failed_screen.dart';
import 'package:stat_flutter/screens/team_screen.dart';
import 'package:stat_flutter/components/thin_circular_progress_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
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
                      hintText: 'Enter your email',
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
                      hintText: 'Enter your password',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Hero(
                  tag: 'login button',
                  child: RoundedOutlineButton(
                    color: Theme.of(context).colorScheme.secondary,
                    label: 'Log In',
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        const CircularProgressIndicator();
                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        Navigator.pushNamed(context, TeamScreen.id);
                        setState(() {
                          isLoading = false;
                        });
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.pushNamed(context, LoginFailedScreen.id);
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
