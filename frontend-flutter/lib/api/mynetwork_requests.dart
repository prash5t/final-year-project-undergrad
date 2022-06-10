import 'dart:convert';
import 'package:sentimento/models/post_model.dart';
import 'package:sentimento/widgets/minor_ui_parts.dart';

import 'api_universal.dart';

const String vacancyEndPoint = "$domain/vacancy/";
const String deletePostEndPoint = "$domain/vacancy/?id=";
const String vacanciesEndPoint = "$domain/vacancy/all/?filter=vacancy";
const String freelancersEndPoint = "$domain/vacancy/all/?filter=freelancer";

Future requestAllPosts(filter) async {
  if (filter == "vacancy") {
    var response = blocResponder(await getGETResponse(vacanciesEndPoint));
    return PostModel.fromJson(response);
  } else {
    var response = blocResponder(await getGETResponse(freelancersEndPoint));
    return PostModel.fromJson(response);
  }
}

Future requestUserPosts() async {
  var response = blocResponder(await getGETResponse(vacancyEndPoint));
  return PostModel.fromJson(response);
}

Future addNewPost(Vacancy post) async {
  var requestBody = jsonEncode(<String, dynamic>{
    "title": post.title,
    "contact_email": post.contactEmail,
    "contact_number": post.contactNumber,
    "description": post.description,
    "work_hr": post.workHr,
    "wage_hr": post.wageHr,
    "is_negotiable": post.isNegotiable,
    "is_vacancy": post.isVacancy
  });
  var response =
      blocResponder(await getPostResponse(vacancyEndPoint, requestBody));
  manualToastMsg(response["msg"]);

  return response;
}

Future deleteSelectedPost(postId) async {
  var deleteResponse =
      blocResponder(await getDELETEResponse("$deletePostEndPoint$postId"));
  manualToastMsg(deleteResponse["msg"]);

  return deleteResponse;
}
