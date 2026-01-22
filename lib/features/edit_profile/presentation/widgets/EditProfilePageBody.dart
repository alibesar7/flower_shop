import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/app/config/auth_storage/auth_storage.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/features/auth/presentation/signup/widgets/text_form_field_widget.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/uploadPhotoCubit.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/uploadPhotoIntent.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/uploadPhotoState.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/editProfileCubit/editProfileCubit.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/editProfileCubit/editProfileIntent.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/editProfileCubit/editProfileState.dart';

class EditProfilePageBody extends StatelessWidget {
  const EditProfilePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController(text: 'ali');
    final lastNameController = TextEditingController(text: 'Mohamed');
    final emailController = TextEditingController(text: 'alibesar@gmail.com');
    final phoneController = TextEditingController(text: '+201557689713');

    final editCubit = context.read<EditProfileCubit>();
    final photoCubit = context.read<UploadPhotoCubit>();

    return BlocListener<EditProfileCubit, EditProfileStates>(
      listener: (context, state) {
        final resource = state.editProfileResource;
        if (resource.status == Status.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                "Profile updated successfully!",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColors.pink,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (resource.status == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                resource.message ?? "Something went wrong",
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // === Photo Section ===
            BlocBuilder<UploadPhotoCubit, UploadPhotoState>(
              builder: (context, state) {
                ImageProvider avatarImage;
                if (state.selectedPhoto != null) {
                  avatarImage = FileImage(state.selectedPhoto!);
                } else {
                  avatarImage = const AssetImage('assets/images/filter.png');
                }

                return Column(
                  children: [
                    CircleAvatar(radius: 50, backgroundImage: avatarImage),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          photoCubit.doIntent(
                            SelectPhotoIntent(File(pickedFile.path)),
                          );
                        }
                      },
                      icon: const Icon(Icons.camera_alt, color: AppColors.pink),
                      label: const Text(
                        "Change Photo",
                        style: TextStyle(color: AppColors.pink),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              },
            ),

            // === Profile Fields ===
            Row(
              children: [
                Expanded(
                  child: TextFormFieldWidget(
                    label: 'First name',
                    hint: 'First name',
                    controller: firstNameController,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormFieldWidget(
                    label: 'Last name',
                    hint: 'Last name',
                    controller: lastNameController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              label: 'Email',
              hint: 'Email',
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            const SizedBox(height: 16),
            TextFormFieldWidget(
              label: 'Phone number',
              hint: 'Phone number',
              keyboardType: TextInputType.phone,
              controller: phoneController,
            ),
            const SizedBox(height: 32),

            // === Single Update Button ===
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  final authStorage = getIt<AuthStorage>();
                  final token = await authStorage.getToken();
                  if (token == null) return;
                  if (photoCubit.state.selectedPhoto != null) {
                    photoCubit.doIntent(
                      UploadSelectedPhotoIntent('Bearer $token'),
                    );
                  }
                  editCubit.doIntent(
                    PerformEditProfile(
                      token: 'Bearer $token',
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                    ),
                  );
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
