import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/product_details/models/product_details_entity.dart';
part 'product_details_model.g.dart';


@JsonSerializable()
class ProductDetailsModel extends ProductDetailsEntity {
  ProductDetailsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imgCover,
    required super.images,
    required super.price,
    required super.priceAfterDiscount,
    required super.isInWishlist,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ProductDetailsModelToJson(this);
}
