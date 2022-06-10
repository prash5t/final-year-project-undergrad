import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sentimento/api/analysis_requests.dart';
import 'package:sentimento/models/saved_report.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc(ReportLoadingState reportLoadingState)
      : super(ReportLoadingState()) {
    on<GetUserReport>(_getUserReport);
  }
  FutureOr<void> _getUserReport(
      GetUserReport getUserReport, Emitter<ReportState> emit) async {
    //using this loading state, will show report loading UI
    emit.call(ReportLoadingState());

    //when loading task finishes, now will show saved reports
    try {
      ReportModel reportsModel = await viewSentimentReports();
      reportsModel.success == "true"
          ? emit.call(ReportLoadedState(reports: reportsModel.reports))
          : emit.call(ReportFailedState(message: reportsModel.msg));
    } catch (e) {
      emit.call(ReportFailedState(message: "No internet or try again"));
    }
  }
}
