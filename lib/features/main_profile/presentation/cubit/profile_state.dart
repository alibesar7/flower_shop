part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ApiResult<ProfileUserModel> profile;
  const ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
}

class LogoutLoading extends ProfileState {}

class LogoutSuccess extends ProfileState {}
