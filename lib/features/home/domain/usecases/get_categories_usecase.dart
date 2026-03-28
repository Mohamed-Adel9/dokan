import 'package:dartz/dartz.dart';
import 'package:dokan/core/errors/failures.dart';
import 'package:dokan/features/home/domain/repositories/shopping_repository.dart';

import '../entities/categories.dart';

class GetCategoriesUseCase {
  final ShoppingRepository repository ;

  GetCategoriesUseCase({required this.repository});

  Future<Either<Failures,List<Categories>>> call () {
    return repository.getCategories();
  }
}