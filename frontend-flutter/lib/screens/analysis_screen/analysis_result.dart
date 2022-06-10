import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentimento/bloc/analysis_bloc/analysis_bloc.dart';
import 'package:sentimento/screens/analysis_screen/bloc_analysis_screen.dart';
import 'package:sentimento/screens/home_screen/home_screen.dart';
import 'package:sentimento/widgets/minor_ui_parts.dart';

class AnalysisResult extends StatelessWidget {
  const AnalysisResult(
      {Key? key,
      required this.platform,
      required this.dataSource,
      required this.approxData})
      : super(key: key);
  final String platform;
  final String dataSource;
  final String approxData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnalysisBloc(ResultLoadingState())
        ..add(GetSentimentResult(
            platform: platform,
            dataSource: dataSource,
            approxData: approxData)),
      child:
          BlocBuilder<AnalysisBloc, AnalysisState>(builder: (context, state) {
        if (state is ResultLoadingState) {
          return const SentimentResult(
            resultState: "loading",
          );
        } else if (state is ResultLoadedState) {
          return SentimentResult(
              resultState: "loaded",
              platform: platform,
              thumbnail: state.thumbnail,
              title: state.title,
              totalData: state.totalData,
              spamCount: state.spamCount,
              sarcasmCount: state.sarcasmCount,
              positiveCount: state.positiveCount,
              negativeCount: state.negativeCount,
              neutralCount: state.neutralCount,
              overallPolarity: state.overallPolarity);
        } else if (state is ResultFailedState) {
          manualToastMsg(state.message);
        }
        return const HomeScreen();
      }),
    );
  }
}
