import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldRegister extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validation;

  const TextFormFieldRegister({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.validation,
  });
  @override
  State<TextFormFieldRegister> createState() => _TextFormFieldRegisterState();
}

class _TextFormFieldRegisterState extends State<TextFormFieldRegister> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final bool isPasswordField =
        widget.label == "Password" || widget.label == "Confirm Password";

    return TextFormField(
      controller: widget.controller,
      obscureText: isPasswordField ? _obscurePassword : false,
      decoration: InputDecoration(
        label: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(widget.label),
        ),
        labelStyle: GoogleFonts.josefinSans(
          color: Color(0xFFCC91D2),
          fontSize: 18,
        ),
        icon: Icon(widget.icon, color: Color(0xFFCC91D2), size: 40),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFCC91D2), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFCC91D2), width: 2),
        ),
        suffixIcon: isPasswordField
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Color(0xFFCC91D2),
                ),
              )
            : null,
      ),
      validator: widget.validation,
      style: GoogleFonts.josefinSans(
        color: Color(0xFFCC91D2),
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    );
  }
}
