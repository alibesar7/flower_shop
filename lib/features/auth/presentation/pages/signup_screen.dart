import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/features/auth/presentation/manager/auth_bloc.dart';
import 'package:flower_shop/features/auth/presentation/manager/auth_states.dart';
import 'package:flower_shop/features/auth/presentation/widgets/form_signup_widget.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final bloc = getIt<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {},
        ),
        title: Text(LocaleKeys.signupTitle.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => bloc,
          child: BlocBuilder<AuthBloc, AuthStates>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(children: [FormSignupWidget()]),
              );
            },
          ),
        ),
      ),
    );
  }
}
