import 'package:dartz/dartz.dart';
import 'package:dokan/features/home/domain/entities/categories.dart';

import '../../../../core/errors/failures.dart';

abstract class ShoppingRepository {
  Future<Either<Failures,List<Categories>>> getCategories() ;

}