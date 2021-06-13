import 'package:stat_flutter/screens/video_screen.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter/material.dart';
import 'package:stat_flutter/screens/login_failed_screen.dart';
import 'package:stat_flutter/screens/login_screen.dart';
import 'package:stat_flutter/screens/registration_screen.dart';
import 'package:stat_flutter/screens/team_screen.dart';
import 'package:stat_flutter/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (WebRTC.platformIsDesktop) {
    setWindowTitle('Stat! Flutter');
    setWindowMinSize(const Size(700, 500));
    setWindowMaxSize(Size.infinite);
  }

  runApp(const Stat());
}

class Stat extends StatelessWidget {
  const Stat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: WelcomeScreen.id,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF0D0F25),
        scaffoldBackgroundColor: const Color(0xFF0D0F25),
        accentColor: const Color(0xFFEB1555),
        errorColor: Colors.red,
        colorScheme: const ColorScheme(
          primary: Color(0xFF0D0F25),
          primaryVariant: Color(0xFF0D0F25),
          secondary: Color(0xFFEB1555),
          secondaryVariant: Color(0xFFEB1555),
          surface: Color(0xFFfff8e1),
          background: Color(0xFF0D0F25),
          error: Color(0xFFEB1555),
          onPrimary: Color(0xFF0D0F25),
          onSecondary: Color(0xFFEB1555),
          onSurface: Color(0xFFfff8e1),
          onBackground: Color(0xFF0D0F25),
          onError: Color(0xFFEB1555),
          brightness: Brightness.dark,
        ),
      ),
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        TeamScreen.id: (context) => const TeamScreen(),
        LoginFailedScreen.id: (context) => const LoginFailedScreen(),
        VideoScreen.id: (context) => const VideoScreen(),
      },
    );
  }
}
