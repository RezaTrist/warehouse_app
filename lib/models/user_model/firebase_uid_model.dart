class ReadUserFirebase {
  final String message;
  final UserLogin data;

  ReadUserFirebase({
    required this.message,
    required this.data,
  });

  factory ReadUserFirebase.fromJson(Map<String, dynamic> json) {
    UserLogin userLogin = UserLogin.fromJson(json['data']);

    return ReadUserFirebase(
      message: json['message'],
      data: userLogin,
    );
  }
}

class UserLogin {
  final int userId;
  final int roleId;
  final String name;
  final String email;
  final String firebaseUid;

  UserLogin({
    required this.userId,
    required this.roleId,
    required this.name,
    required this.email,
    required this.firebaseUid,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      userId: json['User_ID'] as int,
      roleId: json['Role_ID'] as int,
      name: json['Name'] as String,
      email: json['Email'] as String,
      firebaseUid: json['Firebase_UID'] as String,
    );
  }
}
