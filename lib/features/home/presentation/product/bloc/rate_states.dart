
import 'package:dokan/features/home/domain/entities/rate.dart';

abstract class RatingStates {}

class RatingInitState extends RatingStates {}
class RatingSetRateState extends RatingStates {}
class RatingReviewAddedSuccessfullyState extends RatingStates {

}

class RatingLoadingState extends RatingStates {}
class RatingLoadedState extends RatingStates {
  final List<Rate> rate ;

  RatingLoadedState({required this.rate});
}
class RatingErrorState extends RatingStates {
  final String message ;

  RatingErrorState({required this.message});
}


