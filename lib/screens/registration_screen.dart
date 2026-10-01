import 'package:apptest/screens/dashboard_screen.dart';
import 'package:apptest/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  Future<void> registerUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      showMessage('Please enter name and email');
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      showMessage('Please enter a valid email');
      return;
    }

    SharedPreferences preferences =
        await SharedPreferences.getInstance();

    await preferences.setString('name', name);
    await preferences.setString('email', email);

    if (!mounted) return;

    Get.offAll(DashboardScreen());
    print('Register successful');
    print('$name is logged in');
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 25,
            color: Colors.blue,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 25.w,
            vertical: 45.h,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Textfield(
                    controllername: nameController,
                    textcolor: Colors.black,
                    textsize: 17,
                    hinttext: 'Enter Name',
                    hintcolor: Colors.black38,
                    hintsize: 16,
                    textfieldcolor: Colors.transparent,
                    obscure: false,
                    textfieldradius: 14.r,
                    blurRadius: 0,
                    fieldheight: 50,
                    fieldwidth: 350.w,
                    boxshadowcolor: Colors.transparent,
                    shadowoffset: const Offset(0, 0),
                    borderwidth: 1,
                    bordercolor: Colors.grey,
                    focusedBorderColor: Colors.blue,
                    focusedBorderWidth: 2,
                  ),

                  SizedBox(height: 25.h),

                  Text(
                    'Email',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Textfield(
                    controllername: emailController,
                    textcolor: Colors.black,
                    textsize: 17,
                    hinttext: 'Enter Email',
                    hintcolor: Colors.black38,
                    hintsize: 16,
                    textfieldcolor: Colors.transparent,
                    obscure: false,
                    textfieldradius: 14.r,
                    blurRadius: 0,
                    fieldheight: 50,
                    fieldwidth: 350.w,
                    boxshadowcolor: Colors.transparent,
                    shadowoffset: const Offset(0, 0),
                    borderwidth: 1,
                    bordercolor: Colors.grey,
                    focusedBorderColor: Colors.blue,
                    focusedBorderWidth: 2,
                  ),

                  SizedBox(height: 60.h),

                  Center(
                    child: SizedBox(
                      height: 50.h,
                      width: 250.w,
                      child: ElevatedButton(
                        onPressed: registerUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
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
      ),
    );
  }
}