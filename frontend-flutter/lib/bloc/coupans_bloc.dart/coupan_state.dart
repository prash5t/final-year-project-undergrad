part of 'coupan_bloc.dart';

abstract class CoupanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends CoupanState {}

class CoupansState extends CoupanState {
  final String? yKey;
  final String? ck;
  final String? cs;
  final String? at;
  final String? ats;
  CoupansState(
      {required this.yKey,
      required this.ck,
      required this.cs,
      required this.at,
      required this.ats});
  @override
  List<Object?> get props => [yKey, ck, cs, at, ats];
}
