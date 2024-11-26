List<Map<String, String>> _materials = [
  {
    "label": "Plastic",
    "value": "6490",
  },
  {
    "label": "Metal",
    "value": "6491",
  },
  {
    "label": "Pearls",
    "value": "6492",
  },
  {
    "label": "Crystals",
    "value": "6493",
  },
  {
    "label": "Rubies",
    "value": "6494",
  },
  {
    "label": "Silver",
    "value": "6495",
  },
  {
    "label": "Silver Plated",
    "value": "6496",
  },
  {
    "label": "Gold Plated",
    "value": "6497",
  },
  {
    "label": "Brass",
    "value": "6498",
  },
  {
    "label": "Stainless",
    "value": "6499",
  },
  {
    "label": "Porcelain",
    "value": "6645",
  },
];

List<String>? getMaterialByLabels(List<String> labels) {
  try {
    List<String>? result = [];
    for (var item in _materials) {
      if (labels.contains(item['label'])) {
        result.add(item['value']!);
      }
    }
    return result;
  } catch (e) {
    print(e);
    return null;
  }
}

String? getMaterialByLabel(String label) {
  try {
    for (var item in _materials) {
      if (item['label'] == label) {
        return item['value'];
      }
    }
    return null;
  } catch (e) {
    print(e);
    return null;
  }
}
