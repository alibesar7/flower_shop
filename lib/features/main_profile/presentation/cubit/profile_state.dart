part of 'profile_cubit.dart';

sealed class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  final String language;
  final bool notificationsEnabled;

  const ProfileLoaded({
    required this.user,
    required this.language,
    required this.notificationsEnabled,
  });

  String get displayName {
    final firstName = user.firstName ?? '';
    final lastName = user.lastName ?? '';
    final name = '$firstName $lastName'.trim();

    if (name.isEmpty && user.email != null) {
      return user.email!.split('@').first;
    }

    return name;
  }

  String get initials {
    final firstName = user.firstName ?? '';
    final lastName = user.lastName ?? '';

    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return '${firstName[0]}${lastName[0]}'.toUpperCase();
    } else if (firstName.isNotEmpty) {
      return firstName[0].toUpperCase();
    } else if (lastName.isNotEmpty) {
      return lastName[0].toUpperCase();
    } else if (user.email != null && user.email!.isNotEmpty) {
      return user.email![0].toUpperCase();
    }

    return 'U';
  }
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);
}

class LogoutSuccess extends ProfileState {}

class LanguageChanged extends ProfileState {
  final String language;

  const LanguageChanged(this.language);
}

class NotificationToggled extends ProfileState {
  final bool enabled;

  const NotificationToggled(this.enabled);
}
