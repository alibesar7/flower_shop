import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/commerce/data/datasource/commerce_remote_datasource.dart';
import 'package:flower_shop/features/commerce/data/models/all_categories_dto.dart';
import 'package:flower_shop/features/commerce/data/repos/commerce_repo_impl.dart';
import 'package:flower_shop/features/commerce/domain/models/all_categories_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'commerce_repo_impl_test.mocks.dart';

@GenerateMocks([CommerceRemoteDatasource])
void main() {
  late MockCommerceRemoteDatasource mockDatasource;
  late CommerceRepoImpl repoImpl;

  setUpAll(() {
    mockDatasource = MockCommerceRemoteDatasource();
    repoImpl = CommerceRepoImpl(mockDatasource);
    provideDummy<ApiResult<AllCategoriesDto>>(
      SuccessApiResult(data: AllCategoriesDto()),
    );
  });
  group("Get all categories repo", () {
    test('should return ApiSuccess when get all categories success', () async {
      final fakeDto = AllCategoriesDto(
        message: 'success',
        categories: [
          CategoryItemDto(
            id: '1',
            image: 'url',
            name: 'flower1',
            productsCount: 5,
          ),
        ],
      );

      when(mockDatasource.getAllCategories()).thenAnswer(
        (_) async => SuccessApiResult<AllCategoriesDto>(data: fakeDto),
      );

      final result =
          await repoImpl.getAllCategories()
              as SuccessApiResult<AllCategoriesModel>;

      expect(result, isA<SuccessApiResult<AllCategoriesModel>>());
      expect(result.data.message, fakeDto.message);
      expect(result.data.categories?.first?.id, fakeDto.categories?.first?.id);
      verify(mockDatasource.getAllCategories()).called(1);
    });

    test(
      'should return ApiError when get all categories throws exception',
      () async {
        when(mockDatasource.getAllCategories()).thenAnswer(
          (_) async => ErrorApiResult<AllCategoriesDto>(error: 'Network error'),
        );

        final result =
            await repoImpl.getAllCategories()
                as ErrorApiResult<AllCategoriesModel>;

        expect(result, isA<ErrorApiResult<AllCategoriesModel>>());
        expect(result.error.toString(), contains("Network error"));
        verify(mockDatasource.getAllCategories()).called(1);
      },
    );
  });
}
