import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatController extends ChangeNotifier {
  final List<Map<String, String>> messages = [];
  bool isLoading = false;

  final String apiKey = 'AIzaSyDjiMbxJpVkq_bNPO6skpB7Bk9x-8yntd0';

  ChatController() {
    messages.add({
      'role': 'assistant',
      'content': 'Halo! Apa yang ingin kamu ketahui tentang Bangka Belitung?',
    });
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    messages.add({'role': 'user', 'content': text});

    if (!text.toLowerCase().contains("bangka") &&
        !text.toLowerCase().contains("belitung")) {
      messages.add({
        'role': 'assistant',
        'content':
            'Maaf, saya hanya menjawab tentang Bangka Belitung. Mohon sertakan kata "Bangka" atau "Belitung" agar saya dapat memproses pertanyaan dengan lebih baik.',
      });
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              "role": "user",
              "parts": [
                {
                  "text":
                      """
Kamu adalah warga pribumi Bangka Belitung yang sangat tau semua budaya yang ada di Bangka Belitung.
Kamu cuma mau menjawab pertanyaan seputaran Bangka Belitung saja.

User: $text
""",
                },
              ],
            },
          ],
        }),
      );

      final data = jsonDecode(response.body);
      print('data: $data');
      final candidates = data["candidates"];
      print('candidates: $candidates');
      if (candidates == null || candidates.isEmpty) {
        messages.add({
          'role': 'assistant',
          'content': 'Maaf, tidak mendapatkan jawaban dari server.',
        });
      } else {
        final reply = candidates[0]["content"]["parts"][0]["text"] ?? "";
        messages.add({'role': 'assistant', 'content': reply});
      }
    } catch (e) {
      messages.add({'role': 'assistant', 'content': 'Error: $e'});
    }

    isLoading = false;
    notifyListeners();
  }
}
