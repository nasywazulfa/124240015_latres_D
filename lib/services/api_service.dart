import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com/products';

  static Future<List<Product>> getProducts() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['products'];
      return list.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Gagal load produk');
    }
  }

  static Future<Product> getProductDetail(int id) async {
    final res = await http.get(Uri.parse('$baseUrl/$id'));
    if (res.statusCode == 200) {
      return Product.fromJson(json.decode(res.body));
    } else {
      throw Exception('Gagal load detail');
    }
  }
}