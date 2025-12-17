import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts/models/review_model.dart';
import 'package:uts/services/review_service.dart';
import 'package:uts/widgets/form_input.dart';
import 'package:uts/widgets/text_form_field_form_input.dart';

class FormPenilaianTari extends StatefulWidget {
  final int idTari;
  final String idUser;
  const FormPenilaianTari({
    super.key,
    required this.idTari,
    required this.idUser,
  });

  @override
  State<FormPenilaianTari> createState() => _FormPenilaianTariState();
}

class _FormPenilaianTariState extends State<FormPenilaianTari> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _deskripsiController = TextEditingController();
  final ReviewService reviewService = ReviewService();
  double _rating = 0;
  bool isLoading = false;

  @override
  void dispose() {
    _deskripsiController.dispose();
    super.dispose();
  }

  void handleSubmit() async {
    if (isLoading) return;

    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final review = ReviewModel(
        idUser: widget.idUser,
        idTari: widget.idTari,
        rating: _rating,
        deskripsi: _deskripsiController.text.trim(),
      );

      await reviewService.createReview(review);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Review berhasil dikirim")));

      Navigator.pop(context);
      
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal mengirim review")));
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void handleReset() {
    setState(() {
      _deskripsiController.clear();
      _rating = 0;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FormInput(
      formKey: formKey,
      titleForm: "Form Penilaian",
      fieldsInput: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Color(0xFFF3D8E6),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rating :',
              style: GoogleFonts.katibeh(
                color: Color(0xFFC063BE),
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            Center(
              child: RatingBar.builder(
                initialRating: _rating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 40,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Color(0xFFD088BE)),
                unratedColor: Colors.purple.shade100,
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),

            TextFormFieldFormInput(
              controller: _deskripsiController,
              label: "Deskripsi:",
              maxLine: 5,
            ),
          ],
        ),
      ),
      handleReset: handleReset,
      handleSubmit: handleSubmit,
    );
  }
}
