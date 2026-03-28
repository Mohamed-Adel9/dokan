import 'package:dokan/features/home/domain/entities/bag/cart_item.dart';

abstract class CartState {}

class CartInitState extends CartState {}
class CartLoadingState extends CartState {}
class CartLoadedState extends CartState {
  final List<CartItem> items ;

  CartLoadedState({required this.items});
}
class CartErrorState extends CartState {
  final String message ;

  CartErrorState({required this.message});
}