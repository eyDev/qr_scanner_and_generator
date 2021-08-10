class ScanModel {
  int? id;
  String data;

  ScanModel({
    this.id,
    required this.data,
  });

  factory ScanModel.fromJson(Map<String, dynamic> json) => new ScanModel(
        id: json['id'],
        data: json['data'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": data,
      };
}
