import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stat_flutter/screens/login_failed_screen.dart';
import 'package:stat_flutter/screens/login_screen.dart';
import 'package:stat_flutter/screens/registration_screen.dart';
import 'package:stat_flutter/screens/team_screen.dart';
import 'package:stat_flutter/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:window_size/window_size.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // limit window size
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Stat! Flutter');
    setWindowMinSize(const Size(700, 500));
    setWindowMaxSize(Size.infinite);
  }
  runApp(Stat());
}

class Stat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: WelcomeScreen.id,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0D0F25),
        scaffoldBackgroundColor: Color(0xFF0D0F25),
        accentColor: Color(0xFFEB1555),
        errorColor: Colors.red,
      ),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        TeamScreen.id: (context) => TeamScreen(),
        LoginFailedScreen.id: (context) => LoginFailedScreen(),
      },
    );
  }
}
