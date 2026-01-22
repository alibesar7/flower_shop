import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.user});

  final ProfileUserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          rowItem(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey.shade200,
                child: ClipOval(
                  child: Image.network(
                    user.photo ?? '',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return const Icon(Icons.person, size: 40);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.firstName ?? 'No Name'),
                  Text(user.email ?? 'No Email'),
                ],
              ),
            ],
          ),

          rowItem(
            children: [
              const Text('My Orders'),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),

          rowItem(
            children: [
              const Text('Saved Addresses'),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),

          rowItem(
            children: [
              const Text('Notifications'),
              Switch(value: true, onChanged: (_) {}),
            ],
          ),

          rowItem(
            children: [
              const Text('Language'),
              DropdownButton<String>(
                value: 'en',
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'ar', child: Text('Arabic')),
                ],
                onChanged: (_) {},
              ),
            ],
          ),

          rowItem(
            children: [
              const Text('About Us'),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),

          rowItem(
            children: [
              const Text('Terms and Conditions'),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),

          rowItem(
            children: [
              const Text('Logout'),
              IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
            ],
          ),
        ],
      ),
    );
  }
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
