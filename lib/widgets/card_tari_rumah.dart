import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardTariRumah extends StatelessWidget {
  final Map<String, dynamic> item;
  final bool liked;
  final VoidCallback? onLike;
  final VoidCallback? action;

  const CardTariRumah({
    Key? key,
    required this.item,
    required this.onLike,
    required this.liked,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: 300,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(item['id'] % 2 == 1 ? 0xFFEBBCDF : 0xFFDBB6E0),
        ),
        child: Column(
          children: [
            Container(
              width: 250,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 8),
                image: DecorationImage(
                  image: AssetImage(item['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFA864A9), width: 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item['judul'],
                    style: GoogleFonts.judson(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB02D8F),
                    ),
                  ),
                  IconButton(
                    onPressed: onLike,
                    icon: Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                      color: liked ? Colors.red : Color(0xFFB02D8F),
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 30,
                  color: Color(0xFFB02D8F),
                ),
                Text(
                  item['asal'],
                  style: GoogleFonts.judson(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
