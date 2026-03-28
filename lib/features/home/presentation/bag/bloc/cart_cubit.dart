import 'dart:async';

import 'package:dokan/features/home/domain/usecases/bag/add_to_cart_use_case.dart';
import 'package:dokan/features/home/domain/usecases/bag/remove_from_cart_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/bag/cart_item.dart';
import '../../../domain/usecases/bag/get_cart_use_case.dart';
import '../../../domain/usecases/bag/update_cart_item_use_case.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartUseCase getCart;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateCartItemUseCase updateQuantity;

  StreamSubscription? _subscription;

  CartCubit(
    this.getCart,
    this.addToCartUseCase,
    this.removeFromCartUseCase,
    this.updateQuantity,
  ) : super(CartInitState());

  void listenToCart() {
    emit(CartLoadingState());

    _subscription = getCart().listen((items) {
      emit(CartLoadedState(items: items));
    });
  }

  Future<void> addToCart(CartItem item) async {
    await addToCartUseCase(item);
  }
  Future<void> removeFromCart(String productId)async{
    await removeFromCartUseCase(productId);
  }

  Future<void> increaseQuantity(CartItem item) async {
    await updateQuantity(item.productId, item.quantity + 1);
  }

  Future<void> decreaseQuantity(CartItem item) async {
    if (item.quantity > 1) {
      await updateQuantity(item.productId, item.quantity - 1);
    } else {
      await removeFromCartUseCase(item.productId);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
