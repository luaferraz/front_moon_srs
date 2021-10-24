class UserModel {
  String id;
  String userName;
  String email;

  UserModel({
    this.id = "",
    this.userName = "",
    this.email = "",
  });

  static UserModel fromJson(Map<String, dynamic> json) {
    final obj = UserModel(
      id: json['id'] ?? "",
      userName: json['userName'] ?? "",
      email: json['email'] ?? "",
    );

    return obj;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['email'] = email;
    return data;
  }
}
