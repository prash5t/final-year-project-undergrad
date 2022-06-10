import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sentimento/api/auth_requests.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(ProfileLoadingState profileLoadingState)
      : super(ProfileLoadingState()) {
    on<GetUserProfile>(_getUserProfile);
  }

  FutureOr<void> _getUserProfile(
      GetUserProfile getUserProfile, Emitter<ProfileState> emit) async {
    //using this loading state, will show profile loading design in UI
    emit.call(ProfileLoadingState());

    //when loading task finishes, now will show user's profile to UI
    try {
      var profileResponse = await requestProfile();
      if (profileResponse["success"] == "true") {
        emit.call(ProfileLoadedState(
            name: profileResponse["name"],
            email: profileResponse["email"],
            purpose: profileResponse["purpose"],
            analysisCount: profileResponse["analysis_count"],
            vacancyCount: profileResponse["vacancy_count"]));
      } else {
        emit.call(ProfileFailedState(message: profileResponse["msg"]));
      }
    } catch (e) {
      emit.call(ProfileFailedState(message: "No internet or try again"));
    }
  }
}
