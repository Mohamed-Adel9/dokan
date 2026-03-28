
import 'package:dokan/features/home/domain/entities/categories.dart';

abstract class ShoppingStates {}

class ShoppingInitState extends ShoppingStates {}
class ShoppingLoadingState extends ShoppingStates {}
class ShoppingLoadedState extends ShoppingStates {
  final List<Categories> categories ;

  ShoppingLoadedState({required this.categories});
}
class ShoppingErrorState extends ShoppingStates {
  final String message ;

  ShoppingErrorState({required this.message});
}


