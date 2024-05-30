import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/developer_controller.dart';


class DeveloperView extends GetView<DeveloperController> {
  // Buat UI yang bagus nama developer serta nim developer dan foto developer
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nama : Jonathan Natannael Zefanya',
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              'NIM : 1152200024',
              style: TextStyle(fontSize: 20),
            ),
            Image.network(
              '${DeveloperController.userImage}',
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}