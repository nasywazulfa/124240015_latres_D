import 'package:hive/hive.dart';
import 'product_model.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel extends HiveObject {
  @HiveField(0)
  late String username;

  @HiveField(1)
  late int productId;

  @HiveField(2)
  late String title;

  @HiveField(3)
  late double price;

  @HiveField(4)
  late String thumbnail;

  @HiveField(5)
  late int quantity;

  @HiveField(6)
  late int totalQty;

  @HiveField(7)
  late String description;

  CartModel({
    required this.username,
    required this.productId,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.quantity,
    required this.totalQty,
    required this.description,
  });

  factory CartModel.fromProduct(String username, Product p, int qty) {
    return CartModel(
      username: username,
      productId: p.id,
      title: p.title,
      price: p.price,
      thumbnail: p.thumbnail,
      quantity: qty,
      totalQty: p.stock,
      description: p.description,
    );
  }
}