import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/cart_model.dart';
import '../services/hive_service.dart';
import '../services/session_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final username = SessionService.getUsername();

    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Belanja')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<CartModel>('cartBox').listenable(),
        builder: (context, Box<CartModel> box, _) {
          final items = HiveService.getCartByUser(username);

          if (items.isEmpty) {
            return const Center(
              child: Text(
                'Cart masih kosong',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, i) {
              final item = items[i];
              return Card(
                elevation: 2,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.thumbnail,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image),
                    ),
                  ),
                  title: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${item.quantity} x \$${item.price}',
                    style: const TextStyle(
                        color: Color(0xFFD87093), fontWeight: FontWeight.bold),
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      // 1. Hapus dari Hive
                      await HiveService.deleteItem(item);

                      setState(() {});

                      Get.snackbar(
                        'Terhapus',
                        '${item.title} berhasil dihapus dari keranjang',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        icon:
                            const Icon(Icons.delete_sweep, color: Colors.white),
                        margin: const EdgeInsets.all(16),
                        borderRadius: 8,
                      );
                    },
                  ), // IconButton
                ),
              );
            },
          );
        },
      ),
    );
  }
}
