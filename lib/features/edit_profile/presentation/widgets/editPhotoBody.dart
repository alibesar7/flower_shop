import 'dart:io';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/uploadPhotoCubit.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/uploadPhotoIntent.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/uploadPhotoState.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';

class EditPhotoBody extends StatelessWidget {
  const EditPhotoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UploadPhotoCubit>();

    return BlocConsumer<UploadPhotoCubit, UploadPhotoState>(
      listener: (context, state) {
        final resource = state.uploadPhotoResource;

        if (resource.status == Status.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                "Photo uploaded successfully!",
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
                resource.message ?? "Upload failed",
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
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: state.selectedPhoto != null
                  ? FileImage(state.selectedPhoto!)
                  : const AssetImage('assets/images/filter.png')
                        as ImageProvider,
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  cubit.doIntent(SelectPhotoIntent(File(pickedFile.path)));
                }
              },
              icon: const Icon(Icons.camera_alt, color: AppColors.pink),
              label: const Text(
                "Change Photo",
                style: TextStyle(color: AppColors.pink),
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
