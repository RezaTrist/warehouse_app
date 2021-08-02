part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  Unauthenticated,
  Authenticated,
  Unknown,
}

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.user = FirebaseUser.empty,
    this.status = AuthenticationStatus.Unknown,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.Unauthenticated);

  const AuthenticationState.authenticated(FirebaseUser user)
      : this._(user: user, status: AuthenticationStatus.Authenticated);

  final FirebaseUser user;
  final AuthenticationStatus status;

  @override
  List<Object> get props => [
        user,
        status,
      ];
}
