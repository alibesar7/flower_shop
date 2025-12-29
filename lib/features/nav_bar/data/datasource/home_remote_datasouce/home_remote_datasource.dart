import 'package:flower_shop/features/nav_bar/data/models/response/products_response.dart';
import '../../../../../app/core/network/api_result.dart';

abstract class HomeRemoteDatasource {
  Future<ApiResult<ProductsResponse>> getProduct({
    String? occasion,
    String? category,
  });
}
