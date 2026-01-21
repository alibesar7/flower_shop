// editprofile_repo_test.dart
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:flower_shop/features/edit_profile/domain/repos/editProfile_repo.dart';

import 'editprofile_repo_test.mocks.dart';

@GenerateMocks([EditprofileRepo])
void main() {
  // 👈 حل مشكلة MissingDummyValueError
  provideDummy<ApiResult<EditProfileResponse>>(
    SuccessApiResult(data: EditProfileResponse(message: 'dummy')),
  );

  late MockEditprofileRepo mockRepo;

  setUp(() {
    mockRepo = MockEditprofileRepo();
  });

  final tToken = 'token';
  final tPhoto = File('test/assets/test_image.jpg'); // صورة وهمية للتست
  final tResponse = EditProfileResponse(
    message: 'Profile updated',
    user: User(
      id: '123',
      firstName: 'Ali',
      lastName: 'Besar',
      email: 'ali@test.com',
    ),
  );

  group('editProfile', () {
    test('returns SuccessApiResult when repo succeeds', () async {
      // arrange
      when(
        mockRepo.editProfile(
          token: anyNamed('token'),
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          email: anyNamed('email'),
          phone: anyNamed('phone'),
        ),
      ).thenAnswer((_) async => SuccessApiResult(data: tResponse));

      // act
      final result = await mockRepo.editProfile(
        token: tToken,
        firstName: 'Ali',
        lastName: 'Besar',
        email: 'ali@test.com',
        phone: '01000000000',
      );

      // assert
      expect(result, isA<SuccessApiResult<EditProfileResponse>>());
      expect((result as SuccessApiResult).data.message, 'Profile updated');
      verify(
        mockRepo.editProfile(
          token: tToken,
          firstName: 'Ali',
          lastName: 'Besar',
          email: 'ali@test.com',
          phone: '01000000000',
        ),
      ).called(1);
    });

    test('returns ErrorApiResult when repo fails', () async {
      // arrange
      when(
        mockRepo.editProfile(
          token: anyNamed('token'),
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          email: anyNamed('email'),
          phone: anyNamed('phone'),
        ),
      ).thenAnswer((_) async => ErrorApiResult(error: 'Edit profile failed'));

      // act
      final result = await mockRepo.editProfile(token: tToken);

      // assert
      expect(result, isA<ErrorApiResult<EditProfileResponse>>());
      expect((result as ErrorApiResult).error, 'Edit profile failed');
    });
  });

  group('uploadPhoto', () {
    test('returns SuccessApiResult when repo succeeds', () async {
      // arrange
      when(
        mockRepo.uploadPhoto(token: tToken, photo: tPhoto),
      ).thenAnswer((_) async => SuccessApiResult(data: tResponse));

      // act
      final result = await mockRepo.uploadPhoto(token: tToken, photo: tPhoto);

      // assert
      expect(result, isA<SuccessApiResult<EditProfileResponse>>());
      expect((result as SuccessApiResult).data.message, 'Profile updated');
      verify(mockRepo.uploadPhoto(token: tToken, photo: tPhoto)).called(1);
    });

    test('returns ErrorApiResult when repo fails', () async {
      // arrange
      when(
        mockRepo.uploadPhoto(token: tToken, photo: tPhoto),
      ).thenAnswer((_) async => ErrorApiResult(error: 'Upload photo failed'));

      // act
      final result = await mockRepo.uploadPhoto(token: tToken, photo: tPhoto);

      // assert
      expect(result, isA<ErrorApiResult<EditProfileResponse>>());
      expect((result as ErrorApiResult).error, 'Upload photo failed');
      verify(mockRepo.uploadPhoto(token: tToken, photo: tPhoto)).called(1);
    });
  });
}
