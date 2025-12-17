import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uts/models/review_model.dart';
import 'package:uts/models/user_model.dart';
import 'package:uts/services/auth_service.dart';
import 'package:uts/services/review_service.dart';
import 'package:uts/widgets/icon_action_appbar.dart';

class Review extends StatefulWidget {
  final int idTari;
  const Review({super.key, required this.idTari});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final ReviewService reviewService = ReviewService();
  final AuthService authService = AuthService();
  late Future<List<ReviewModel>> dataReview;
  String? userLevel;

  @override
  void initState() {
    super.initState();
    dataReview = reviewService.getReviewByIDTari(widget.idTari);
    _loadUserData();
  }

  void _refresh() {
    setState(() {
      dataReview = reviewService.getReviewByIDTari(widget.idTari);
    });
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userLevel = prefs.getString('userLevel');
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dataReview,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Tidak ada data"));
        } else {
          final listReview = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.only(top: 60),
            itemCount: listReview.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final review = listReview[index];
              final n = review.rating;
              final k = 5 - n;

              return FutureBuilder<UserModel>(
                future: authService.getUserByID(review.idUser),
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
                    width: 250,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? Color(0xFFF2B8D5)
                          : Color(0xFFDBB6E0),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Transform.translate(
                          offset: const Offset(80, -55),
                          child: CircleAvatar(
                            radius: 47,
                            backgroundColor: index % 2 == 0
                                ? Color(0xFFF2B8D5)
                                : Color(0xFFDBB6E0),
                            child: CircleAvatar(
                              radius: 42,
                              backgroundImage:
                                  (user.photo.toString().isNotEmpty)
                                  ? authService.getImageProvider(user.photo)
                                  : AssetImage(
                                          'assets/images/default-profile.png',
                                        )
                                        as ImageProvider,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 40, 12, 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (var i = 0; i < n; i++)
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFD088BE),
                                      size: 30,
                                    ),

                                  for (var i = 0; i < k; i++)
                                    Icon(
                                      Icons.star_border,
                                      color: Color(0xFFD088BE),
                                      size: 30,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              Text(
                                user.username,
                                style: GoogleFonts.judson(
                                  fontSize: 20,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 3),

                              const Divider(
                                color: Color(0xFFD088BE),
                                thickness: 2,
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Text(
                                  review.deskripsi,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.namdhinggo(
                                    fontSize: 12,
                                    color: Colors.black87,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (userLevel == 'admin')
                          Positioned(
                            bottom: 10,
                            right: 10,

                            child: IconActionAppbar(
                              icon: Icons.delete,
                              onPressed: () async {
                                await reviewService.deleteReview(
                                  review.docId!,
                                  review.idUser,
                                );
                                _refresh();
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
