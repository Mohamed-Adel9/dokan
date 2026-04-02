import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dokan/core/errors/failures.dart';
import 'package:dokan/features/home/domain/entities/rate.dart';
import 'package:dokan/features/home/domain/repositories/rate_repository.dart';

import '../data_source/rate/rating_local_data_source.dart';
import '../data_source/rate/rating_remote_data_source.dart';

class RatingRepositoryImpl implements RateRepository {
  final RatingRemoteDataSource remote;

  final RatingLocalDataSource local;

  final Connectivity connectivity;

  RatingRepositoryImpl(this.remote, this.local, this.connectivity);

  @override
  Future<Either<Failures, List<Rate>>> getRatings() async {
    final connection = await connectivity.checkConnectivity();

    try {
      /// online
      if (connection.first != ConnectivityResult.none) {
        final remoteRatings = await remote.getRating();
        await local.cacheRatings(remoteRatings);
        return Right(remoteRatings);
      }

      ///offline
      final localRatings = await local.getCachedRatings();
      return Right(localRatings);
    } catch (e) {
      throw Left(e.toString());
    }
  }

  Future<Either<Failures, void>> addRating({
    required int rate,
    required String name,
    required String comment,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("rating").add({
        "user_name": name,
        "rate": rate,
        "review": comment,
        "date": DateTime.now(),
      });
      return Right(null);
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }
}