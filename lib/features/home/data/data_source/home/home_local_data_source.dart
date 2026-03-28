import 'package:dokan/features/home/data/models/product_model.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Stream<List<ProductModel>> getCachedProducts();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final boxName = "Products_box";

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    //open the box
    final box = await Hive.openBox(boxName);

    // get data and make it json list
    final jsonList = products.map((e) => e.toJson()).toList();

    await box.put("Products", jsonList);
  }

  @override
  Stream<List<ProductModel>> getCachedProducts() async* {
    final box = await Hive.openBox(boxName);

    yield* box.watch().map((event) {
      final data = box.get("Products");

      if (data == null) return [];

      return (data as List)
          .map((e) => ProductModel.fromJson(
        Map<String, dynamic>.from(e),
      ))
          .toList();
    });
  }
}
