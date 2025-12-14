import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test_app/features/display/models/product_model.dart';

class CartRepository {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> saveCart(List<ProductModel> cartItems) async {
    final cartJson = jsonEncode(
      cartItems.map((item) => item.toJson()).toList(),
    );
    await _secureStorage.write(key: 'cart', value: cartJson);
  }

  Future<List<ProductModel>> loadCart() async {
    final cartJson = await _secureStorage.read(key: 'cart');

    if (cartJson == null) return [];

    final List<dynamic> decoded = jsonDecode(cartJson);
    return decoded.map((item) => ProductModel.fromJson(item)).toList();
  }

  Future<void> clearCart() async {
    await _secureStorage.delete(key: 'cart');
  }
}
