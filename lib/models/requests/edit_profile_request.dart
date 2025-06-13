class EditProfileRequest {
  final String userId;
  final String name;
  final String email;
  final String phoneNumber;
  final String? address;
  final String? avatarUrl;

  EditProfileRequest({
    required this.userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.address,
    this.avatarUrl,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
    if (address != null) map['address'] = address;
    if (avatarUrl != null) map['avatarUrl'] = avatarUrl;
    return map;
  }
}
