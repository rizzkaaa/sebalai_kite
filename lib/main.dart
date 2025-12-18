import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uts/controllers/auth_controller.dart';
import 'package:uts/controllers/chat_controller.dart';
import 'package:uts/controllers/notification_controller.dart';
import 'package:uts/controllers/saran_controller.dart';
import 'package:uts/screens/form_review.dart';
import 'package:uts/screens/home_screen.dart';
import 'package:uts/splashScreen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env", isOptional: false);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => ChatController()),
        ChangeNotifierProvider(create: (_) => NotificationController()),
        ChangeNotifierProvider(create: (_) => SaranController()),
      ],
      child: MyApp(),
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
      home: HomeScreen(),
    );
  }
}
