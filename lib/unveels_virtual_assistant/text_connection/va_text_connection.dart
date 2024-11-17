import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_new/unveels_virtual_assistant/components/va_start_button.dart';
import 'package:test_new/unvells/app_widgets/flux_image.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_routes.dart';

class VaOnboardingScreen extends StatelessWidget {
  const VaOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF47330A), Color(0xFF0E0A02), Colors.black],
          ),
        ),
        child: Stack(
          children: [
            // Wave pattern
            Positioned(
              top: 0,
              right: 0,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 180),
                painter: WavePatternPainter(),
              ),
            ),
            // Back button
            Positioned(
              top: 40,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            // Main content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  const FluxImage(
                    imageUrl: AppImages.placeholder,
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Lato'),
                      children: [
                        TextSpan(text: 'Welcome to '),
                        TextSpan(
                          text: 'Sarah',
                          style: TextStyle(
                            color: Color(0xFFD4AF37),
                          ),
                        ),
                        TextSpan(text: ', Your\nVirtual Shopping Assistant'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Description text
                  Text(
                    "Hello and welcome! I'm Sarah, here to assist you with all your shopping needs.",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Lato',
                    ),
                  ),
                  const Spacer(),
                  // Start button
                  Padding(
                    padding: EdgeInsets.only(bottom: 32.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: VaStartButton(
                        buttonText: 'Start',
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.vaChooseConnection);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WavePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final waveHeight = size.height / 10; // Reduced amplitude
    final waveLength = size.width / 1.6;
    final numberOfWaves =
        (size.height / waveHeight).ceil(); // Increased density

    // Apply rotation
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(27 * pi / 180); // 27 degrees rotation
    canvas.translate(-size.width / 2, -size.height / 2);

    for (var i = -10; i < numberOfWaves; i++) {
      final path = Path();
      final startY = i * waveHeight * 1;

      path.moveTo(-size.width, startY);

      for (double x = -size.width; x <= size.width * 2; x += 1) {
        final y = startY + waveHeight * sin((x / waveLength) * 2 * pi);
        path.lineTo(x, y);
      }

      canvas.drawPath(path, paint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
