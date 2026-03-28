import 'package:dokan/features/checkout/data/data_source/order_remote_data_source.dart';
import 'package:dokan/features/checkout/data/model/item_model.dart';
import 'package:dokan/features/checkout/data/model/order_model.dart';
import 'package:dokan/features/checkout/domain/entity/order_entity.dart';
import 'package:dokan/features/checkout/domain/repository/order_repository.dart';

class OrderRepositoryImpl  implements OrderRepository{

  final OrderRemoteDataSource remoteDataSource ;

  OrderRepositoryImpl({required this.remoteDataSource});


  @override
  Future<void> createOrder(OrderEntity order) async {
    final model = OrderModel(
        userId: order.userId,
        paymentMethod: order.paymentMethod,
        totalPrice: order.totalPrice,
        deliveryPrice: order.deliveryPrice,
        address: order.address,
        city: order.city,
        country: order.country,
        status: order.status,
        createdAt: order.createdAt,
        item: order.item.map((e) {
          return OrderItemModel(
              productId: e.productId,
              name: e.name,
              image: e.image,
              price: e.price,
              quantity: e.quantity,
            discount: e.discount,
          );
        }).toList(),
    );
    await remoteDataSource.createOrder(model);
  }
}