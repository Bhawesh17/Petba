class Address {
  final String firstName, lastName, address, zone, country, type, city;
  final int addressId, phone;

  Address({
    this.addressId,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.city,
    this.zone,
    this.country,
    this.type,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressId: json['address_id'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      zone: json['zone']['name'],
      country: json['country']['name'],
      type: "Home",
    );
  }
}
