import 'package:dartz/dartz.dart';
import 'package:dokan/core/errors/failures.dart';
import 'package:dokan/features/home/domain/entities/rate.dart';
import 'package:dokan/features/home/domain/repositories/rate_repository.dart';

class GetRatingsUseCase {
  final RateRepository repository ;

  GetRatingsUseCase({required this.repository});

  Future<Either<Failures,List<Rate>>> call () {
    return repository.getRatings();
  }
}