import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/data/datasource/home_remote_data_source.dart';
import 'package:flower_shop/features/home/data/models/response/home_response.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/features/home/domain/models/category_model.dart';
import 'package:flower_shop/features/home/domain/models/occasion_model.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';
import 'package:flower_shop/features/home/domain/repos/home_repo.dart';
import 'package:injectable/injectable.dart';

// @Injectable(as: HomeRepo)
// class HomeRepoImp extends HomeRepo{
//   final HomeRemoteDataSource homeRemoteDataSource;
//   HomeRepoImp(this.homeRemoteDataSource);

//   @override
//   Future<ApiResult<List<BestSellerModel>>> getBestSeller()async {
//         final result =await homeRemoteDataSource.getHomeData();
//     if (result is SuccessApiResult<HomeResponse>) {
//       return SuccessApiResult<>(data: result.data.toEntity());
//     }
//     if (result is ErrorApiResult<HomeResponse>) {
//       return ErrorApiResult<HomeModel>(error: result.error);
//     } else {
//       return ErrorApiResult<HomeModel>(error: 'Unknown error');
//     }
//   }

//   @override
//   Future<ApiResult<List<CategoryModel>>> getCategories() {
//     // TODO: implement getCategories
//     throw UnimplementedError();
//   }

//   @override
//   Future<ApiResult<List<OccasionModel>>> getOccasions() {
//     // TODO: implement getOccasions
//     throw UnimplementedError();
//   }

//   @override
//   Future<ApiResult<List<ProductModel>>> getProducts() {
//     // TODO: implement getProducts
//     throw UnimplementedError();
//   }
//   @override
//   // Future<ApiResult<HomeModel>> getHomeData() async {
//     // final result =await homeRemoteDataSource.getHomeData();
//     // if (result is SuccessApiResult<HomeResponse>) {
//     //   return SuccessApiResult<HomeModel>(data: result.data.toEntity());
//     // }
//     // if (result is ErrorApiResult<HomeResponse>) {
//     //   return ErrorApiResult<HomeModel>(error: result.error);
//     // } else {
//     //   return ErrorApiResult<HomeModel>(error: 'Unknown error');
//     // }
//   // }
// }








@Injectable(as: HomeRepo)
class HomeRepoImp extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepoImp(this.homeRemoteDataSource);

  @override
  Future<ApiResult<List<ProductModel>>> getProducts() async {
    final result = await homeRemoteDataSource.getHomeData();
    if (result is SuccessApiResult<HomeResponse>) {
      return SuccessApiResult(
        data: result.data.products
                ?.map((e) => e.toEntity())
                .toList() ??[],
      );
    }
    if (result is ErrorApiResult<HomeResponse>) {
      return ErrorApiResult(error: result.error);
    }else {
    return ErrorApiResult(error: 'Unknown error');
    }
  }

  @override
  Future<ApiResult<List<CategoryModel>>> getCategories() async {
    final result = await homeRemoteDataSource.getHomeData();

    if (result is SuccessApiResult<HomeResponse>) {
      return SuccessApiResult(
        data: result.data.categories
                ?.map((e) => e.toEntity())
                .toList() ??[],
      );
    }

    if (result is ErrorApiResult<HomeResponse>) {
      return ErrorApiResult(error: result.error);
    }else {
    return ErrorApiResult(error: 'Unknown error');
    }
  }

  @override
  Future<ApiResult<List<BestSellerModel>>> getBestSeller() async {
    final result = await homeRemoteDataSource.getHomeData();

    if (result is SuccessApiResult<HomeResponse>) {
      return SuccessApiResult(
        data: result.data.bestSeller
                ?.map((e) => e.toEntity())
                .toList() ?? [],
      );
    }

    if (result is ErrorApiResult<HomeResponse>) {
      return ErrorApiResult(error: result.error);
    }else {
    return ErrorApiResult(error: 'Unknown error');
    }
  }

  @override
  Future<ApiResult<List<OccasionModel>>> getOccasions() async {
    final result = await homeRemoteDataSource.getHomeData();

    if (result is SuccessApiResult<HomeResponse>) {
      return SuccessApiResult(
        data: result.data.occasions
                ?.map((e) => e.toEntity())
                .toList() ?? [],
      );
    }

    if (result is ErrorApiResult<HomeResponse>) {
      return ErrorApiResult(error: result.error);
    }else {
    return ErrorApiResult(error: 'Unknown error');
    }
  }
}
