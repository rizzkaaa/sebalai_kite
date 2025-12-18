import 'package:flutter/material.dart';
import 'package:uts/models/berita_model.dart';
import 'package:uts/widgets/footer.dart';

class DetailBeritaScreen extends StatelessWidget {
  final BeritaModel berita;

  const DetailBeritaScreen({super.key, required this.berita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Berita',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    berita.judul,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFDE9BCD),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 30),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              berita.tanggal,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                                height: 1.6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              berita.paragraf[0],
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: Image.asset(
                          berita.image,
                          width: 140,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  ...berita.paragraf
                      .asMap()
                      .entries
                      .where((entry) => entry.key != 0)
                      .map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            entry.value,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              height: 1.6,
                            ),
                          ),
                        );
                      }),
                  // .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(color: Color(0xFFF4A9C2)),
    );
  }
}