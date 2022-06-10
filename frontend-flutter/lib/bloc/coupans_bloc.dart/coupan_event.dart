part of 'coupan_bloc.dart';

abstract class CoupanEvent extends Equatable {
  const CoupanEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends CoupanEvent {}
