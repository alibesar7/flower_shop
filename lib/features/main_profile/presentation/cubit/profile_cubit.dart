// lib/features/main_profile/presentation/cubit/profile_cubit.dart
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/app_constants.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/get_current_user_usecase.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/logout_usecase.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/set_language_usecase.dart';
import 'package:flower_shop/features/main_profile/domain/usecase/toggle_notification_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final LogoutUseCase logoutUseCase;
  final SetLanguageUseCase setLanguageUseCase;
  final ToggleNotificationUseCase toggleNotificationUseCase;

  ProfileCubit({
    required this.getCurrentUserUsecase,
    required this.logoutUseCase,
    required this.setLanguageUseCase,
    required this.toggleNotificationUseCase,
  }) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());

    final result = await getCurrentUserUsecase();

    result.fold(
      (failure) {
        if (failure is Resource<dynamic> && failure.status == 401) {
          emit(ProfileError(AppConstants.sessionExpiredMessage));
        } else {
          emit(ProfileError(failure.message));
        }
      },
      (user) {
        // Get stored preferences
        final language = _getStoredLanguage();
        final notificationsEnabled = _getStoredNotificationsEnabled();

        emit(
          ProfileLoaded(
            user: user,
            language: language,
            notificationsEnabled: notificationsEnabled,
          ),
        );
      },
    );
  }

  Future<void> logout() async {
    emit(ProfileLoading());

    final result = await logoutUseCase();

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) => emit(LogoutSuccess()),
    );
  }

  Future<void> changeLanguage(String languageCode) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      await setLanguageUseCase(languageCode);

      final newLanguage = languageCode == 'en' ? 'English' : 'Arabic';

      emit(
        ProfileLoaded(
          user: currentState.user,
          language: newLanguage,
          notificationsEnabled: currentState.notificationsEnabled,
        ),
      );

      // Optionally emit a language changed event
      emit(LanguageChanged(newLanguage));
      // Return to loaded state
      emit(
        ProfileLoaded(
          user: currentState.user,
          language: newLanguage,
          notificationsEnabled: currentState.notificationsEnabled,
        ),
      );
    }
  }

  Future<void> toggleNotifications(bool enable) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      await toggleNotificationUseCase(enable);

      emit(NotificationToggled(enable));
      // Return to loaded state
      emit(
        ProfileLoaded(
          user: currentState.user,
          language: currentState.language,
          notificationsEnabled: enable,
        ),
      );
    }
  }

  String _getStoredLanguage() {
    // In real app, get from SharedPreferences
    return 'English'; // Default
  }

  bool _getStoredNotificationsEnabled() {
    // In real app, get from SharedPreferences
    return true; // Default
  }
}
