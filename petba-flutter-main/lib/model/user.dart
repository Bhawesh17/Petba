class UserData {
  final int id;
  final String name, email;
  final phone;

  UserData({
    this.name,
    this.email,
    this.id,
    this.phone,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(id: json['id'], name: json['name'], email: json['email']);
  }
}
