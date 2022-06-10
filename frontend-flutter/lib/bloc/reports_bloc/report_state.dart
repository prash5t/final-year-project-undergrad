part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReportLoadingState extends ReportState {}

class ReportLoadedState extends ReportState {
  final List<Reports>? reports;
  ReportLoadedState({required this.reports});
  @override
  List<Object?> get props => [reports];
}

class ReportFailedState extends ReportState {
  final String? message;
  ReportFailedState({required this.message});
  @override
  List<Object?> get props => [message];
}
