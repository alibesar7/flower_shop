import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'address_response.g.dart';

@JsonSerializable()
class AddressResponse {
    @JsonKey(name: "message")
    final String message;
    @JsonKey(name: "addresses")
    final List<Address> addresses;

    AddressResponse({
        required this.message,
        required this.addresses,
    });

    factory AddressResponse.fromJson(Map<String, dynamic> json) => _$AddressResponseFromJson(json);

    Map<String, dynamic> toJson() => _$AddressResponseToJson(this);
}

@JsonSerializable()
class Address {
    @JsonKey(name: "street")
    final String street;
    @JsonKey(name: "phone")
    final String phone;
    @JsonKey(name: "city")
    final String city;
    @JsonKey(name: "lat")
    final String lat;
    @JsonKey(name: "long")
    final String long;
    @JsonKey(name: "username")
    final String username;
    @JsonKey(name: "_id")
    final String id;

    Address({
        required this.street,
        required this.phone,
        required this.city,
        required this.lat,
        required this.long,
        required this.username,
        required this.id,
    });

    factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

    Map<String, dynamic> toJson() => _$AddressToJson(this);
}
