import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VaVoiceRecordButton extends StatelessWidget {
  final bool recording;
  final VoidCallback onLongPressStart;
  final VoidCallback onLongPressEnd;

  const VaVoiceRecordButton({
    super.key,
    required this.recording,
    required this.onLongPressStart,
    required this.onLongPressEnd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressDown: (_) => onLongPressStart(),
      onLongPressEnd: (_) => onLongPressEnd(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 70, // size-28 in px
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  recording
                      ? const Color.fromRGBO(255, 255, 255, 0.0175)
                      : const Color.fromRGBO(255, 255, 255, 0.0175),
                ],
              ),
            ),
          ),
          //Inner circle 1
          Container(
            width: 60, // size-20 in px
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  recording
                      ? const Color.fromRGBO(255, 255, 255, 0.1925)
                      : const Color.fromRGBO(40, 40, 40, 0.1925),
                ],
              ),
            ),
          ),
          // Inner circle 2
          Container(
            width: 50, // size-14 in px
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  recording
                      ? const Color.fromRGBO(255, 255, 255, 0.1925)
                      : const Color.fromRGBO(40, 40, 40, 0.1925),
                ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
          // Small circle
          Container(
            width: 36, // size-9 in px
            height: 36,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFFCA9C43),
                  Color(0xFF916E2B),
                  Color(0xFF6A4F1B),
                  Color(0xFF473209),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Icon
          Icon(
            recording ? CupertinoIcons.waveform : CupertinoIcons.mic,
            size: recording ? 36 : 24, // size-9 and size-6 in px
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
