import 'package:dokan/features/home/data/models/rate_model.dart';
import 'package:hive/hive.dart';

abstract class RatingLocalDataSource {
  Future<void> cacheRatings(List<RateModel> ratings);
  Future<List<RateModel>> getCachedRatings();
}

class RatingLocalDataSourceImpl implements RatingLocalDataSource {
  final boxName = "Ratings_box";

  @override
  Future<void> cacheRatings(List<RateModel> ratings) async {
    //open the box
    final box = await Hive.openBox(boxName);

    // get data and make it json list
    final jsonList = ratings.map((e) => e.toJson()).toList();

    await box.put("Ratings", jsonList);
  }

  @override
  Future<List<RateModel>> getCachedRatings() async {
    final box = await Hive.openBox(boxName);

    final data = box.get("Ratings");

    if (data == null) {
      return [];
    }
    return (data as List)
        .map((e) => RateModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
