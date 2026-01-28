sealed class SavedAddressIntent {}

class GetAddressesIntent extends SavedAddressIntent {}

class DeleteAddressIntent extends SavedAddressIntent {
  final String addressId;

  DeleteAddressIntent({required this.addressId});
}

class EditAddressIntent extends SavedAddressIntent {
  final String addressId;
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String username;

  EditAddressIntent({
    required this.addressId,
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
  });
}
