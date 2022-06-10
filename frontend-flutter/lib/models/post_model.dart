class PostModel {
  String? msg;
  String? success;
  List<Vacancy>? vacancies;

  PostModel({this.msg, this.success, this.vacancies});

  PostModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    success = json['success'];
    if (json['vacancies'] != null) {
      vacancies = <Vacancy>[];
      json['vacancies'].forEach((v) {
        vacancies!.add(Vacancy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['success'] = success;
    if (vacancies != null) {
      data['vacancies'] = vacancies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vacancy {
  String? contactEmail;
  String? contactNumber;
  String? description;
  int? id;
  bool? isNegotiable;
  bool? isVacancy;
  String? title;
  String? wageHr;
  int? workHr;

  Vacancy(
      {this.contactEmail,
      this.contactNumber,
      this.description,
      this.id,
      this.isNegotiable,
      this.isVacancy,
      this.title,
      this.wageHr,
      this.workHr});

  Vacancy.fromJson(Map<String, dynamic> json) {
    contactEmail = json['contact_email'];
    contactNumber = json['contact_number'];
    description = json['description'];
    id = json['id'];
    isNegotiable = json['is_negotiable'];
    isVacancy = json['is_vacancy'];
    title = json['title'];
    wageHr = json['wage_hr'];
    workHr = json['work_hr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contact_email'] = contactEmail;
    data['contact_number'] = contactNumber;
    data['description'] = description;
    data['id'] = id;
    data['is_negotiable'] = isNegotiable;
    data['is_vacancy'] = isVacancy;
    data['title'] = title;
    data['wage_hr'] = wageHr;
    data['work_hr'] = workHr;
    return data;
  }
}
