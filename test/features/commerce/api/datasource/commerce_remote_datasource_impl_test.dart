import 'package:dio/dio.dart';
import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/commerce/api/datasource/commerce_remote_datasource_impl.dart';
import 'package:flower_shop/features/commerce/data/models/all_categories_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';
import 'commerce_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late CommerceRemoteDatasourceImpl datasource;

  setUpAll(() {
    mockApiClient = MockApiClient();
    datasource = CommerceRemoteDatasourceImpl(mockApiClient);
  });

  group('AllCategoriesRemoteDataSource', () {
    test('return ApiSuccess when get all categories', () async {
      final fakeDto = AllCategoriesDto(
        message: 'success',
        categories: [
          CategoryItemDto(
            id: '1',
            name: 'flower1',
            productsCount: 5,
            image: 'url',
          ),
        ],
      );
      final fakeResponse = HttpResponse(
        fakeDto,
        Response(
          requestOptions: RequestOptions(path: '/categories'),
          statusCode: 200,
        ),
      );

      when(
        mockApiClient.getAllCategories(),
      ).thenAnswer((_) async => fakeResponse);

      final result =
          await datasource.getAllCategories()
              as SuccessApiResult<AllCategoriesDto>;

      expect(result, isA<SuccessApiResult<AllCategoriesDto>>());
      expect(result.data.message, fakeDto.message);
      expect(result.data.categories?.length, fakeDto.categories?.length);
      verify(mockApiClient.getAllCategories()).called(1);
    });

    test('return ApiError when get all categories throw exception', () async {
      when(
        mockApiClient.getAllCategories(),
      ).thenThrow(Exception('Network error'));

      final result =
          await datasource.getAllCategories()
              as ErrorApiResult<AllCategoriesDto>;

      expect(result, isA<ErrorApiResult<AllCategoriesDto>>());
      expect(result.error, contains("Network error"));
      verify(mockApiClient.getAllCategories()).called(1);
    });
  });
}
