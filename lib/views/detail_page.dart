import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../models/cart_model.dart';
import '../services/hive_service.dart';
import '../services/session_service.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int qty = 1;

  void _addToCart() async {
    final username = SessionService.getUsername();
    final item = CartModel.fromProduct(username, widget.product, qty);
    await HiveService.addToCart(item);

   
    Get.snackbar('Sukses', 'Produk ditambahkan ke cart',
        backgroundColor: Colors.green, 
        colorText: Colors.white,
        icon: const Icon(Icons.check_circle, color: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                p.thumbnail,
                height: 220,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image, size: 100),
              ),
            ),
            const SizedBox(height: 16),
            Text(p.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

   
            Text('\$${p.price}',
                style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFFD87093),
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Text('⭐ ${p.rating}  •  Stok: ${p.stock}'),
            const Divider(height: 32),
            const Text('Deskripsi',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(p.description),
            const SizedBox(height: 24),


            Row(
              children: [
                const Text('Jumlah: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline,
                      color: Color(0xFFD87093)),
                  onPressed: qty > 1 ? () => setState(() => qty--) : null,
                ),
                Text('$qty',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline,
                      color: Color(0xFFD87093)),
                  onPressed: qty < p.stock ? () => setState(() => qty++) : null,
                ),
              ],
            ),
            const SizedBox(height: 16),

      
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB6C1),
                  foregroundColor: Colors.white, // Teks Putih
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _addToCart,
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Add to Cart',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
