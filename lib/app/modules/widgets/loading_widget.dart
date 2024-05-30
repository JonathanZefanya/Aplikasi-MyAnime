import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String text;
  final double mediaQuery;
  final Color color;
  const LoadingWidget({
    super.key,
    required this.text,
    required this.mediaQuery,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: mediaQuery,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.blue,
            color: color,
            strokeWidth: 10,
            strokeAlign: 3,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            text,
            style: TextStyle(
              // fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
