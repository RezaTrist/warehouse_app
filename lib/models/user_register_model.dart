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

  Map<String, dynamic> toJson() {
    return {
      'Role_ID': roleId,
      'Name': name,
      'Email': email,
      'Password': password,
    };
  }
}
