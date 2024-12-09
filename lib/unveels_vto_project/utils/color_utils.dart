import 'package:flutter/material.dart';
import 'package:test_new/logic/get_product_utils/repository/product_repository.dart';

class ColorModel {
  final String label;
  final String value;
  final String hex;

  ColorModel({required this.label, required this.value, required this.hex});
}

List<ColorModel> vtoColors = [
  ColorModel(label: "White", value: "4", hex: "#FFFFFF"),
  ColorModel(label: "Black", value: "5", hex: "#000000"),
  ColorModel(label: "Red", value: "6", hex: "#FF0000"),
  ColorModel(label: "Blue", value: "7", hex: "#1400FF"),
  ColorModel(label: "Green", value: "8", hex: "#52FF00"),
  ColorModel(label: "Beige", value: "5608", hex: "#F2D3BC"),
  ColorModel(label: "Brass", value: "5609", hex: "#B5A642"),
  ColorModel(label: "Brown", value: "5610", hex: "#3D0B0B"),
  ColorModel(
    label: "Gold",
    value: "5611",
    hex:
        "linear-gradient(90deg, #CA9C43 0%, #C79A42 33%, #BE923E 56%, #AE8638 77%, #98752F 96%, #92702D 100%)",
  ),
  ColorModel(label: "Green", value: "5612", hex: "#52FF00"),
  ColorModel(label: "Grey", value: "5613", hex: "#808080"),
  ColorModel(
    label: "Multicolor",
    value: "5614",
    hex:
        "linear-gradient(270deg, #E0467C 0%, #E55300 25.22%, #00E510 47.5%, #1400FF 72%, #FFFA00 100%)",
  ),
  ColorModel(label: "Orange", value: "5615", hex: "#FF7A00"),
  ColorModel(label: "Pink", value: "5616", hex: "#FE3699"),
  ColorModel(label: "Purple", value: "5617", hex: "#800080"),
  ColorModel(label: "Silver", value: "5618", hex: "#C0C0C0"),
  ColorModel(label: "Transparent", value: "5619", hex: "none"),
  ColorModel(label: "Yellow", value: "5620", hex: "#FFFF00"),
  ColorModel(label: "Shimmer", value: "5621", hex: "#E8D5A6"),
  ColorModel(label: "Bronze", value: "6478", hex: "#CD7F32"),
  ColorModel(label: "Nude", value: "6479", hex: "#E1E1A3"),
];

LinearGradient getLinearGradient(String gradientString) {
  final regex = RegExp(r'linear-gradient\((\d+)deg, (.*?)\)$');
  final match = regex.firstMatch(gradientString);
  if (match != null) {
    final colorStops = match.group(2)!.split(', ');
    List<Color> colors = [];
    for (var colorStop in colorStops) {
      final hexColor = colorStop.split(' ')[0];
      colors.add(Color(int.parse('0xFF${hexColor.substring(1)}')));
    }
    return LinearGradient(
        colors: colors,
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
  }
  return const LinearGradient(colors: [Colors.transparent]);
}

List<Color>? getSelectableColorList(
    List<ProductData> products, String? colorId) {
  List<String?> hexaCodesString = products.map((e) {
    if (colorId == null) {
      return e.hexacode;
    } else if (e.color == colorId) {
      return e.hexacode;
    } else {
      return null;
    }
  }).toList();

  List<String?> hexaCodes = [];
  for (int i = 0; i < hexaCodesString.length; i++) {
    if (hexaCodesString[i] != null) {
      hexaCodes.addAll(hexaCodesString[i]!.split(","));
    }
  }
  List<Color> colors = hexaCodes
      .where((e) => e != null)
      .map((e) => Color(int.parse('0xFF${e!.substring(1)}')))
      .toSet()
      .toList();
  return colors;
}

String toWebHex(Color color) {
  return '#${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
}

extension ColorExtension on Color {
  String toWebHex() {
    return '#'
        '${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';
  }
}
