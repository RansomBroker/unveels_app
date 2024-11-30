import 'dart:convert';
import 'dart:typed_data';

class SkinAnalysisModel {
  final int? classId;
  final String label;
  final double score;
  final String? imageData;

  SkinAnalysisModel({
    this.classId,
    required this.label,
    required this.score,
    this.imageData,
  });

  factory SkinAnalysisModel.fromJson(Map<String, dynamic> json) {
    return SkinAnalysisModel(
      classId: json['class'] as int?,
      label: json['label'] as String,
      score: (json['score'] as num).toDouble(),
      imageData: json['data'] as String?,
    );
  }

  static List<SkinAnalysisModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => SkinAnalysisModel.fromJson(json)).toList();
  }

  static final List<String> categories = [
    "Wrinkles",
    "Spots",
    "Texture",
    "Dark Circles",
    "Redness",
    "Oiliness",
    "Moisture",
    "Pores",
    "Eye Bags",
    "Radiance",
    "Firmness",
    "Droopy Upper Eyelid",
    "Droopy Lower Eyelid",
    "Acne"
  ];

  static final List<String> categoryLabels = [
    "wrinkles",
    "spots",
    "texture",
    "dark circle",
    "skinredness",
    "oily",
    "moistures",
    "pore",
    "eyebag",
    "radiance",
    "firmness",
    "droopy eyelid upper",
    "droopy eyelid lower",
    "acne"
  ];

  static final List<String> descriptions = [
    "Wrinkles are a natural part of aging, but they can also develop as a result of sun exposure, dehydration, and smoking. They can be treated with topical creams, botox, and fillers.",
    "Spots can be caused by sun exposure, hormonal changes, and skin inflammation. They can be treated with topical creams, laser therapy, and chemical peels.",
    "Uneven skin texture can be caused by acne, sun damage, and aging. It can be treated with exfoliation, laser therapy, and microneedling.",
    "Dark circles can be caused by lack of sleep, dehydration, and genetics. They can be treated with eye creams, fillers, and laser therapy.",
    "Redness can be caused by rosacea, sunburn, and skin sensitivity. It can be treated with topical creams, laser therapy, and lifestyle changes.",
    "Oiliness can be caused by hormonal changes, stress, and genetics. It can be treated with oil-free skincare products, medication, and lifestyle changes.",
    "Dry skin can be caused by cold weather, harsh soaps, and aging. It can be treated with moisturizers, humidifiers, and lifestyle changes.",
    "Large pores can be caused by genetics, oily skin, and aging. They can be treated with topical creams, laser therapy, and microneedling.",
    "Eye bags can be caused by lack of sleep, allergies, and aging. They can be treated with eye creams, fillers, and surgery.",
    "Dull skin can be caused by dehydration, poor diet, and lack of sleep. It can be treated with exfoliation, hydration, and lifestyle changes.",
    "Loss of firmness can be caused by aging, sun exposure, and smoking. It can be treated with topical creams, botox, and fillers.",
    "Droopy eyelids can be caused by aging, genetics, and sun exposure. They can be treated with eyelid surgery, botox, and fillers.",
    "Droopy eyelids can be caused by aging, genetics, and sun exposure. They can be treated with eyelid surgery, botox, and fillers.",
    "Acne can be caused by hormonal changes, stress, and genetics. It can be treated with topical creams, medication, and lifestyle changes."
  ];

  static double getScoreByCategory(
      List<SkinAnalysisModel> list, String category) {
    String label = categoryLabels[categories.indexOf(category)];
    var filteredList = list.where((c) => c.label == label);

    if (filteredList.isNotEmpty) {
      double totalScore =
          filteredList.map((c) => c.score).reduce((a, b) => a + b);
      return totalScore / filteredList.length;
    } else {
      return 0;
    }
  }

  static String getDescriptionByCategory(String category) {
    return descriptions[categories.indexOf(category)];
  }

  static Uint8List getImageData(List<SkinAnalysisModel> list) {
    SkinAnalysisModel data = list.firstWhere((i) => i.label == 'imageData');
    return base64Decode(data.imageData!.split(',').last);
  }

  static int calculateAverageSkinProblemsScore(
      List<SkinAnalysisModel> skinAnalysisResult) {
    const skinProblemsLabels = [
      "texture",
      "dark circle",
      "eyebag",
      "wrinkles",
      "pores",
      "spots",
      "acne",
    ];

    final scores = skinProblemsLabels.map((label) {
      final labelScores = skinAnalysisResult
          .where((item) => item.label.toString().toLowerCase() == label)
          .map((item) => item.score as num)
          .toList();

      return labelScores.isNotEmpty
          ? labelScores.reduce((total, score) => total + score) /
              labelScores.length
          : 0;
    }).toList();

    final averageScore = scores.reduce((total, score) => total + score) /
        skinProblemsLabels.length;
    return averageScore.round();
  }

  static int calculateAverageSkinConditionScore(
      List<SkinAnalysisModel> skinAnalysisResult) {
    const skinConditionLabels = [
      "firmness",
      "droopy eyelid upper",
      "droopy eyelid lower",
      "moistures",
      "oily",
      "redness",
      "radiance",
    ];

    final scores = skinConditionLabels.map((label) {
      final labelScores = skinAnalysisResult
          .where((item) => item.label.toString().toLowerCase() == label)
          .map((item) => item.score as num)
          .toList();

      return labelScores.isNotEmpty
          ? labelScores.reduce((total, score) => total + score) /
              labelScores.length
          : 0;
    }).toList();

    final averageScore = scores.reduce((total, score) => total + score) /
        skinConditionLabels.length;
    return averageScore.round();
  }

  static List<num> getScoresByLabel(
      List<SkinAnalysisModel> skinAnalysisResult, String label) {
    return skinAnalysisResult
        .where((item) =>
            item.label.toString().toLowerCase() == label.toLowerCase())
        .map((item) => item.score as num)
        .toList();
  }

  static int getTotalScoreByLabel(
      List<SkinAnalysisModel> skinAnalysisResult, String label) {
    final scores = skinAnalysisResult
        .where((item) =>
            item.label.toString().toLowerCase() == label.toLowerCase())
        .map((item) => item.score as num)
        .toList();

    if (scores.isEmpty) return 0;

    final averageScore =
        scores.reduce((total, score) => total + score) / scores.length;
    return ((averageScore / 100) * 100).round();
  }

  static int calculateSkinHealthScore(List<SkinAnalysisModel> skinAnalysisResult) {
    final scores = skinAnalysisResult.map((item) => item.score as num).toList();
    if (scores.isEmpty) return 0;

    final averageScore =
        scores.reduce((total, score) => total + score) / scores.length;
    return averageScore.round();
  }
}
