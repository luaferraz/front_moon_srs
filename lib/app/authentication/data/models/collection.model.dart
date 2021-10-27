class CollectionModel {
  int id;
  String name;
  int cardQuantity;

  CollectionModel({
    this.id = 0,
    this.name = "",
    this.cardQuantity = 0,
  });

  static CollectionModel fromJson(Map<String, dynamic> json) {
    final obj = CollectionModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      cardQuantity: json['cardQuantity'] ?? 0,
    );

    return obj;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cardQuantity'] = cardQuantity;
    return data;
  }

  static List<CollectionModel> fromJsonList(List<dynamic> json) =>
      json.map((i) => fromJson(i)).toList();
}
