class FirebaseUser {
  final String uid;
  final String? email;
  final String? name;

  const FirebaseUser({
    required this.uid,
    this.email,
    this.name,
  });

  static const empty = FirebaseUser(
    email: '',
    uid: '',
    name: null,
  );
}
