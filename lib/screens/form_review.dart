import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class FormPenilaianTari extends StatefulWidget {
  final int idTari;
  const FormPenilaianTari({Key? key, required this.idTari}) : super(key: key);

  @override
  State<FormPenilaianTari> createState() => _FormPenilaianTariState();
}

class _FormPenilaianTariState extends State<FormPenilaianTari> {
  final List<Map<String, dynamic>> listTari = [
    {
      'id': 1,
      'judul': "Tari Campak",
      'image': "assets/images/tari/tari-campak.jpg",
      'asal': "Bangka",
      'deskripsi':
          "Tari Campak adalah tarian tradisional Bangka yang biasanya dibawakan untuk menyambut tamu dan dalam acara adat. Gerakannya lincah dan energik, menampilkan kekompakan penari pria dan wanita.",
    },
    {
      'id': 2,
      'judul': "Tari Sepen",
      'image': "assets/images/tari/tari-sepen.jpeg",
      'asal': "Bangka Tengah",
      'deskripsi':
          "Tari Sepen berasal dari Bangka Tengah dan biasanya ditampilkan dalam perayaan adat atau pesta rakyat. Tarian ini menonjolkan gerakan berputar dan harmonisasi antara penari laki-laki dan perempuan.",
    },
    {
      'id': 3,
      'judul': "Tari Kedidi",
      'image': "assets/images/tari/tari-kedidi.png",
      'asal': "Bangka Selatan",
      'deskripsi':
          "Tari Kedidi adalah tarian rakyat Bangka Selatan yang terkenal dengan gerakan kaki cepat seperti burung kedidi, simbol keceriaan dan semangat masyarakat lokal.",
    },
    {
      'id': 4,
      'judul': "Tari Men Sahang",
      'image': "assets/images/tari/tari-men-sahang.jpg",
      'asal': "Bangka",
      'deskripsi':
          "Tari Men Sahang adalah tarian yang biasanya dilakukan untuk upacara adat atau ritual tertentu di Bangka. Gerakannya anggun dengan iringan musik tradisional khas setempat.",
    },
    {
      'id': 5,
      'judul': "Tari Beripat Beregong",
      'image': "assets/images/tari/tari-beripat-beregong.jpg",
      'asal': "Belitung",
      'deskripsi':
          "Tari Beripat Beregong berasal dari Belitung, menampilkan gerakan tangan yang elegan dan berulang seperti membentuk pola geometris. Tarian ini melambangkan keharmonisan dan keseimbangan hidup.",
    },
    {
      'id': 6,
      'judul': "Tari Sambut",
      'image': "assets/images/tari/tari-sambut.jpg",
      'asal': "Bangka Barat",
      'deskripsi':
          "Tari Sambut adalah tarian penyambutan tamu di Bangka Barat. Gerakannya hangat dan ramah, menunjukkan sopan santun dan keramahan masyarakat setempat.",
    },
    {
      'id': 7,
      'judul': "Tari Zapin",
      'image': "assets/images/tari/tari-zapin.jpeg",
      'asal': "Bangka Belitung",
      'deskripsi':
          "Tari Zapin merupakan tarian Melayu yang berkembang di Bangka Belitung. Gerakannya lembut dan ritmis, biasanya dipentaskan untuk hiburan maupun dakwah budaya Islam.",
    },
    {
      'id': 8,
      'judul': "Tari Dincak Dambus",
      'image': "assets/images/tari/tari-dincak-dambus.jpg",
      'asal': "Bangka",
      'deskripsi':
          "Tari Dincak Dambus adalah tarian rakyat Bangka yang menonjolkan gerakan kaki cepat dengan iringan musik tradisional dambus. Tarian ini menggambarkan kegembiraan masyarakat lokal.",
    },
  ];

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  double _rating = 0;

  @override
  void dispose() {
    _namaController.dispose();
    _reviewController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_namaController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Nama tidak boleh kosong')));
      return;
    }

    // Tampilkan data yang disubmit
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data Penilaian'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${_namaController.text}'),
            const SizedBox(height: 8),
            Text('Rating: $_rating'),
            const SizedBox(height: 8),
            Text('Review: ${_reviewController.text}'),
            const SizedBox(height: 8),
            Text('Deskripsi: ${_deskripsiController.text}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleReset() {
    setState(() {
      _namaController.clear();
      _reviewController.clear();
      _deskripsiController.clear();
      _rating = 0;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final tari = listTari.firstWhere((t) => t['id'] == widget.idTari);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/FormScreen.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Header
                  Text(
                    'Form Penilaian\n${tari['judul']}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.moul(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Image
                  Container(
                    width: 120,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(tari['image']),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFF3D8E6).withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Form Container
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Color(0xFFF3D8E6),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama Field
                        const Text(
                          'Nama :',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _namaController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFEDBDD8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Color(0xFFAB79AC),
                                width: 5,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Rating
                        const Text(
                          'Rating :',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: RatingBar.builder(
                            initialRating: _rating,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemSize: 40,
                            itemPadding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            itemBuilder: (context, _) =>
                                const Icon(Icons.star, color: Colors.purple),
                            unratedColor: Colors.purple.shade100,
                            onRatingUpdate: (rating) {
                              setState(() {
                                _rating = rating;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Judul Review Field
                        const Text(
                          'Judul Review / persaaan anda :',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _reviewController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFEDBDD8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Color(0xFFAB79AC),
                                width: 5,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Deskripsi Field
                        const Text(
                          'Deskripsi :',
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _deskripsiController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFEDBDD8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                color: Color(0xFFAB79AC),
                                width: 5,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _handleReset,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink.shade300,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 5,
                                ),
                                child: const Text(
                                  'Kembali',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _handleSubmit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple.shade300,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 5,
                                ),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
