import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentimento/bloc/profile_bloc/profile_bloc.dart';
import 'package:sentimento/screens/home_screen/home_screen.dart';
import 'package:sentimento/screens/profile_screen/bloc_profile_page.dart';
import 'package:sentimento/widgets/minor_ui_parts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileBloc(ProfileLoadingState())..add(GetUserProfile()),
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const ProfilePage(
              profileState: "loading",
              name: "",
              email: "",
              purpose: "",
              analysisCount: "",
              vacancyCount: "");
        } else if (state is ProfileLoadedState) {
          return ProfilePage(
              profileState: "loaded",
              name: state.name,
              email: state.email,
              purpose: state.purpose,
              analysisCount: state.analysisCount,
              vacancyCount: state.vacancyCount);
        } else if (state is ProfileFailedState) {
          manualToastMsg(state.message);
        }
        return const HomeScreen();
      }),
    );
  }
}
