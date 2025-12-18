import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uts/controllers/saran_controller.dart';
import 'package:uts/widgets/icon_action_appbar.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;
import 'package:timeago/timeago.dart' as timeago;

class SaranScreen extends StatefulWidget {
  const SaranScreen({super.key});

  @override
  State<SaranScreen> createState() => _SaranScreenState();
}

class _SaranScreenState extends State<SaranScreen> {
  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('id', timeago.IdMessages());

    Future.delayed(Duration(milliseconds: 2000), () {
      context.read<SaranController>().markAllAsRead();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SaranController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Kotak Saran",
          style: GoogleFonts.neuton(color: Color(0xFFC97DAF), fontSize: 25),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: IconActionAppbar(
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
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: controller.saran,
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

            final saran = snapshot.data!;

            return ListView.builder(
              itemCount: saran.length,
              itemBuilder: (context, index) {
                final s = saran[index];
                final timestamp = s['time'] as Timestamp?;
                final dateTime = timestamp?.toDate();

                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: inset.BoxDecoration(
                      color: s['isReplyed']
                          ? Color(0xFFF8E8ED)
                          : Color(0xFFEA90CB),
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
                                    colors: s['isReplyed']
                                        ? [
                                            Color(0xFFEA90CB),
                                            Color(0xFFEA90CB).withOpacity(0.1),
                                          ]
                                        : [
                                            Colors.white,
                                            Colors.white.withOpacity(0.1),
                                          ],
                                  ),
                                ),
                                child: Text(
                                  s['message'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            if (!s['isReplyed'])
                              IconButton(
                                onPressed: () async {
                                  try {
                                    await controller.replySaran(
                                      s['id'],
                                      s['idUser'],
                                    );

                                    if (!context.mounted) return;

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Saran berhasil dibalas'),
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  } catch (e) {
                                    if (!context.mounted) return;

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Gagal membalas saran'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.reply,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),

                            IconButton(
                              onPressed: () async {
                                await controller.deleteSaran(s['id']);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: s['isReplyed']
                                    ? Color(0xFFC97DAF)
                                    : Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        if (dateTime != null)
                          Text(
                            timeago.format(dateTime, locale: 'id'),
                            style: TextStyle(
                              fontSize: 12,
                              color: s['isReplyed']
                                  ? Colors.grey[700]
                                  : Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
