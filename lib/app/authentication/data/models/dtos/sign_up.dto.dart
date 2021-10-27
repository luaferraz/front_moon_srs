class SignUpDto {
  String username;
  String email;
  String password;
  String passwordConfirm;

  SignUpDto({
    this.username = "",
    this.email = "",
    this.password = "",
    this.passwordConfirm = "",
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "passwordConfirm": passwordConfirm,
      };

  static SignUpDto fromJson(Map<String, dynamic> json) {
    final obj = SignUpDto(
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
      passwordConfirm: json["passwordConfirm"] ?? "",
    );

    return obj;
  }
}
