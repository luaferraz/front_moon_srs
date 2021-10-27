class CardModel {
  int id;
  String front;
  String back;
  //0 = low priority, 1 = medium priority, 2 = hight priority;
  int priority;

  CardModel({
    this.id = 0,
    this.front = "",
    this.back = "",
    this.priority = 2,
  });

  static CardModel fromJson(Map<String, dynamic> json) {
    final obj = CardModel(
      id: json['id'] ?? "",
      front: json['front'] ?? "",
      back: json['back'] ?? "",
      priority: json['priority'] ?? 2,
    );

    return obj;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['front'] = front;
    data['back'] = back;
    data['priority'] = priority;
    return data;
  }

  static List<CardModel> fromJsonList(List<dynamic> json) =>
      json.map((i) => fromJson(i)).toList();
}
