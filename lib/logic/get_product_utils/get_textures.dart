List<Map<String, String>> _textures = [
  {
    "label": "Matte",
    "value": "5625",
  },
  {
    "label": "Shimmer",
    "value": "5626",
  },
  {
    "label": "Glossy",
    "value": "5627",
  },
  {
    "label": "Satin",
    "value": "5628",
  },
  {
    "label": "Metallic",
    "value": "5629",
  },
  {
    "label": "Sheer",
    "value": "5630",
  },
];

List<String> texturesLabel = _textures.map((e) => e['label']!).toList();

int getTextureIndexByValue(String value) {
  try {
    return _textures.indexWhere((element) => element['value'] == value);
  } catch (e) {
    print(e);
    return -1;
  }
}

List<String>? getTextureByLabel(List<String> labels) {
  try {
    List<String>? result = [];
    for (var item in _textures) {
      if (labels.contains(item['label'])) {
        result.add(item['value']!);
      }
    }
    return result;
  } catch (e) {
    print(e);
    return [];
  }
}