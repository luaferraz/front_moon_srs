import 'dart:convert';

class SsoDTO {
  String access_token;
  String expiration;
  String user;

  SsoDTO({
    required this.access_token,
    required this.expiration,
    required this.user,
  });

  Map<String, dynamic> toJson() => {
        "access_token": access_token,
        "expiration": expiration,
        "user": user,
      };

  static SsoDTO fromJson(Map<String, dynamic> json) {
    final obj = SsoDTO(
        access_token: json["access_token"] ?? "",
        expiration:
            json["expiration"] != null ? json["expiration"].toString() : "",
        user: json["user"] != null ? jsonEncode(json["user"]).toString() : "");

    return obj;
  }
}
