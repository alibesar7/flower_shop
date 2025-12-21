import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/auth/presentation/login/widgets/login_options.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool autoValidate;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.autoValidate,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autoValidate
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration:  InputDecoration(
              labelText: LocaleKeys.email.tr(),
              hintText: LocaleKeys.enterYourEmail.tr(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: _obscurePassword,
            obscuringCharacter: '*',
            decoration: InputDecoration(
              labelText: LocaleKeys.password.tr(),
              hintText: 'enterYourPassword'.tr(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 22),
          LoginOptions(
            onChanged: (isChecked) {},
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {  },
            child: Text(LocaleKeys.login.tr()),
          ),
        ],
      ),
    );
  }
}
