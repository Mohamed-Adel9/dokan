import 'package:dokan/features/home/domain/usecases/get_categories_usecase.dart';
import 'package:dokan/features/home/presentation/shopping/bloc/shopping_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShoppingCubit extends Cubit<ShoppingStates>{
  final GetCategoriesUseCase getCategories;
  ShoppingCubit(this.getCategories):super(ShoppingInitState());

  Future<void> loadCategories()async{
    emit(ShoppingLoadingState());
    final result = await getCategories();

    result.fold(

          (failure) => emit(ShoppingErrorState(message: failure.massage)),
          (categories) => emit(ShoppingLoadedState(categories: categories)),
    );
  }

}
