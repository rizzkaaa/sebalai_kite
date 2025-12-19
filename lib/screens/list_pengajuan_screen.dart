import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts/models/pengajuan_model.dart';
import 'package:uts/models/user_model.dart';
import 'package:uts/services/auth_service.dart';
import 'package:uts/services/pengajuan_service.dart';
import 'package:uts/widgets/dialog_confirm.dart';
import 'package:uts/widgets/icon_action_appbar.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;

class ListPengajuanScreen extends StatefulWidget {
  const ListPengajuanScreen({super.key});

  @override
  State<ListPengajuanScreen> createState() => _ListPengajuanScreenState();
}

class _ListPengajuanScreenState extends State<ListPengajuanScreen> {
  final PengajuanService pengajuanService = PengajuanService();
  final AuthService authService = AuthService();
  late Future<List<PengajuanModel>> dataPengajuan;

  @override
  void initState() {
    super.initState();
    dataPengajuan = pengajuanService.getAllAjuan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Daftar Ajuan",
          style: GoogleFonts.neuton(color: Color(0xFFC97DAF), fontSize: 25),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: IconActionAppbar(
            tooltip: "kembali",
            icon: Icons.reply,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade400, width: 1),
          ),
        ),
        child: FutureBuilder(
          future: dataPengajuan,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Tidak ada saran'));
            }

            final pengajuan = snapshot.data!;

            return ListView.builder(
              itemCount: pengajuan.length,
              itemBuilder: (context, index) {
                final p = pengajuan[index];

                return FutureBuilder<UserModel>(
                  future: authService.getUserByID(p.idUser),
                  builder: (context, userSnap) {
                    if (userSnap.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        width: 250,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (!userSnap.hasData) {
                      return const SizedBox(width: 250);
                    }

                    final user = userSnap.data!;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: inset.BoxDecoration(
                        color: Color(0xFFF8E8ED),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          inset.BoxShadow(
                            color: const Color(0xFF8B8181).withOpacity(0.1),
                            offset: const Offset(2, 2),
                            blurRadius: 5,
                            inset: true,
                          ),
                          inset.BoxShadow(
                            color: const Color(0xFFB4A8A8).withOpacity(0.25),
                            offset: const Offset(-5, -5),
                            blurRadius: 5,
                            inset: true,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.email,
                            style: GoogleFonts.moul(
                              color: Color(0xFFC97DAF),
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFEA90CB),
                                        Color(0xFFEA90CB).withOpacity(0.1),
                                      ],
                                    ),
                                  ),
                                  child: Text(
                                    p.reason,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
