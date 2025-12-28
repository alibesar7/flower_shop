import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final BestSellerModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title ?? "")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(product.imgCover ?? ""),
            Text(product.title ?? ""),
            Text(product.price?.toString() ?? ""),
            Text(product.description ?? ""),
          ],
        ),
      ),
    );
  }
}
