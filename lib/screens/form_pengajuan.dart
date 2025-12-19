import 'package:flutter/material.dart';
import 'package:uts/screens/home_screen.dart';
import 'package:uts/services/pengajuan_service.dart';
import 'package:uts/widgets/dialog_confirm.dart';
import 'package:uts/widgets/form_input.dart';
import 'package:uts/widgets/text_form_field_form_input.dart';

class FormPengajuan extends StatefulWidget {
  final String idUser;
  const FormPengajuan({super.key, required this.idUser});

  @override
  State<FormPengajuan> createState() => _FormPengajuanState();
}

class _FormPengajuanState extends State<FormPengajuan> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _reasonController = TextEditingController();
  final PengajuanService pengajuanService = PengajuanService();
  bool isLoading = false;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void handleSubmit() async {
    if (isLoading) return;

    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      Navigator.pop(context);
      final String reason = _reasonController.text.trim();
      await pengajuanService.createPengajuan(widget.idUser, reason);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Pengajuan penghapusan akun berhasil dikirim"),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengirim pengajuan penghapusan akun")),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void handleReset() {
    setState(() {
      _reasonController.clear();
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FormInput(
      formKey: formKey,
      titleForm: "Form Pengajuan Penghapusan akun",
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
              controller: _reasonController,
              label: "Alasan:",
              maxLine: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Berikan Alasan";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      handleReset: handleReset,
      handleSubmit: () {
        if (_reasonController.text.trim().isEmpty ||
            _reasonController.text.trim() == '')
          return;

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return DialogConfirm(
              title: "Konfirmasi",
              deskripsi:
                  "Permintaan anda akan diproses paling lama 3x24jam, terima kasih.",
              onPressed: handleSubmit,
            );
          },
        );
      },
    );
  }
}
