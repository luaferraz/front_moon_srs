class SignInDto {
  String username;
  String password;

  SignInDto({
    this.username = "",
    this.password = "",
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };

  static SignInDto fromJson(Map<String, dynamic> json) {
    final obj = SignInDto(
      username: json["username"] ?? "",
      password: json["password"] ?? "",
    );

    return obj;
  }
}
