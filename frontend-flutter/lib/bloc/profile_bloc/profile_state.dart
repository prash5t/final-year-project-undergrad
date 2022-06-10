part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final String name;
  final String email;
  final String purpose;
  final String analysisCount;
  final String vacancyCount;
  ProfileLoadedState(
      {required this.name,
      required this.email,
      required this.purpose,
      required this.analysisCount,
      required this.vacancyCount});
  @override
  List<Object?> get props =>
      [name, email, purpose, analysisCount, vacancyCount];
}

class ProfileFailedState extends ProfileState {
  final String? message;
  ProfileFailedState({required this.message});
  @override
  List<Object?> get props => [message];
}
