import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/features/home/domain/models/category_model.dart';
import 'package:flower_shop/features/home/domain/models/occasion_model.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';

// abstract class HomeRepo {
//   Future<ApiResult<HomeModel>> getHomeData();
// }
abstract class HomeRepo {
  Future<ApiResult<List<ProductModel>>> getProducts();
  Future<ApiResult<List<CategoryModel>>> getCategories();
  Future<ApiResult<List<BestSellerModel>>> getBestSeller();
  Future<ApiResult<List<OccasionModel>>> getOccasions();
}
