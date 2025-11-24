import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uts/controllers/chat_controller.dart';
import 'package:uts/screens/home_screen.dart';
import 'package:uts/screens/sign_in_up_screen.dart';
import 'package:uts/splashScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ChatController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(textTheme: GoogleFonts.montagaTextTheme()),
      debugShowCheckedModeBanner: false,
      home: SignInUpScreen(),
    );
  }
}
