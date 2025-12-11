import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailRumahPakaian extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool liked;
  final bool bookmarked;
  final VoidCallback onLike;
  final VoidCallback onBookmark;

  const DetailRumahPakaian({
    Key? key,
    required this.item,
    required this.liked,
    required this.bookmarked,
    required this.onLike,
    required this.onBookmark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color(0xFF9B59B6), width: 4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(21),
                topRight: Radius.circular(21),
              ),
              child: Image.asset(
                item['image']!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    height: 200,
                    child: const Icon(Icons.image, size: 80),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul dan tombol aksi
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 120,
                            padding: EdgeInsets.zero,
                            child: Text(
                              item['judul'] ?? '',
                              style: GoogleFonts.judson(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFB02D8F),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Row(
                            children: [
                              IconButton(
                                onPressed: onLike,
                                icon: Icon(
                                  liked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: liked
                                      ? Colors.red
                                      : const Color(0xFFB02D8F),
                                  size: 28,
                                ),
                              ),
                              IconButton(
                                onPressed: onBookmark,
                                icon: Icon(
                                  bookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: const Color(0xFFB02D8F),
                                  size: 28,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: Color(0xFFB02D8F),
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: Color(0xFFB02D8F),
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Text(
                        item['deskripsi'] ?? '',
                        style: GoogleFonts.namdhinggo(fontSize: 18),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
