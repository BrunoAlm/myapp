class PasswordEntity {
  final String level;
  final String password;
  final DateTime createdAt;

  PasswordEntity({
    required this.level,
    required this.password,
    required this.createdAt,
  });

  factory PasswordEntity.fromJson(Map<String, dynamic> json) => PasswordEntity(
        level: json["level"],
        password: json["password"],
        createdAt: json["createdAt"]
      );
}
