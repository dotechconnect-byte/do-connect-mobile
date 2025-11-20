import 'package:do_connect/features/auth/presentation/pages/signup_screen.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  final String accountType;

  const LoginRequested({
    required this.email,
    required this.password,
    required this.accountType,
  });

  @override
  List<Object?> get props => [email, password, accountType];
}

class SignupRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String contactNumber;
  final SignupType signupType;
  final String? accessCode;
  final String? position;
  final String? address;
  final String? accountType;
  final String? companyName; // NEW
  final String? website; // NEW

  const SignupRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.contactNumber,
    required this.signupType,
    this.accessCode,
    this.position,
    this.address,
    this.accountType,
    this.companyName, // NEW
    this.website, // NEW
  });
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  const ForgotPasswordRequested({required this.email});

  @override
  List<Object?> get props => [email];
}
