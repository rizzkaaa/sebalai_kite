import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/screens/form_review.dart';
import 'package:uts/widgets/review.dart';

class DetailTari extends StatelessWidget {
  final int idTari;
  DetailTari({Key? key, required this.idTari}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final tari = listTari.firstWhere((t) => t['id'] == idTari);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.zero,
              height: 280,
              width: double.infinity,
              child: Image.asset(tari['image'], fit: BoxFit.cover),
            ),

            Column(
              children: [
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 100),
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xFFF4A9C2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.subdirectory_arrow_left_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xFFF4A9C2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: Icon(Icons.more_horiz, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          color: Color(0xFFCBC2C2),
                          thickness: 5,
                          indent: 130,
                          endIndent: 130,
                        ),
                        const SizedBox(height: 30),

                        Text(
                          tari['judul'],
                          style: GoogleFonts.moul(
                            fontSize: 30,
                            color: const Color(0xFFC97DAF),
                          ),
                        ),
                        Divider(color: Color(0xFFCBC2C2), thickness: 2),
                        const SizedBox(height: 10),
                        Text(
                          tari['deskripsi'],
                          style: GoogleFonts.namdhinggo(
                            fontSize: 12,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),

                        Divider(color: Color(0xFFCBC2C2), thickness: 2),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Review",
                                style: GoogleFonts.odorMeanChey(
                                  fontSize: 30,
                                  color: Color(0xFFE094A7),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 30),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      width: 2,
                                      color: Color(0xFFCBC2C2),
                                    ),
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>      
                                            FormPenilaianTari(idTari: idTari,), 
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                    ),
                                    backgroundColor: Color(0xFFC3A4C7),
                                  ),
                                  child: Text(
                                    "Beri Review",
                                    style: GoogleFonts.judson(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Color(0xFFCBC2C2), thickness: 2),

                        Review(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
