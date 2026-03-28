import 'package:dokan/features/home/domain/entities/product.dart';

class HomeBottomNavState {
  final int index;

  const HomeBottomNavState(this.index);
}

abstract class HomeStates {}

class HomeInitState extends HomeStates {}
class HomeLoadingState extends HomeStates {}
class HomeLoadedState extends HomeStates {
  final List<Product> product ;

  HomeLoadedState({required this.product});
}
class HomeErrorState extends HomeStates {
  final String message ;

  HomeErrorState({required this.message});
}