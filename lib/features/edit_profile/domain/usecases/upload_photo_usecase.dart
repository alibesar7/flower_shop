import 'dart:io';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:flower_shop/features/edit_profile/domain/repos/editProfile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoUseCase {
  final EditprofileRepo editProfileRepo;

  UploadPhotoUseCase(this.editProfileRepo);

  Future<ApiResult<EditProfileResponse>> call({
    required String token,
    required File photo,
  }) {
    return editProfileRepo.uploadPhoto(token: token, photo: photo);
  }
}
