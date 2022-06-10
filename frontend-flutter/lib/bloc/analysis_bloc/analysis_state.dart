part of 'analysis_bloc.dart';

abstract class AnalysisState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResultLoadingState extends AnalysisState {}

class ResultFailedState extends AnalysisState {
  final String? message;
  ResultFailedState({required this.message});
  @override
  List<Object?> get props => [message];
}

class ResultLoadedState extends AnalysisState {
  final String negativeCount;
  final String neutralCount;
  final String overallPolarity;
  final String positiveCount;
  final String sarcasmCount;
  final String spamCount;
  final String thumbnail;
  final String title;
  final String totalData;
  ResultLoadedState(
      {required this.negativeCount,
      required this.neutralCount,
      required this.overallPolarity,
      required this.positiveCount,
      required this.sarcasmCount,
      required this.spamCount,
      required this.thumbnail,
      required this.title,
      required this.totalData});

  @override
  List<Object?> get props => [
        negativeCount,
        neutralCount,
        overallPolarity,
        positiveCount,
        sarcasmCount,
        spamCount,
        thumbnail,
        title,
        totalData
      ];
}
