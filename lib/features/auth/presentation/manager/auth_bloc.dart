import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/config/validation/app_validation.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/domain/models/signup_model.dart';
import 'package:flower_shop/features/auth/domain/usecase/auth_usecase.dart';
import 'package:flower_shop/features/auth/presentation/manager/auth_events.dart';
import 'package:flower_shop/features/auth/presentation/manager/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthBloc extends Cubit<AuthStates> {
  final AuthUsecase _authUsecase;
  AuthBloc(this._authUsecase) : super(AuthStates());

  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';
  String fName = '';
  String lName = '';
  String phone = '';
  String gender = '';

  void doIntent(AuthEvents event) async {
    switch (event) {
      case SignupEvent():
        _signup();
      case FirstNameChangedEvent():
        _firstNameChanged();
      case LastNameChangedEvent():
        _lastNameChanged(event.lastName.toString());
      case EmailChangedEvent():
        _emailChanged(event.email.toString());
      case PasswordChangedEvent():
        _passwordChanged(event.password.toString());
      case ConfirmPasswordChangedEvent():
        _confirmPasswordChanged(event.confirmPassword.toString());
      case PhoneChangedEvent():
        _phoneChanged(event.phone.toString());
      case GenderChangedEvent():
        _genderChanged(event.gender.toString());
    }
  }

  Future<void> _signup() async {
    final genderError = Validators.genderValidator(gender);
    if (!formKey.currentState!.validate() || genderError != null) {
      emit(
        state.copywith(
          signupStateCopywith: SignupState(genderError: genderError),
        ),
      );
      return;
    }
    emit(
      state.copywith(signupStateCopywith: SignupState(status: Status.loading)),
    );
    ApiResult<SignupModel> response = await _authUsecase.call(
      fName: fName,
      lName: lName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      gender: gender,
      phone: phone,
    );
    switch (response) {
      case SuccessApiResult<SignupModel>():
        emit(
          state.copywith(
            signupStateCopywith: SignupState(
              status: Status.success,
              data: response.data,
            ),
          ),
        );
      case ErrorApiResult<SignupModel>():
        emit(
          state.copywith(
            signupStateCopywith: SignupState(
              status: Status.error,
              error: response.error.toString(),
            ),
          ),
        );
    }
  }

  void _firstNameChanged() {
    // fName = value;
    emit(
      state.copywith(signupStateCopywith: SignupState(changeFirstName: true)),
    );
  }

  void _lastNameChanged(String value) {
    lName = value;
    emit(
      state.copywith(signupStateCopywith: SignupState(changeLastName: true)),
    );
  }

  void _emailChanged(String value) {
    email = value;
    emit(state.copywith(signupStateCopywith: SignupState(changeEmail: true)));
  }

  void _passwordChanged(String value) {
    password = value;
    emit(
      state.copywith(signupStateCopywith: SignupState(changePassword: true)),
    );
  }

  void _confirmPasswordChanged(String value) {
    confirmPassword = value;
    emit(
      state.copywith(
        signupStateCopywith: SignupState(changeConfirmPassword: true),
      ),
    );
  }

  void _phoneChanged(String value) {
    phone = value;
    emit(state.copywith(signupStateCopywith: SignupState(changePhone: true)));
  }

  void _genderChanged(String value) {
    gender = value;
    emit(
      state.copywith(
        signupStateCopywith: SignupState(changeGender: true, genderError: null),
      ),
    );
  }
}
