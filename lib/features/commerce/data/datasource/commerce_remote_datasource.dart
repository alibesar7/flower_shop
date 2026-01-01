import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/commerce/data/models/all_categories_dto.dart';

abstract class CommerceRemoteDatasource {
  Future<ApiResult<AllCategoriesDto>> getAllCategories();
}
