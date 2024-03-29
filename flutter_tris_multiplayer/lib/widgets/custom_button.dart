import 'package:flutter/material.dart';
import 'package:flutter_tris_multiplayer/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;

  final String text;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: buttonColor,
            blurRadius: 5,
            spreadRadius: 0,
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            width,
            50,
          ),
          backgroundColor: buttonColor,
        ),
      ),
    );
  }
}
