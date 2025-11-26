import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uts/controllers/chat_controller.dart';

class ChatWidget extends StatelessWidget {
  final bool floating;

  const ChatWidget({super.key, this.floating = true});

  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<ChatController>(context);
    final controller = TextEditingController();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(floating ? 0 : 20),
            itemCount: chat.messages.length,
            itemBuilder: (context, index) {
              final msg = chat.messages[index];
              final isUser = msg['role'] == 'user';

              return Align(
                alignment: isUser
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isUser)
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xFFDB679F),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.smart_toy, color: Colors.white),
                      ),

                    Container(
                      constraints: BoxConstraints(
                        maxWidth: floating ? 200 : 250,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 14,
                      ),
                      decoration: BoxDecoration(
                        color: isUser ? Color(0xFFDB679F) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: !isUser ? Color(0xFFDB679F) : Colors.white,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        msg['content']!,
                        style: TextStyle(
                          fontSize: floating ? 13 : 16,
                          color: isUser ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        if (chat.isLoading)
          const Padding(
            padding: EdgeInsets.all(15),
            child: CircularProgressIndicator(color: Color(0xFFDB679F)),
          ),

        Padding(
          padding: floating
              ? EdgeInsets.fromLTRB(0, 2, 0, 2)
              : EdgeInsets.fromLTRB(20, 8, 20, 25),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Tanya apa saja...',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFDB679F),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 252, 104, 175),
                        width: 2,
                      ),
                    ),
                  ),
                  style: GoogleFonts.museoModerno(fontSize: floating ? 13 : 16),
                  onSubmitted: (v) {
                    chat.sendMessage(v);
                    controller.clear();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFDB679F),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    chat.sendMessage(controller.text);
                    controller.clear();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
