import 'package:flutter/material.dart';
import 'package:uts/services/saran_service.dart';
import 'package:uts/widgets/form_input.dart';
import 'package:uts/widgets/text_form_field_form_input.dart';

class FormSaran extends StatefulWidget {
  final String idUser;
  const FormSaran({super.key, required this.idUser});

  @override
  State<FormSaran> createState() => _FormSaranState();
}

class _FormSaranState extends State<FormSaran> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  final SaranService saranService = SaranService();
  bool isLoading = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void handleSubmit() async {
    if (isLoading) return;

    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final String message = _messageController.text.trim();
      await saranService.createSaran(widget.idUser, message);
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Saran berhasil dikirim")));

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal mengirim saran")));
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void handleReset() {
    setState(() {
      _messageController.clear();
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FormInput(
      formKey: formKey,
      titleForm: "Form Saran",
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
            TextFormFieldFormInput(
              controller: _messageController,
              label: "Pesan:",
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
