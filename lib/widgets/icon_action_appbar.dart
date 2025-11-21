import 'package:flutter/material.dart';

class IconActionAppbar extends StatelessWidget {
  final IconData icon;
  final String pesan;

  const IconActionAppbar({Key? key, required this.icon, required this.pesan})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xFFF4A9C2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(pesan), duration: Duration(seconds: 2)),
            );
          },
          icon: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
