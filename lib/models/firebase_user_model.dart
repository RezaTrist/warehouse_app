class FirebaseUser {
  final String uid;
  final String? email;
  final String? password;

  const FirebaseUser({
    required this.uid,
    this.email,
    this.password,
  });

  static const empty = FirebaseUser(email: '', uid: '', password: '');
}
