import 'item.dart';

class ShopProduct {
  final int id;
  final String name;
  final String description;
  final int price;
  final String? type;
  final String imagePath;
  final List<ProductVariant> variants;

  const ShopProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    this.type,
    this.variants = const [],
  });

  // Crea un producto visual a partir de un Item real.
  factory ShopProduct.fromItem(
    Item item, {
    required String imagePath,
  }) {
    return ShopProduct(
      id: item.id,
      name: item.name,
      description: item.description,
      price: item.price,
      type: item.type,
      imagePath: imagePath,
    );
  }
}

class ProductVariant {
  final int id;
  final String label;
  final int price;
  final String imagePath;

  const ProductVariant({
    required this.id,
    required this.label,
    required this.price,
    required this.imagePath,
  });

  factory ProductVariant.fromItem(
    Item item, {
    required String label,
    required String imagePath,
  }) {
    return ProductVariant(
      id: item.id,
      label: label,
      price: item.price,
      imagePath: imagePath,
    );
  }
}