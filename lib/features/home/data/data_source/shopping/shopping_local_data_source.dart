import 'package:dokan/features/home/data/models/categories_model.dart';
import 'package:hive/hive.dart';

abstract class ShoppingLocalDataSource {
  Future<void> cacheCategories(List<CategoriesModel> categories);
  Future<List<CategoriesModel>> getCachedCategories();
}

class ShoppingLocalDataSourceImpl implements ShoppingLocalDataSource {
  final boxName = "Categories_box";

  @override
  Future<void> cacheCategories(List<CategoriesModel> categories) async {
    //open the box
    final box = await Hive.openBox(boxName);

    // get data and make it json list
    final jsonList = categories.map((e) => e.toJson()).toList();

    await box.put("Categories", jsonList);
  }

  @override
  Future<List<CategoriesModel>> getCachedCategories() async {
    final box = await Hive.openBox(boxName);

    final data = box.get("Categories");

    if (data == null) {
      return [];
    }
    return (data as List)
        .map((e) => CategoriesModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
