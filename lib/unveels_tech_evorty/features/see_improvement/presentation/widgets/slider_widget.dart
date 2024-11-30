import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final double valueSlider;

  SliderWidget({required this.valueSlider});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  late double value;
  double smoothingStrength = 0.0;

  // Rentang nilai smoothingStrength
  final double minSmoothing = 0.01;
  final double maxSmoothing = 1.25;

  final List<int> labels = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];

  @override
  void initState() {
    super.initState();
    value = widget.valueSlider;
    updateSmoothingStrength();
  }

  void updateSmoothingStrength() {
    double mappedValue =
        minSmoothing + ((value - 0) / (100 - 0)) * (maxSmoothing - minSmoothing);
    setState(() {
      smoothingStrength = mappedValue;
    });
    print(smoothingStrength); // Debugging
  }

  @override
  Widget build(BuildContext context) {
    final sliderWidth = MediaQuery.of(context).size.width - 32; // Adjust width considering padding
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Labels di atas slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: labels.map((label) {
              return Text(
                label.toString(),
                style: TextStyle(
                  fontSize: value.round() == label ? 14 : 12,
                  fontWeight:
                      value.round() == label ? FontWeight.bold : FontWeight.normal,
                  color: value.round() == label ? Colors.white : Colors.grey,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Background track
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300,
                ),
              ),
              // Highlighted track
              Container(
                height: 8,
                width: sliderWidth * (value / 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFCA9C43),
                      Color(0xFF916E2B),
                      Color(0xFF6A4F1B),
                      Color(0xFF473209),
                    ],
                  ),
                ),
              ),
              // Invisible Slider
              Slider(
                activeColor: Colors.transparent,
                inactiveColor: Colors.transparent,
                value: value,
                min: 0,
                max: 100,
                onChanged: (newValue) {
                  setState(() {
                    value = newValue;
                    updateSmoothingStrength();
                  });
                },
              ),
              // Moving "Day" thumb
              Positioned(
                left: sliderWidth * (value / 100) - 20, // Thumb position adjustment
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      double newValue =
                          (details.localPosition.dx / sliderWidth) * 100;
                      value = newValue.clamp(0, 100);
                      updateSmoothingStrength();
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFCA9C43),
                          Color(0xFF916E2B),
                          Color(0xFF6A4F1B),
                          Color(0xFF473209),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Day",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
