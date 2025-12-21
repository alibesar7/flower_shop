
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/auth/presentation/login/widgets/dont_not_have_an_account.dart';
import 'package:flower_shop/features/auth/presentation/login/widgets/login_form.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Column(
        children: [
          LoginForm(
            formKey: GlobalKey<FormState>(),
            autoValidate: false,
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(LocaleKeys.continueAsGuest.tr()),
            ),
          ),
          const SizedBox(height: 15),
          const DontNotHaveAnAccount(),
        ],
      ),
    );
  }
}
