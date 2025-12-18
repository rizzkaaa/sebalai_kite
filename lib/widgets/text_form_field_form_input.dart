import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldFormInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int? maxLine;
  final TextInputType? number;
  final ValueChanged<String>? onChanged;


  const TextFormFieldFormInput({
    super.key,
    required this.controller,
    required this.label,
    this.maxLine,
    this.number,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.katibeh(
            color: Color(0xFFC063BE),
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          controller: controller,
          maxLines: maxLine ?? 1,
          keyboardType: number ?? TextInputType.text,
          onChanged: onChanged,
          style: TextStyle(
            color: Color(0xFFAB79AC),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFEDBDD8).withOpacity(0.8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Color(0xFFAB79AC), width: 3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Color(0xFFAB79AC), width: 3),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
      ],
    );
  }
}
