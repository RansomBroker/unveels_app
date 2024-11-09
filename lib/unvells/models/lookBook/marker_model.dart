class MarkerModel {
  String markerLabel;
  String title;
  String description;
  num left;
  num top;
  String sku;
  String popup;

  MarkerModel({
    required this.markerLabel,
    required this.title,
    required this.description,
    required this.left,
    required this.top,
    required this.sku,
    required this.popup,
  });

  factory MarkerModel.fromJson(Map<String, dynamic> json) {
    return MarkerModel(
      markerLabel: json['marker_label'],
      title: json['title'],
      description: json['description'],
      left: json['left'],
      top: json['top'],
      sku: json['sku'],
      popup: json['popup'],
    );
  }
}