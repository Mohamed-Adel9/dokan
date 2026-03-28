import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/features/home/data/models/rate_model.dart';

abstract class RatingRemoteDataSource {
  Future<List<RateModel>> getRating();
}

class RatingRemoteDataSourceImpl implements RatingRemoteDataSource {
  final FirebaseFirestore fireStore;

  RatingRemoteDataSourceImpl(this.fireStore);

  @override
  Future<List<RateModel>> getRating() async {
    final snapshot = await fireStore.collection('rating').get();

    return snapshot.docs
        .map((doc) => RateModel.fromJson(doc.data()))
        .toList();
  }
}
