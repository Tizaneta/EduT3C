import 'item.dart';

class UserItem {
  final Item item;
  final int quantity;

  const UserItem({
    required this.item,
    required this.quantity,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) {
    return UserItem(
      item: Item.fromJson(json),
      quantity: json['quantity'] ?? 0,
    );
  }
}