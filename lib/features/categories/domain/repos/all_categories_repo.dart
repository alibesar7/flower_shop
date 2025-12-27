import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/categories/domain/models/all_categories_model.dart';

abstract class AllCategoriesRepo {
  Future<ApiResult<AllCategoriesModel>> getAllCategories();
}
