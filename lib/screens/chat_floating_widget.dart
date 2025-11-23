import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/widgets/chat_widget.dart';
import 'package:uts/widgets/icon_action_appbar.dart';
import 'chat_page.dart';

class ChatFloatingWidget extends StatefulWidget {
  const ChatFloatingWidget({super.key});

  @override
  State<ChatFloatingWidget> createState() => _ChatFloatingWidgetState();
}

class _ChatFloatingWidgetState extends State<ChatFloatingWidget> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 255, 145, 182),
            onPressed: () => setState(() => isOpen = !isOpen),
            child: const Icon(Icons.smart_toy, color: Colors.white),
          ),
        ),

        if (isOpen)
          Positioned(
            bottom: 0,
            right: 20,
            child: Material(
              elevation: 12,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 300,
                height: 450,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Color(0xFFF9B6D6), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/bg_serumpunai.png',
                            width: 200,
                            fit: BoxFit.contain,
                            opacity: const AlwaysStoppedAnimation(0.4),
                          ),
                          Text(
                            "Selamat Datang di",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "SerumpunAI",
                            style: GoogleFonts.museoModerno(
                              color: Color.fromARGB(111, 219, 103, 159),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "SerumpunAI",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFFC97DAF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                IconActionAppbar(
                                  icon: Icons.fullscreen,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const ChatPage(),
                                      ),
                                    );
                                  },
                                ),
                                IconActionAppbar(
                                  icon: Icons.close,
                                  onPressed: () =>
                                      setState(() => isOpen = false),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const Divider(thickness: 1.5, color: Colors.white),

                        Expanded(child: ChatWidget()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}