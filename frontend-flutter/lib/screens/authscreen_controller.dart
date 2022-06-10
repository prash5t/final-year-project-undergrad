import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentimento/bloc/auth_bloc/auth_bloc.dart';
import 'package:sentimento/screens/getstarted_screen/getstarted_screen.dart';
import 'package:sentimento/screens/home_screen/home_screen.dart';
import 'package:sentimento/widgets/minor_ui_parts.dart';

class AuthScreenController extends StatelessWidget {
  const AuthScreenController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(LoadingState())..add(SessionCheckerEvent()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is LoggedInState) {
            return const HomeScreen();
          } else if (state is MessageState) {
            manualToastMsg(state.message);
          } else if (state is LoggedOutState) {
            return const GetStartedScreen();
          }
          return showLoading(context);
        },
      ),
    );
  }
}
