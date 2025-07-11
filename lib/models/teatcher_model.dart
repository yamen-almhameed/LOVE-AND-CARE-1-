class TeacherModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String status;
  final String role;
  final bool isVerified;
  final String? verificationToken;
  final String? verificationExpires;
  final String? lastLoginAt;
  final int loginAttempts;
  final String? accountLockedUntil;
  final String? profileImageUrl;
  final String timezone;
  final String locale;
  final String createdAt;
  final String updatedAt;

  TeacherModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.role,
    required this.isVerified,
    this.verificationToken,
    this.verificationExpires,
    this.lastLoginAt,
    required this.loginAttempts,
    this.accountLockedUntil,
    this.profileImageUrl,
    required this.timezone,
    required this.locale,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
      role: json['role'],
      isVerified: json['isVerified'],
      verificationToken: json['verificationToken'],
      verificationExpires: json['verificationExpires'],
      lastLoginAt: json['lastLoginAt'],
      loginAttempts: json['loginAttempts'],
      accountLockedUntil: json['accountLockedUntil'],
      profileImageUrl: json['profileImageUrl'],
      timezone: json['timezone'],
      locale: json['locale'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
