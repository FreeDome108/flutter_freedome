import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  const factory Customer({
    required int id,
    required String email,
    required String firstname,
    required String lastname,
    String? middlename,
    String? prefix,
    String? suffix,
    String? gender,
    String? dateOfBirth,
    String? taxvat,
    bool? isSubscribed,
    String? groupId,
    String? defaultBilling,
    String? defaultShipping,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? customAttributes,
    List<Address>? addresses,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    required int id,
    required String firstname,
    required String lastname,
    String? middlename,
    String? prefix,
    String? suffix,
    String? company,
    required String street,
    required String city,
    required String region,
    required String postcode,
    required String countryId,
    String? telephone,
    String? fax,
    String? vatId,
    bool? isDefaultBilling,
    bool? isDefaultShipping,
    Map<String, dynamic>? customAttributes,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
}
