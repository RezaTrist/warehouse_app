class Profile {
  final int userId;
  final int roleId;
  final String name;
  final String email;
  final String password;

  Profile({
    required this.userId,
    required this.roleId,
    required this.name,
    required this.email,
    required this.password,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      userId: json['User_ID'] as int,
      roleId: json['Role_ID'] as int,
      name: json['Name'] as String,
      email: json['Email'] as String,
      password: json['Password'] as String,
    );
  }
}
