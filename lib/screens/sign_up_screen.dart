import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart' as inset;
import 'package:provider/provider.dart';
import 'package:uts/controllers/auth_controller.dart';
import 'package:uts/widgets/text_form_field_register.dart';

class SignUpScreen extends StatefulWidget {
  final Function(bool) changePage;
  const SignUpScreen({super.key, required this.changePage});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerController = context.watch<AuthController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () => widget.changePage(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Masuk",
                          style: GoogleFonts.junge(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(50),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 120,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFDCB7E4),
                                      Color(0xFFF2ADF0),
                                      Color(0xFFDCB7E4),
                                    ],
                                    stops: [0.0, 0.5, 1.0],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                  ),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: inset.BoxDecoration(
                                    boxShadow: [
                                      inset.BoxShadow(
                                        color: Colors.black45.withOpacity(0.5),
                                        blurRadius: 2,
                                        offset: Offset(3, 0),
                                        inset: true,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 520,
                                decoration: inset.BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                  boxShadow: [
                                    inset.BoxShadow(
                                      color: Colors.black38.withOpacity(0.7),
                                      blurRadius: 2,
                                      offset: Offset(3, -3),
                                      inset: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                width: 180,
                                height: 180,
                                decoration: inset.BoxDecoration(
                                  color: Color(0xFFE7CBF0),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Color(0xFFCC91D2),
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    inset.BoxShadow(
                                      color: Colors.black45.withOpacity(0.5),
                                      blurRadius: 2,
                                      offset: Offset(4, -3),
                                      inset: true,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/Peta.png",
                                      fit: BoxFit.cover,
                                      width: 130,
                                    ),
                                    Text(
                                      "Sebalai Kite",
                                      style: GoogleFonts.aclonica(
                                        color: Color(0xFFC16BCB),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          "Daftar",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFC16BCB),
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(height: 25),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Column(
                            children: [
                              TextFormFieldRegister(
                                controller: _usernameController,
                                label: "Username",
                                icon: Icons.person_2_outlined,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Username tidak boleh kosong";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormFieldRegister(
                                controller: _emailController,
                                label: "Email",
                                icon: Icons.mail_outlined,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email tidak boleh kosong";
                                  }
                                  if (!value.contains('@')) {
                                    return "Masukkan email yang valid";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormFieldRegister(
                                controller: _passwordController,
                                label: "Password",
                                icon: Icons.lock_outline_rounded,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password tidak boleh kosong";
                                  }
                                  if (value.length < 6) {
                                    return "Minimal 6 karakter";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormFieldRegister(
                                controller: _confirmPasswordController,
                                label: "Confirm Password",
                                icon: Icons.vpn_key_outlined,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Konfirmasi Password Anda";
                                  }
                                  if (value !=
                                      _passwordController.text.trim()) {
                                    return "Masukkan password yang benar";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: ElevatedButton(
                    onPressed: registerController.isLoading
                        ? null
                        : () async {
                            if (!_formKey.currentState!.validate()) return;

                            final success = await registerController.register(
                              _usernameController.text.trim(),
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );

                            if (success) {
                              widget.changePage(true);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(registerController.error!),
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                    ),
                    child: registerController.isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFCBA2EC),
                                  Color(0xFFF2ADF0),
                                  Color(0xFFCBA2EC),
                                ],
                                stops: [0.0, 0.5, 1.0],
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: inset.BoxDecoration(
                                boxShadow: [
                                  inset.BoxShadow(
                                    color: Colors.black45.withOpacity(0.5),
                                    blurRadius: 2,
                                    offset: Offset(3, -3),
                                    inset: true,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  "Daftar",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
