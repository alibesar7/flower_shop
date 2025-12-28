import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/categories/domain/models/all_categories_model.dart';

class AllCategoriesStates {
  final Resource<AllCategoriesModel>? allCategories;

  AllCategoriesStates({this.allCategories});
  AllCategoriesStates copyWith({
    Resource<AllCategoriesModel>? allCategoriesCopyWith,
  }) {
    return AllCategoriesStates(
      allCategories: allCategoriesCopyWith ?? allCategories,
    );
  }
}
