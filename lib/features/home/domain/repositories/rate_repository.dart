
import 'package:dartz/dartz.dart';
import 'package:dokan/core/errors/failures.dart';

import '../entities/rate.dart';

abstract class RateRepository {
  Future<Either<Failures,List<Rate>>> getRatings() ;
  Future<Either<Failures, void>> addRating({
    required int rate,
    required String name,
    required String comment,
  }) ;
}