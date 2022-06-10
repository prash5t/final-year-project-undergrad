part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends AuthEvent {}

class SessionCheckerEvent extends AuthEvent {}

class LoginClickedEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginClickedEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterClickedEvent extends AuthEvent {
  final String fullName;
  final String purpose;
  final String email;
  final String password;
  const RegisterClickedEvent(
      {required this.fullName,
      required this.purpose,
      required this.email,
      required this.password});

  @override
  List<Object> get props => [fullName, purpose, email, password];
}
