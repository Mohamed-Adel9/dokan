class CartItem {
  final String name;
  final String image;
  final String productId;
  final double price;
  final int quantity;
  final double discount;

  const CartItem({
    required this.name,
    required this.image,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.discount,
  });

  double get finalPrice => price * (1 - (discount/100));
}
