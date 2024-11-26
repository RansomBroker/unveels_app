List<Map<String, String>> _occasions = [
  {
    "label": "Formal",
    "value": "5472",
  },
  {
    "label": "Sport",
    "value": "5473",
  },
  {
    "label": "Casual",
    "value": "5474",
  },
  {
    "label": "Bridal",
    "value": "6481",
  },
  {
    "label": "Soiree",
    "value": "6482",
  },
];

String? getOccasionByLabel(String label) {
  try {
    for (var item in _occasions) {
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
