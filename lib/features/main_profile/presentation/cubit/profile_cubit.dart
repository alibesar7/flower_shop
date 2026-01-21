// presentation/cubit/profile_cubit.dart
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_current_user_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;

  ProfileCubit({required this.getCurrentUserUsecase}) : super(ProfileInitial());

  Future<void> getProfile() async {
    try {
      emit(ProfileLoading());
      final apiResult = await getCurrentUserUsecase();

      if (apiResult is SuccessApiResult<ProfileUserModel>) {
        emit(ProfileLoaded(apiResult));
      } else if (apiResult is ErrorApiResult<ProfileUserModel>) {
        emit(ProfileError(apiResult.error));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // Helper method to get profile data if available
  ProfileUserModel? getProfileData() {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      final apiResult = currentState.profile;
      if (apiResult is SuccessApiResult<ProfileUserModel>) {
        return apiResult.data;
      }
    }
    return null;
  }

  // Helper method to get full name
  String getFullName() {
    final profile = getProfileData();
    if (profile != null) {
      return '${profile.firstName} ${profile.lastName}';
    }
    return '';
  }
}
