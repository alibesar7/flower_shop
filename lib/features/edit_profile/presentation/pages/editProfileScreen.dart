import 'package:flower_shop/features/edit_profile/presentation/manager/editProfileCubit/editProfileCubit.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/uploadPhotoCubit.dart';
import 'package:flower_shop/features/edit_profile/presentation/widgets/EditProfilePageBody.dart';
import 'package:flower_shop/features/edit_profile/data/models/response/editprofile_response/edit_profile_resonse.dart';
import 'package:flower_shop/features/edit_profile/presentation/widgets/editPhotoBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/app/config/di/di.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<EditProfileCubit>()),
        BlocProvider(create: (context) => getIt<UploadPhotoCubit>()),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              EditPhotoBody(),
              SizedBox(height: 24),
              EditProfilePageBody(),
            ],
          ),
        ),
      ),
    );
  }
}
