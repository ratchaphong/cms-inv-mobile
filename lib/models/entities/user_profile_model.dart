class UserProfileModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? gender;
  final DateTime? birthDate;
  final String? avatarUrl;
  final String? address;
  final String role;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.gender,
    this.birthDate,
    this.avatarUrl,
    this.address,
    required this.role,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      gender: json['gender'],
      birthDate:
          json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      avatarUrl: json['avatarUrl'],
      address: json['address'],
      role: json['role'] ?? '',
    );
  }
}
