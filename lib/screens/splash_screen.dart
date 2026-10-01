import 'package:apptest/screens/dashboard_screen.dart';
import 'package:apptest/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    SharedPreferences preferences =
        await SharedPreferences.getInstance();

    String? name = preferences.getString('name');
    String? email = preferences.getString('email');

    if (!mounted) return;

    if (name != null && email != null) {
      Get.offAll(DashboardScreen());
    } else {
      Get.offAll(RegistrationScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}