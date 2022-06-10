import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sentimento/api/analysis_requests.dart';
import 'package:youtube_parser/youtube_parser.dart';
part 'analysis_event.dart';
part 'analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  AnalysisBloc(ResultLoadingState resultLoadingState)
      : super(ResultLoadingState()) {
    on<GetSentimentResult>(_getSentimentResult);
  }

  FutureOr<void> _getSentimentResult(GetSentimentResult getSentimentResult,
      Emitter<AnalysisState> emit) async {
    //using this loading state, will show loading UI
    emit.call(ResultLoadingState());

    //when loading task finishes, now will show sentiment result
    try {
      if (getSentimentResult.platform == "youtube") {
        var videoIdOnly = getIdFromUrl(getSentimentResult.dataSource);
        var youtubeResponse = await requestYouTubeSentiment(
            videoIdOnly, getSentimentResult.approxData);
        handleSentimentState(getSentimentResult.platform,
            getSentimentResult.dataSource, youtubeResponse, emit);
      } else if (getSentimentResult.platform == "twitter") {
        var twitterResponse = await requestTwitterSentiment(
            getSentimentResult.dataSource, getSentimentResult.approxData);
        handleSentimentState(getSentimentResult.platform,
            getSentimentResult.dataSource, twitterResponse, emit);
      }
    } catch (e) {
      emit.call(ResultFailedState(message: "No internet or try again"));
    }
  }

  void handleSentimentState(String platform, String title, backendResponse,
      Emitter<AnalysisState> emit) async {
    if (backendResponse["success"] == "true") {
      //if its twitter, we need to give manual thumbnail and topic title,so:
      String thumb = "https://pbs.twimg.com/media/BZxfWkrCAAA9fqL.jpg";
      String topic = title;
      if (platform == "youtube") {
        thumb = "${backendResponse["thumbnail"]}".toString();
        topic = "${backendResponse["title"]}".toString();
      }

      //when  request is valid, will go to result ready state
      emit.call(ResultLoadedState(
          negativeCount: backendResponse["negative_count"].toString(),
          neutralCount: backendResponse["neutral_count"].toString(),
          overallPolarity: backendResponse["overall_polarity"].toString(),
          positiveCount: backendResponse["positive_count"].toString(),
          sarcasmCount: backendResponse["sarcasm_count"].toString(),
          spamCount: backendResponse["spam_count"].toString(),
          //we wont get thumbnail and title from backend if its twiter so handling manually
          thumbnail: thumb,
          title: topic,
          totalData: backendResponse["total_data"].toString()));
    } else {
      emit.call(ResultFailedState(message: backendResponse["msg"]));
    }
  }
}
