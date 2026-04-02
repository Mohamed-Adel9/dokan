import 'package:dokan/features/home/domain/usecases/get_ratings_usecase.dart';
import 'package:dokan/features/home/presentation/product/bloc/rate_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/add_rating_use_case.dart';

class RatingCubit extends Cubit<RatingStates> {
  final GetRatingsUseCase getRatingsUseCase;
  final AddRatingUseCase addRatingUseCase; // 👈 moved Firestore logic to use case

  RatingCubit({
    required this.getRatingsUseCase,
    required this.addRatingUseCase,
  }) : super(RatingInitState());

  Future<void> loadRating() async {
    emit(RatingLoadingState());
    final result = await getRatingsUseCase();
    result.fold(
          (failure) => emit(RatingErrorState(message: failure.massage)),
          (rate) => emit(RatingLoadedState(rate: rate)),
    );
  }

  Future<void> addReview({
    required int rate,
    required String name,
    required String comment,
  }) async {
    emit(RatingLoadingState());
    final result = await addRatingUseCase(rate: rate, name: name, comment: comment);
    result.fold(
          (failure) => emit(RatingErrorState(message: failure.massage)),
          (_) => loadRating(), // 👈 re-fetch so UI returns to RatingLoadedState
    );
  }
}