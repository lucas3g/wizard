class Address {
  final String zipCode;
  final String state;
  final String city;
  final String address;
  final String number;
  final String district;

  Address({
    required this.zipCode,
    required this.state,
    required this.city,
    required this.address,
    required this.number,
    required this.district,
  });

  factory Address.empty() => Address(
      zipCode: '', state: '', city: '', address: '', number: '', district: '');
}
