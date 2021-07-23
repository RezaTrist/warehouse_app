class UserPack {
  final String message;
  final List<UserRole> data;

  UserPack({required this.message, required this.data});

  factory UserPack.fromJson(Map<String, dynamic> json) {
    List<UserRole> _temp = [];
    for (Map<String, dynamic> role in json['data']) {
      _temp.add(UserRole.fromJson(role));
    }
    return UserPack(message: json['message'], data: _temp);
  }
}

class UserRole {
  final int roleId;
  final String role;

  UserRole({
    required this.roleId,
    required this.role,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      roleId: json['Role_ID'] as int,
      role: json['Role'] as String,
    );
  }
}
