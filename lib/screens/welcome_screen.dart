import 'package:flutter/material.dart';
import 'package:stat_flutter/components/rounded_button.dart';
import 'package:stat_flutter/components/rounded_outline_button.dart';
import 'package:stat_flutter/screens/login_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:stat_flutter/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stat! Flutter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'Stat! logo',
              child: CircleAvatar(
                backgroundImage: AssetImage('images/logo.jpg'),
                radius: 70.0,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Hero(
              tag: 'login button',
              child: RoundedOutlineButton(
                color: Theme.of(context).accentColor,
                label: 'Log In',
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Hero(
              tag: 'register button',
              child: RoundedButton(
                color: Theme.of(context).accentColor,
                label: 'Register',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
