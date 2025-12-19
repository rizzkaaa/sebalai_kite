import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uts/controllers/notification_controller.dart';
import 'package:uts/widgets/icon_action_appbar.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('id', timeago.IdMessages());

    Future.delayed(Duration(milliseconds: 2000), () {
      context.read<NotificationController>().markAllAsRead();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NotificationController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Notifikasi",
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
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: controller.notifications,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Tidak ada notifikasi'));
            }

            final notifications = snapshot.data!;

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                final timestamp = notif['time'] as Timestamp?;
                final dateTime = timestamp?.toDate();

                return GestureDetector(
                  onTap: () {
                    if (notif['beritaID'].isEmpty) {
                      print("kosong");
                    } else {
                      print("ada");
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
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
                          notif['title'],
                          style: GoogleFonts.moul(
                            color: Color(0xFFC97DAF),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

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
                                  notif['message'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: () async {
                                await controller.deleteNotification(
                                  notif['id'],
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Color(0xFFC97DAF),
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
                              color: Colors.grey[700],
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
