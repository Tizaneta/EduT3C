class Level {

  final int id;
  final String name;
  final int xpReward;
  final int bitsReward;

  Level({
    required this.id,
    required this.name,
    required this.xpReward,
    required this.bitsReward,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json["id"],
      name: json["name"],
      xpReward: json["xp_reward"],
      bitsReward: json["bits_reward"],
    );
  }
}