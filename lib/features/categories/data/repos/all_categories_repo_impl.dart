import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/categories/data/datasource/all_categories_remote_datasource.dart';
import 'package:flower_shop/features/categories/data/mappers/all_categories_mapper.dart';
import 'package:flower_shop/features/categories/data/models/all_categories_dto.dart';
import 'package:flower_shop/features/categories/domain/models/all_categories_model.dart';
import 'package:flower_shop/features/categories/domain/repos/all_categories_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AllCategoriesRepo)
class AllCategoriesRepoImpl implements AllCategoriesRepo {
  AllCategoriesRemoteDatasource categoriesDatasource;
  AllCategoriesRepoImpl(this.categoriesDatasource);

  @override
  Future<ApiResult<AllCategoriesModel>> getAllCategories() async {
    final result = await categoriesDatasource.getAllCategories();
    switch (result) {
      case SuccessApiResult<AllCategoriesDto>():
        AllCategoriesDto dto = result.data;
        AllCategoriesModel allCategoriesModel = dto.toAllCategoriesModel();
        return SuccessApiResult<AllCategoriesModel>(data: allCategoriesModel);
      case ErrorApiResult<AllCategoriesDto>():
        return ErrorApiResult<AllCategoriesModel>(error: result.error);
    }
  }
}
