import 'package:flutter/material.dart';
import 'package:stat_flutter/screens/login_screen.dart';
import 'package:stat_flutter/screens/registration_screen.dart';
import 'package:stat_flutter/screens/team_screen.dart';
import 'package:stat_flutter/screens/welcome_screen.dart';

void main() {
  runApp(Stat());
}

class Stat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.transparent,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        TeamScreen.id: (context) => TeamScreen(),
      },
    );
  }
}
