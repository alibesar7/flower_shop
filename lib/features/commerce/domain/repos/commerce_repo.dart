import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/commerce/domain/models/all_categories_model.dart';

abstract class CommerceRepo {
  Future<ApiResult<AllCategoriesModel>> getAllCategories();
}
