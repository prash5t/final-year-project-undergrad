part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingState extends AuthState {}

class LoggedOutState extends AuthState {}

class LoggedInState extends AuthState {}

class MessageState extends AuthState {
  final String? message;
  MessageState({required this.message});
  @override
  List<Object?> get props => [message];
}
