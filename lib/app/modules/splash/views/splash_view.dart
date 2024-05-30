import 'package:flutter/material.dart';
import 'package:myanime/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacementNamed(Routes.BOTTOM_BAR);
    });
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue[900]!,
              Colors.blue,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Image.asset(
            "assets/logo.jpg",
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
