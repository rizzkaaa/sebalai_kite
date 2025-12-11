import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldEdit extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  const TextFormFieldEdit({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
  });

  @override
  State<TextFormFieldEdit> createState() => _TextFormFieldEditState();
}

class _TextFormFieldEditState extends State<TextFormFieldEdit> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final bool isPasswordField =
        widget.label == "Password Baru" || widget.label == "Password Lama";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isPasswordField ? _obscurePassword : false,
        decoration: InputDecoration(
          label: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(widget.label),
          ),
          labelStyle: GoogleFonts.josefinSans(
            color: Color(0xFFB64BC9),
            fontSize: 18,
          ),
          filled: true,
          fillColor: Colors.white54,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDD80E0), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDD80E0), width: 2),
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
        validator: widget.validator,
        style: GoogleFonts.montserrat(
          color: Colors.black45,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}
