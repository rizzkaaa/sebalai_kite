import 'package:flutter/material.dart';
import 'package:uts/screens/sign_in_screen.dart';
import 'package:uts/screens/sign_up_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool signIn = true;

  void changePage(bool condition) {
    setState(() {
      signIn = condition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFDCB7E4),
            Color(0xFFCA93D2),
            Color(0xFFA073BC),
            Color(0xFFCA93D2),
            Color(0xFFDCB7E4),
          ],
          stops: [0.0, 0.35, 0.5, 0.75, 1.0],
        ),
      ),
      child: signIn
          ? SignInScreen(changePage: changePage)
          : SignUpScreen(changePage: changePage),
    );
  }
}
