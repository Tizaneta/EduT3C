class User {

  final int id;
  final String username;
  final String email;
  final int xp;
  final int level;
  final int bits;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.xp,
    required this.level,
    required this.bits,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      xp: json["xp"] ?? 0,
      level: json["level"] ?? 1,
      bits: json["bits"] ?? 0,
    );
  }
}