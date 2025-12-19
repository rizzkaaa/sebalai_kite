import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/widgets/chat_widget.dart';
import 'package:uts/widgets/icon_action_appbar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF9B6D6), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "SerumpunAI",
            style: TextStyle(
              fontSize: 30,
              color: Color(0xFFC97DAF),
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Container(
            margin: const EdgeInsets.only(left: 15),
            child: IconActionAppbar(
              tooltip: "kembali",
              icon: Icons.reply_rounded,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/bg_serumpunai.png',
                    fit: BoxFit.contain,
                    opacity: const AlwaysStoppedAnimation(0.4),
                  ),
                  Text(
                    "Selamat Datang di",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "SerumpunAI",
                    style: GoogleFonts.museoModerno(
                      color: Color.fromARGB(111, 219, 103, 159),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ChatWidget(floating: false),
          ],
        ),
      ),
    );
  }
}
