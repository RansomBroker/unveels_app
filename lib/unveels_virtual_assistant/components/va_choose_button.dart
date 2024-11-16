import 'package:flutter/material.dart';

class VaChooseButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const VaChooseButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 374),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFCA9C43),
                Color(0xFF916E2B),
                Color(0xFF6A4F1B),
                Color(0xFF473209),
              ],
              stops: [0.0, 0.274, 0.594, 1.0],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Container(
            constraints: const BoxConstraints(minHeight: 35),
            alignment: Alignment.center,
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: 'Lato',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
