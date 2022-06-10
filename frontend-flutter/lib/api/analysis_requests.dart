import 'dart:convert';
import 'package:sentimento/models/saved_report.dart';
import 'package:sentimento/utilities/securestorage.dart';
import 'package:sentimento/widgets/minor_ui_parts.dart';

import 'api_universal.dart';

const String youtubeEndPoint = "$domain/red/";
const String twitterEndPoint = "$domain/blue/";
const String manualEndPoint = "$domain/manual/";
const String reportEndPoint = "$domain/report/";

Future requestYouTubeSentiment(videoId, approxComments) async {
  String? key = await secureStorage?.read(key: 'red-key');
  var requestBody = jsonEncode(<String, String>{
    "video_id": videoId,
    "approx_comments": approxComments,
    "api_key": "$key"
  });
  return blocResponder(await getPostResponse(youtubeEndPoint, requestBody));
}

Future requestTwitterSentiment(topic, approxTweets) async {
  String? consumerKey = await secureStorage?.read(key: 'consumer-key');
  String? consumerSecret = await secureStorage?.read(key: 'consumer-secret');
  String? accessToken = await secureStorage?.read(key: 'blue-access');
  String? accessTokenSecret =
      await secureStorage?.read(key: 'blue-access-secret');
  var requestBody = jsonEncode(<String, String>{
    "searched_topic": topic,
    "approx_data": approxTweets,
    "c_key": "$consumerKey",
    "c_secret": "$consumerSecret",
    "a_token": "$accessToken",
    "a_token_secret": "$accessTokenSecret"
  });
  return blocResponder(await getPostResponse(twitterEndPoint, requestBody));
}

Future requestManualSentiment(data) async {
  var requestBody = jsonEncode(<String, String>{"manual_data": data});
  var manualResponse =
      blocResponder(await getPostResponse(manualEndPoint, requestBody));
  if (manualResponse["success"] == "true") {
    return (manualResponse["polarity"]);
  } else {
    manualToastMsg(manualResponse["msg"]);
  }
}

Future saveSentimentReport(platform, data, dataCount, spamCount, sarcasmCount,
    positiveCount, negativeCount, neutralCount, overallPolarity) async {
  var requestBody = jsonEncode(<String, String>{
    "platform": platform,
    "data": data,
    "overall_polarity": overallPolarity,
    "data_count": dataCount,
    "spam_count": spamCount,
    "sarcasm_count": sarcasmCount,
    "positive_count": positiveCount,
    "negative_count": negativeCount,
    "neutral_count": neutralCount
  });
  var saveResponse =
      blocResponder(await getPostResponse(reportEndPoint, requestBody));
  manualToastMsg(saveResponse["msg"]);
}

Future viewSentimentReports() async {
  var response = blocResponder(await getGETResponse(reportEndPoint));
  //now will convert to saved report model and return its object
  return ReportModel.fromJson(response);
}
