import 'package:equatable/equatable.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final String? errorMessage;
  final String? userId;
  final String? accountType;

  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.userId,
    this.accountType,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    String? userId,
    String? accountType,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      userId: userId ?? this.userId,
      accountType: accountType ?? this.accountType,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, userId, accountType];
}
