import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/features/home/domain/entities/product.dart';
import 'package:dokan/features/home/domain/usecases/get_product_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/enums/product_sort_type.dart';
import '../../bag/bag_screen.dart';
import '../../favorite/favorite_screen.dart';
import '../../profile/profile_screen.dart';
import '../../shopping/shopping_screen.dart';
import '../main_screen.dart';
import 'home_states.dart';

class BottomNavCubit extends Cubit<HomeBottomNavState> {
  BottomNavCubit() : super(HomeBottomNavState(0));

  final pages = [
    const MainScreen(),
    const ShoppingScreen(),
    const BagScreen(),
    const FavoriteScreen(),
     ProfileScreen(),
  ];
  final user= FirebaseAuth.instance.currentUser!.displayName;

  void changeTap(int index) {
    emit(HomeBottomNavState(index));
  }
}

class HomeCubit extends Cubit<HomeStates> {
  final GetProductUseCase getProduct;
  HomeCubit(this.getProduct) : super(HomeInitState());

  StreamSubscription? _subscription;
  List<Product> _originalProducts = [];
  List<Product> _sortedProducts = [];
  List<Product> allProducts = [];

  void listenToProducts() {
    emit(HomeLoadingState());

    _subscription?.cancel();

    _subscription = getProduct().listen(
      (products) {
        allProducts = products;
        _originalProducts = products;
        _sortedProducts = List.from(products);
        emit(HomeLoadedState(product: _sortedProducts));
      },
      onError: (error) {
        emit(HomeErrorState(message: error.toString()));
      },
    );
  }



  List<Product> getProductsByCategory(String category) {
    final filtered = allProducts
        .where((p) => p.category.toLowerCase() == category.toLowerCase())
        .toList();
    return filtered;
  }

  void sortProducts(ProductSortType sortType) {
    final list = List<Product>.from(_originalProducts);

    switch (sortType) {
      case ProductSortType.newest:
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;

      case ProductSortType.rating:
        list.sort((a, b) => b.rate.compareTo(a.rate));
        break;

      case ProductSortType.priceLowToHigh:
        list.sort((a, b) => a.price.compareTo(b.price));
        break;

      case ProductSortType.priceHighToLow:
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
    }

    _sortedProducts = list;
    emit(HomeLoadedState(product: _sortedProducts));
  }

  Future<void> toggleFavorite(Product product) async {
    if (state is! HomeLoadedState) return;

    final currentState = state as HomeLoadedState;

    final updatedProducts = currentState.product.map((p) {
      if (p.id == product.id) {
        return p.copyWith(isFavorite: !p.isFavorite);
      }
      return p;
    }).toList();

    /// 🔥 Emit immediately (UI updates instantly)
    emit(HomeLoadedState(product: updatedProducts));

    /// 🔥 Then update Firestore (background)
    await FirebaseFirestore.instance
        .collection('product')
        .doc(product.id)
        .update({
      'isFavorite': !product.isFavorite,
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
