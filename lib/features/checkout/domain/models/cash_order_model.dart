class CashOrderModel {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String state;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String orderNumber;

  CashOrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.orderNumber,
  });
}

class OrderItem {
  final String id;
  final Product product;
  final double price;
  final int quantity;

  OrderItem({
    required this.id,
    required this.product,
    required this.price,
    required this.quantity,
  });
}

class Product {
  final String id;
  final String title;
  final String description;
  final String imgCover;
  final double price;
  final double priceAfterDiscount;
  final int quantity;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imgCover,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.category,
  });
}
