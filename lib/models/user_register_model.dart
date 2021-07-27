class ProfileRegister {
  final int roleId;
  final String name;
  final String email;
  final String password;

  ProfileRegister({
    required this.roleId,
    required this.name,
    required this.email,
    required this.password,
  });

  factory ProfileRegister.fromJson(Map<String, dynamic> json) {
    return ProfileRegister(
      roleId: json['Role_ID'] as int,
      name: json['Name'] as String,
      email: json['Email'] as String,
      password: json['Password'] as String,
    );
  }
}
