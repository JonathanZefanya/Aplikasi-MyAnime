import 'package:flutter/material.dart';

class IsiDetail extends StatelessWidget {
  final String title;
  final String isi;
  const IsiDetail({
    super.key,
    required this.title,
    required this.isi,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        Flexible(
          child: Text(
            isi,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
