import 'package:flutter/material.dart';

class VaTypingIndicator extends StatefulWidget {
  const VaTypingIndicator({super.key});

  @override
  Va_TypingIndicatorState createState() => Va_TypingIndicatorState();
}

class Va_TypingIndicatorState extends State<VaTypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _getOpacityForDot(index),
              child: child,
            );
          },
          child: Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: const BoxDecoration(
              color: Colors.white70,
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }

  double _getOpacityForDot(int index) {
    double progress = _controller.value;
    double offset = (index * 0.3) % 1;
    return (1 - (progress - offset).abs()).clamp(0.0, 1.0);
  }
}
