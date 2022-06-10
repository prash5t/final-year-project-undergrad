import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sentimento/api/auth_requests.dart';
import 'package:sentimento/utilities/securestorage.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(LoadingState loadingState) : super(LoadingState()) {
    on<SessionCheckerEvent>(_sessionChecker);
    on<LoginClickedEvent>(_loginClick);
    on<RegisterClickedEvent>(_registerClick);
    on<InitialEvent>(_initialEvent);
  }

  FutureOr<void> _initialEvent(
      InitialEvent initialEvent, Emitter<AuthState> emit) {
    emit.call(LoggedOutState());
  }

  FutureOr<void> _sessionChecker(
      SessionCheckerEvent sessionClickedEvent, Emitter<AuthState> emit) async {
    emit.call(LoadingState());
    //checks if bearer token is saved or not
    bool userLoggedIn = await isLoggedIn();
    if (userLoggedIn) {
      emit.call(LoggedInState());
    } else if (!userLoggedIn) {
      emit.call(LoggedOutState());
    }
  }

  FutureOr<void> _loginClick(
      LoginClickedEvent loginClickedEvent, Emitter<AuthState> emit) async {
    emit.call(LoadingState());
    try {
      var loginResponse = await requestLogin(
          loginClickedEvent.email, loginClickedEvent.password);
      authValidatior(loginResponse, emit);
    } catch (e) {
      emit.call(MessageState(message: "No internet or try again"));
    }
  }

  FutureOr<void> _registerClick(RegisterClickedEvent registerClickedEvent,
      Emitter<AuthState> emit) async {
    emit.call(LoadingState());
    try {
      var registerResponse = await requestRegister(
          registerClickedEvent.fullName,
          registerClickedEvent.email,
          registerClickedEvent.password,
          registerClickedEvent.purpose);
      authValidatior(registerResponse, emit);
    } catch (e) {
      emit.call(MessageState(message: "No internet or try again"));
    }
  }

  void authValidatior(backendResponse, Emitter<AuthState> emit) async {
    if (backendResponse["success"] == "true") {
      //when login request is valid, will save token and take user to home screen
      saveUserInfo(backendResponse["access_token"], backendResponse["name"],
          backendResponse["email"]);
      emit.call(MessageState(message: backendResponse["msg"]));
      //await Future.delayed(const Duration(milliseconds: 500));
      emit.call(LoggedInState());
    } else {
      emit.call(MessageState(message: backendResponse["msg"]));
      // emit.call(LoggedOutState());
    }
  }
}
