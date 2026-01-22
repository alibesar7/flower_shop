import 'package:flower_shop/app/core/app_constants.dart';
import 'package:flower_shop/app/core/ui_helper/theme/app_theme.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileContent extends StatelessWidget {
  AppTheme appTheme = AppTheme();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final user = state.user;

        if (user.isLoading) {
          return const CircularProgressIndicator();
        }

        if (user.isError) {
          return Text(user.message ?? AppConstants.defaultErrorMessage);
        }

        if (user.isSuccess) {
          return BuildBody();
        }
        return BuildBody();
      },
    );
  }
}

BuildBody() {
  return BlocBuilder<ProfileCubit, ProfileState>(
    builder: (context, state) {
      final user = state.user;

      if (user.isSuccess) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              rowItem(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      user.data!.photo ?? 'https://via.placeholder.com/150',
                    ),
                  ),
                  Text(user.data!.email ?? 'No Email'),
                  Text(user.data?.firstName ?? 'No Username'),
                ],
              ),

              rowItem(
                children: [
                  Text('My Orders'),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),

              rowItem(
                children: [
                  Text('Saved Addresses'),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
              rowItem(
                children: [
                  Text('Notifications'),
                  Switch(value: true, onChanged: (val) {}),
                ],
              ),
              rowItem(
                children: [
                  Text('Language'),
                  DropdownButton(
                    items: [
                      DropdownMenuItem(value: 'en', child: Text('English')),
                      DropdownMenuItem(value: 'ar', child: Text('Arabic')),
                    ],
                    onChanged: (val) {},
                  ),
                ],
              ),
              rowItem(
                children: [
                  Text('About Us'),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
              rowItem(
                children: [
                  Text('Terms and Conditions'),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),

              rowItem(
                children: [
                  Text('Logout'),
                  IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
                ],
              ),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    },
  );
}

Widget rowItem({
  required List<Widget> children,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
}) {
  return Row(
    mainAxisAlignment: mainAxisAlignment,
    crossAxisAlignment: crossAxisAlignment,
    children: children,
  );
}
