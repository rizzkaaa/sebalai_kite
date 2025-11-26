import 'package:flutter/material.dart';

class CardBajuMakan extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback action;
  final bool liked;
  final bool bookmarked;
  final VoidCallback? onLike;
  final VoidCallback? onBookmark;

  const CardBajuMakan({
    required this.item,
    required this.action,
    required this.liked,
    required this.bookmarked,
    required this.onLike,
    required this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width:300,
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Color(0xFFEBBCDF),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            // Gambar
            SizedBox(
              child: Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[300],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    item['image'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            // Konten bawah
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item['judul'],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFB9489D),
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: onLike,
                    child: Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: Color(0xFFB9489D),
                    ),
                  ),
                  SizedBox(width: 6),
                  GestureDetector(
                    onTap: onBookmark,
                    child: Icon(
                      bookmarked ? Icons.bookmark : Icons.bookmark_border,
                      size: 20,
                      color: Color(0xFFB9489D),
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.more_horiz, size: 20, color: Color(0xFFB9489D)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
