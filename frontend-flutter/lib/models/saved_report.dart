class ReportModel {
  String? msg;
  List<Reports>? reports;
  String? success;

  ReportModel({this.msg, this.reports, this.success});

  ReportModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['reports'] != null) {
      reports = <Reports>[];
      json['reports'].forEach((v) {
        reports!.add(Reports.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (reports != null) {
      data['reports'] = reports!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class Reports {
  String? analysisTime;
  String? data;
  int? dataCount;
  int? id;
  int? negativeCount;
  int? neutralCount;
  String? overallPolarity;
  String? platform;
  int? positiveCount;
  int? sarcasmCount;
  int? spamCount;

  Reports(
      {this.analysisTime,
      this.data,
      this.dataCount,
      this.id,
      this.negativeCount,
      this.neutralCount,
      this.overallPolarity,
      this.platform,
      this.positiveCount,
      this.sarcasmCount,
      this.spamCount});

  Reports.fromJson(Map<String, dynamic> json) {
    analysisTime = json['analysis_time'];
    data = json['data'];
    dataCount = json['data_count'];
    id = json['id'];
    negativeCount = json['negative_count'];
    neutralCount = json['neutral_count'];
    overallPolarity = json['overall_polarity'];
    platform = json['platform'];
    positiveCount = json['positive_count'];
    sarcasmCount = json['sarcasm_count'];
    spamCount = json['spam_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['analysis_time'] = analysisTime;
    data['data'] = this.data;
    data['data_count'] = dataCount;
    data['id'] = id;
    data['negative_count'] = negativeCount;
    data['neutral_count'] = neutralCount;
    data['overall_polarity'] = overallPolarity;
    data['platform'] = platform;
    data['positive_count'] = positiveCount;
    data['sarcasm_count'] = sarcasmCount;
    data['spam_count'] = spamCount;
    return data;
  }
}
