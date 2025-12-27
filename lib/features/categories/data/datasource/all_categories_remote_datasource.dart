import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/categories/data/models/all_categories_dto.dart';

abstract class AllCategoriesRemoteDatasource {
  Future<ApiResult<AllCategoriesDto>> getAllCategories();
}
