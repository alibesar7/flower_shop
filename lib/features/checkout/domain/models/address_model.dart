import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String id;
  final String username;
  final String phone;
  final String city;
  final String street;
  final double lat;
  final double long;

  AddressModel({
    required this.id,
    required this.username,
    required this.phone,
    required this.city,
    required this.street,
    required this.lat,
    required this.long,
  });
  @override
  List<Object?> get props => [id, username, phone, city, street, lat, long];

  
}
