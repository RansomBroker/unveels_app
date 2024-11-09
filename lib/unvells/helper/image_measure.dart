import 'package:flutter/material.dart';

class MeasureSize extends StatefulWidget {
  final Widget child;
  final Function(Size) onSizeChanged; // Callback to pass the size

  const MeasureSize({
    super.key,
    required this.child,
    required this.onSizeChanged,
  });

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  Size? widgetSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getSize();
    });
  }

  void _getSize() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size; // Get widget size
    widget.onSizeChanged(size);  // Pass the size to the callback
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
