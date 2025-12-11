import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListTileDrawer extends StatelessWidget {
  final bool selected;
  final GestureTapCallback onTap;
  final IconData icon;
  final String title;

  const ListTileDrawer({
    super.key,
    required this.selected,
    required this.onTap,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      selectedTileColor: Color(0xFFB39DDB),
      selectedColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      leading: Icon(icon, size: 50),
      title: Text(
        title,
        style: GoogleFonts.judson(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }
}
