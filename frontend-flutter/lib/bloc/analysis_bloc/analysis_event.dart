part of 'analysis_bloc.dart';

abstract class AnalysisEvent extends Equatable {
  const AnalysisEvent();

  @override
  List<Object> get props => [];
}

class GetSentimentResult extends AnalysisEvent {
  final String platform;
  final String dataSource;
  final String approxData;
  const GetSentimentResult(
      {required this.platform,
      required this.dataSource,
      required this.approxData});

  @override
  List<Object> get props => [platform, dataSource, approxData];
}
