import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Image.asset(
            "assets/nokoneksi.png",
            fit: BoxFit.cover,
            width: 250,
            height: 250,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Tidak Ada Koneksi Internet",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Kamu tidak terhubung ke internet",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          )
        ],  
      ),
    );
  }
}
