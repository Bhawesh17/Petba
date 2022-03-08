class Country {
  final int id;
  final String name;

  Country({
    this.id,
    this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['country_id'],
      name: json['name'],
    );
  }
}
