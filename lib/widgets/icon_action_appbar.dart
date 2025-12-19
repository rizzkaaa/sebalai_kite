import 'package:flutter/material.dart';

class IconActionAppbar extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;

  const IconActionAppbar({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Color(0xFFF4A9C2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
          tooltip: tooltip,
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          icon: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
