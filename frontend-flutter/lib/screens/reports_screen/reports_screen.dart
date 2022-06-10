import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentimento/bloc/reports_bloc/report_bloc.dart';
import 'package:sentimento/screens/home_screen/home_screen.dart';
import 'package:sentimento/screens/reports_screen/report_loaded.dart';
import 'package:sentimento/screens/reports_screen/report_loading.dart';
import 'package:sentimento/widgets/minor_ui_parts.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReportBloc(ReportLoadingState())..add(GetUserReport()),
      child: BlocBuilder<ReportBloc, ReportState>(builder: (context, state) {
        if (state is ReportLoadingState) {
          return const ReportLoading();
        } else if (state is ReportLoadedState) {
          return LoadedReport(reports: state.reports!);
        } else if (state is ReportFailedState) {
          manualToastMsg(state.message);
        }
        return const HomeScreen();
      }),
    );
  }
}
