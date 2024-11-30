import 'package:flutter/material.dart';

class LegendItemWidget extends StatefulWidget {
  final Color color;
  final int value;
  final String label;

  const LegendItemWidget({
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  State<LegendItemWidget> createState() => _LegendItemWidgetState();
}

class _LegendItemWidgetState extends State<LegendItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            "${widget.value}%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}
