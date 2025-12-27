import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/categories/data/datasource/all_categories_remote_datasource.dart';
import 'package:flower_shop/features/categories/data/models/all_categories_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AllCategoriesRemoteDatasource)
class AllCategoriesRemoteDatasourceImpl
    implements AllCategoriesRemoteDatasource {
  ApiClient apiClient;
  AllCategoriesRemoteDatasourceImpl(this.apiClient);

  @override
  Future<ApiResult<AllCategoriesDto>> getAllCategories() {
    return safeApiCall(call: () => apiClient.getAllCategories());
  }
}
