class UserModel {
  final String id;
  final String firstName;
  final String? lastName;
  final String email;
  final String? photo;
  final String role;
  final String? phone;
  final String? gender;
  final List<dynamic>? wishlist;

  const UserModel({
    required this.id,
    required this.firstName,
    this.lastName,
    required this.email,
    this.photo,
    required this.role,
    this.phone,
    this.gender,
    this.wishlist,
  });
}
