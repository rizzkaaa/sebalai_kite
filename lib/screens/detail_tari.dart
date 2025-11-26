import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/screens/form_review.dart';
import 'package:uts/widgets/icon_action_appbar.dart';
import 'package:uts/widgets/review.dart';
import 'package:uts/services/tari_service.dart';
import 'package:uts/models/tari_model.dart';

class DetailTari extends StatefulWidget {
  final int idTari;
  DetailTari({Key? key, required this.idTari}) : super(key: key);

  @override
  State<DetailTari> createState() => _DetailTariState();
}

class _DetailTariState extends State<DetailTari> {
  late Future<List<TariModel>> futureTari;

  @override
  void initState() {
    super.initState();
    futureTari = TariService().fetchTari();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TariModel>>(
      future: futureTari,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("Data tidak ditemukan")),
          );
        }

        final tari = snapshot.data!.firstWhere(
          (t) => t.id == widget.idTari,
          orElse: () => snapshot.data![0],
        );

        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                // FOTO ATAS
                Container(
                  padding: EdgeInsets.zero,
                  height: 280,
                  width: double.infinity,
                  child: Image.asset(tari.gambar, fit: BoxFit.cover),
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
                            IconActionAppbar(
                              icon: Icons.subdirectory_arrow_left_rounded,
                              onPressed: () {
                                Navigator.pop(context);
                              },
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
                                  icon: Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                  ),
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
                              tari.judul,
                              style: GoogleFonts.moul(
                                fontSize: 30,
                                color: const Color(0xFFC97DAF),
                              ),
                            ),
                            Divider(color: Color(0xFFCBC2C2), thickness: 2),
                            const SizedBox(height: 10),

                            Text(
                              tari.deskripsi,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                FormPenilaianTari(
                                                  idTari: widget.idTari,
                                                ),
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
      },
    );
  }
}
