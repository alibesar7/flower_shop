sealed class CartIntent {}

class GetAllCartsIntent extends CartIntent {}

class AddProductToCartIntent extends CartIntent {
  final String productId;
  final int quantity;

  AddProductToCartIntent({required this.productId, required this.quantity});
}

class DeleteCartItemIntent extends CartIntent {
  final String cartItemId;

  DeleteCartItemIntent({required this.cartItemId});
}
