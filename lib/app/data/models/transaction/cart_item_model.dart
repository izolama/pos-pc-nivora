import '../product/product_item.dart';

class CartItemModel {
  const CartItemModel({
    required this.productId,
    required this.productName,
    required this.price,
    required this.qty,
  });

  final int productId;
  final String productName;
  final double price;
  final int qty;

  double get total => price * qty;

  CartItemModel copyWith({
    int? productId,
    String? productName,
    double? price,
    int? qty,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      qty: qty ?? this.qty,
    );
  }

  factory CartItemModel.fromProduct(ProductItem product, int qty) {
    return CartItemModel(
      productId: product.id,
      productName: product.name,
      price: product.finalPrice,
      qty: qty,
    );
  }
}
