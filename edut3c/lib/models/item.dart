class Item {
  final int id;
  final String name;
  final int price;
  final String description;
  final String? icon;
  final bool isStackable;
  final String? type;

  const Item({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.icon,
    required this.isStackable,
    this.type,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'] ?? '',
      icon: json['icon'],
      isStackable: json['is_stackable'] ?? false,
      type: json['type'],
    );
  }
}