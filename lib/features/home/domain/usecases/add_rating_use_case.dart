import 'package:dartz/dartz.dart';
import 'package:dokan/core/errors/failures.dart';
import 'package:dokan/features/home/domain/repositories/rate_repository.dart';

class AddRatingUseCase {
  final RateRepository repository;

  AddRatingUseCase(this.repository);

  Future<Either<Failures, void>> call({
    required int rate,
    required String name,
    required String comment,
  }) {
    return repository.addRating(rate: rate, name: name, comment: comment);
  }
}