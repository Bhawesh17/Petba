class Zone {
  Zone({
    this.id,
    this.name,
  });

  final int id;
  final String name;

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['zone_id'],
      name: json['name'],
    );
  }
}
