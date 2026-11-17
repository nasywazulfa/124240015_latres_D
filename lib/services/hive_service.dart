import 'package:hive/hive.dart';
import '../models/cart_model.dart';

class HiveService {
  static Box<CartModel> get _box => Hive.box<CartModel>('cartBox');

  static List<CartModel> getCartByUser(String username) {
    return _box.values.where((e) => e.username == username).toList();
  }

  static Future<void> addToCart(CartModel item) async {
    final existing = _box.values.firstWhereOrNull(
      (e) => e.username == item.username && e.productId == item.productId,
    );

    if (existing != null) {
      existing.quantity += item.quantity;
      if (existing.quantity > existing.totalQty) {
        existing.quantity = existing.totalQty;
      }
      await existing.save();
    } else {
      await _box.add(item);
    }
  }

  static Future<void> deleteItem(CartModel item) async {
    await item.delete();
  }
}

extension FirstWhereOrNull<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (var e in this) {
      if (test(e)) return e;
    }
    return null;
  }
}