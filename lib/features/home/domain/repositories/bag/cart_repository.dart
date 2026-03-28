import 'package:dokan/features/home/domain/entities/bag/cart_item.dart';

abstract class CartRepository {
  Stream<List<CartItem>> getCartItems();
  Future<void> updateQuantity(String productId, int quantity);
  Future<void> addToCart(CartItem item);
  Future<void> removeFromCart(String productId);
}