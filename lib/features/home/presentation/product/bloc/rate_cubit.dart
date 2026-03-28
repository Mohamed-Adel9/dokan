import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/features/home/domain/usecases/get_ratings_usecase.dart';
import 'package:dokan/features/home/presentation/product/bloc/rate_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RatingCubit extends Cubit<RatingStates>{
  final GetRatingsUseCase getRatings;
  int rating = 0;

  RatingCubit(this.getRatings):super(RatingInitState());

  void setRate(int index){
    rating = index + 1;
    emit(RatingSetRateState());
  }

  Future<void> addReview(int index , String name , String comment) async {
    await FirebaseFirestore.instance.collection("rating").add({
      "user_name": name,
      "rate": index,
      "review": comment,
      "date": DateTime.now(),
      "image":"https://res.cloudinary.com/dsjo1n46k/image/upload/v1772028054/samples/man-portrait.jpg",
    });
    emit(RatingReviewAddedSuccessfullyState());
  }

  Future<void> loadRating()async{
    emit(RatingLoadingState());
    final result = await getRatings();

    result.fold(

          (failure) => emit(RatingErrorState(message: failure.massage)),
          (rate) => emit(RatingLoadedState(rate: rate)),
    );
  }

}
