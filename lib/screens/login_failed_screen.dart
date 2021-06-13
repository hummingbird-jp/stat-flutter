import 'package:flutter/material.dart';
import 'package:stat_flutter/components/rounded_button.dart';
import 'package:stat_flutter/screens/welcome_screen.dart';

class LoginFailedScreen extends StatefulWidget {
  const LoginFailedScreen({Key? key}) : super(key: key);

  static const String id = 'login_failed_screen';

  @override
  _LoginFailedScreenState createState() => _LoginFailedScreenState();
}

class _LoginFailedScreenState extends State<LoginFailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Log In failed...'),
          ),
          RoundedButton(
            color: Colors.grey,
            label: 'Title →',
            onPressed: () => Navigator.pushNamed(context, WelcomeScreen.id),
          ),
        ],
      ),
    );
  }
}
