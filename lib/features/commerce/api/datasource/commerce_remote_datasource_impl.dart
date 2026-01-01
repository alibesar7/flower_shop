import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/app/core/network/safe_api_call.dart';
import 'package:flower_shop/features/commerce/data/datasource/commerce_remote_datasource.dart';
import 'package:flower_shop/features/commerce/data/models/all_categories_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CommerceRemoteDatasource)
class CommerceRemoteDatasourceImpl implements CommerceRemoteDatasource {
  ApiClient apiClient;
  CommerceRemoteDatasourceImpl(this.apiClient);

  @override
  Future<ApiResult<AllCategoriesDto>> getAllCategories() {
    return safeApiCall(call: () => apiClient.getAllCategories());
  }
}
