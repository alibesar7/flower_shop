import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/categories/domain/models/all_categories_model.dart';
import 'package:flower_shop/features/nav_bar/domain/models/product_model.dart';

class AllCategoriesStates {
  final Resource<AllCategoriesModel>? allCategories;
  final Resource<List<ProductModel>>? products;

  AllCategoriesStates({this.allCategories, this.products});
  AllCategoriesStates copyWith({
    Resource<AllCategoriesModel>? allCategoriesCopyWith,
    Resource<List<ProductModel>>? products,
  }) {
    return AllCategoriesStates(
      allCategories: allCategoriesCopyWith ?? allCategories,
      products: products ?? this.products,
    );
  }
}
