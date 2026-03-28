import 'package:dokan/features/home/data/data_source/bag/cart_remote_data_source.dart';
import 'package:dokan/features/home/domain/entities/bag/cart_item.dart';
import 'package:dokan/features/home/domain/repositories/bag/cart_repository.dart';

class CartRepositoryImpl implements CartRepository{
  final CartRemoteDataSource remoteDataSource ;

  CartRepositoryImpl(this.remoteDataSource);
  @override
  Future<void> addToCart(CartItem item) {
    return remoteDataSource.addToCart( item);
  }

  @override
  Stream<List<CartItem>> getCartItems() {
    return remoteDataSource.getCartItems();
  }

  @override
  Future<void> removeFromCart(String productId) {
    return remoteDataSource.removeFromCart(productId);
  }

  @override
  Future<void> updateQuantity(String productId, int quantity) async {
    await remoteDataSource.updateQuantity(productId, quantity);
  }
}