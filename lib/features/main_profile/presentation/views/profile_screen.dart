// presentation/views/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/main_profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_shop/features/main_profile/domain/models/profile_user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    // Get ProfileCubit directly from GetIt
    _profileCubit = GetIt.I.get<ProfileCubit>();
    _profileCubit.getProfile();
  }

  @override
  void dispose() {
    // Don't dispose if it's a singleton registered with GetIt
    // _profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: _profileCubit,
        builder: (context, state) {
          return _buildBody(context, state);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ProfileState state) {
    if (state is ProfileLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ProfileError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Error',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _profileCubit.getProfile(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is ProfileLoaded) {
      final apiResult = state.profile;

      if (apiResult is ErrorApiResult<ProfileUserModel>) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber, size: 64, color: Colors.orange),
              const SizedBox(height: 16),
              const Text(
                'API Error',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(apiResult.error, textAlign: TextAlign.center),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _profileCubit.getProfile(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      if (apiResult is SuccessApiResult<ProfileUserModel>) {
        return _buildProfileContent(context, apiResult.data);
      }
    }

    return const Center(child: Text('No profile data'));
  }

  Widget _buildProfileContent(BuildContext context, ProfileUserModel profile) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            _buildProfileHeader(context, profile),

            // Menu Items
            _buildMenuItems(context, profile),

            // App Version
            _buildAppVersion(),

            // Logout Button
            _buildLogoutButton(context),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, ProfileUserModel profile) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        children: [
          // Profile Image
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
            child: profile.photo.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      profile.photo,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildDefaultAvatar(profile);
                      },
                    ),
                  )
                : _buildDefaultAvatar(profile),
          ),

          const SizedBox(width: 16),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profile.firstName} ${profile.lastName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  profile.email,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  profile.phone,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Edit Button
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _navigateToEditProfile(context, profile),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar(ProfileUserModel profile) {
    return Center(
      child: Text(
        profile.firstName.isNotEmpty
            ? profile.firstName[0].toUpperCase()
            : profile.email.isNotEmpty
            ? profile.email[0].toUpperCase()
            : 'U',
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context, ProfileUserModel profile) {
    final menuItems = [
      ProfileMenuItem(
        title: 'My Orders',
        icon: Icons.shopping_bag_outlined,
        trailingText: profile.addresses.isNotEmpty
            ? '${profile.addresses.length}'
            : null,
        onTap: () => _navigateToOrders(context),
      ),
      ProfileMenuItem(
        title: 'Saved Addresses',
        icon: Icons.location_on_outlined,
        trailingText: profile.addresses.isNotEmpty
            ? '${profile.addresses.length}'
            : null,
        onTap: () => _navigateToAddresses(context, profile.addresses),
      ),
      ProfileMenuItem(
        title: 'Wishlist',
        icon: Icons.favorite_border,
        trailingText: profile.wishlist.isNotEmpty
            ? '${profile.wishlist.length}'
            : null,
        onTap: () => _navigateToWishlist(context, profile.wishlist),
      ),
      ProfileMenuItem(
        title: 'Notification',
        icon: Icons.notifications_outlined,
        onTap: () => _navigateToNotifications(context),
      ),
      ProfileMenuItem(
        title: 'Language',
        icon: Icons.language_outlined,
        trailingText: 'English',
        onTap: () => _showLanguageDialog(context),
      ),
      ProfileMenuItem(
        title: 'About us',
        icon: Icons.info_outline,
        onTap: () => _navigateToAboutUs(context),
      ),
      ProfileMenuItem(
        title: 'Terms & conditions',
        icon: Icons.description_outlined,
        onTap: () => _navigateToTerms(context),
      ),
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: menuItems.map((item) {
          return ListTile(
            leading: Icon(item.icon, color: Colors.deepPurple),
            title: Text(item.title),
            trailing: item.trailingText != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.trailingText!,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.chevron_right, color: Colors.grey.shade400),
                    ],
                  )
                : Icon(Icons.chevron_right, color: Colors.grey.shade400),
            onTap: item.onTap,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAppVersion() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          'v 8.3.0 - (1446)',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _showLogoutDialog(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade50,
            foregroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.red.shade200),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Logout',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  // Navigation Methods
  void _navigateToEditProfile(BuildContext context, ProfileUserModel profile) {
    Navigator.of(context).pushNamed('/edit-profile', arguments: profile);
  }

  void _navigateToOrders(BuildContext context) {
    Navigator.of(context).pushNamed('/orders');
  }

  void _navigateToAddresses(BuildContext context, List<dynamic> addresses) {
    Navigator.of(context).pushNamed('/addresses', arguments: addresses);
  }

  void _navigateToWishlist(BuildContext context, List<dynamic> wishlist) {
    Navigator.of(context).pushNamed('/wishlist', arguments: wishlist);
  }

  void _navigateToNotifications(BuildContext context) {
    Navigator.of(context).pushNamed('/notifications');
  }

  void _navigateToAboutUs(BuildContext context) {
    Navigator.of(context).pushNamed('/about');
  }

  void _navigateToTerms(BuildContext context) {
    Navigator.of(context).pushNamed('/terms');
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Update language
                },
              ),
              ListTile(
                title: const Text('Arabic'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Update language
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _performLogout(context);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _performLogout(BuildContext context) {
    // TODO: Implement logout logic using your AuthStorage
    // Example:
    // final authStorage = GetIt.I.get<AuthStorage>();
    // authStorage.clear();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }
}

class ProfileMenuItem {
  final String title;
  final IconData icon;
  final String? trailingText;
  final VoidCallback onTap;

  const ProfileMenuItem({
    required this.title,
    required this.icon,
    this.trailingText,
    required this.onTap,
  });
}
