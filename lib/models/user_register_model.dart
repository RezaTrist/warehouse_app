class UserRegister {
  final int roleId;
  final String name;
  final String email;
  final String password;

  UserRegister({
    required this.roleId,
    required this.name,
    required this.email,
    required this.password,
  });

  factory UserRegister.fromJson(Map<String, dynamic> json) {
    return UserRegister(
      roleId: json['Role_ID'] as int,
      name: json['Name'] as String,
      email: json['Email'] as String,
      password: json['Password'] as String,
    );
  }
}
