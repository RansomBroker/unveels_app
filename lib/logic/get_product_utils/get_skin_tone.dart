import 'package:flutter/material.dart';

class SkinTone {
  final String name;
  final Color color;
  final String id;

  SkinTone({required this.name, required this.color, required this.id});
}

List<SkinTone> skinTones = [
  SkinTone(name: "Fair Skin", color: const Color(0xFFFFDFC4), id: "6675"),
  SkinTone(name: "Medium Skin", color: const Color(0xFFF0C08C), id: "6677"),
  SkinTone(name: "Olive Skin", color: const Color(0xFFC68642), id: "6678"),
  SkinTone(name: "Tan Skin", color: const Color(0xFFA57243), id: "6679"),
  SkinTone(name: "Brown Skin", color: const Color(0xFF8D5524), id: "6680"),
  SkinTone(name: "Deep Skin", color: const Color(0xFF4B2E1F), id: "6681"),
];

List<String>? getSkinToneByLabels(List<String> labels) {
  try {
    List<String>? result = [];
    for (var item in skinTones) {
      if (labels.contains(item.id)) {
        result.add(item.id);
      }
    }
    return result;
  } catch (e) {
    print(e);
    return null;
  }
}