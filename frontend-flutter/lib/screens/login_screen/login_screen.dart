import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sentimento/bloc/auth_bloc/auth_bloc.dart';
import 'package:sentimento/screens/home_screen/home_screen.dart';
import 'package:sentimento/utilities/routes.dart';
import 'package:sentimento/utilities/validators.dart';
import 'package:sentimento/widgets/header_clippath.dart';
import 'package:sentimento/widgets/loading_screen.dart';
import 'package:sentimento/widgets/minor_ui_parts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginKey = GlobalKey<FormState>();
  TextEditingController emailField = TextEditingController();
  TextEditingController passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) => AuthBloc(LoadingState())..add(InitialEvent()),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is LoggedOutState) {
              return Material(
                child: Scaffold(
                  body: Stack(children: <Widget>[
                    const HeaderClipPath(times: 0.5),
                    SizedBox(
                      height: size.height * 0.5,
                      width: double.maxFinite,
                      child: Image.asset(
                        "lib/assets/icon.PNG",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Form(
                          key: _loginKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: size.height * 0.5,
                              ),
                              TextFormField(
                                controller: emailField,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  return TextFieldValidator.emailValidator(
                                      value);
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                    hintText: "Email",
                                    prefixIcon: Icon(
                                      CupertinoIcons.mail,
                                    )),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              TextFormField(
                                controller: passwordField,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return TextFieldValidator.passwordValidator(
                                      value);
                                },
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: "Password",
                                    prefixIcon: Icon(CupertinoIcons.padlock)),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              state is LoadingState
                                  ? showLoading(context)
                                  : ButtonTheme(
                                      minWidth: double.maxFinite,
                                      height: 40,
                                      child: RaisedButton(
                                          onPressed: () {
                                            if (_loginKey.currentState!
                                                .validate()) {
                                              context.read<AuthBloc>().add(
                                                  LoginClickedEvent(
                                                      email: emailField.text,
                                                      password:
                                                          passwordField.text));
                                            }
                                          },
                                          child: const Text(
                                            "Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )),
                                    ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text("New User?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.registerscreen);
                                  },
                                  child: const Text(
                                    "Create Account",
                                    style: TextStyle(fontSize: 16),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            } else if (state is MessageState) {
              manualToastMsg(state.message);
            } else if (state is LoggedInState) {
              return const HomeScreen();
            } else if (state is LoadingState) {
              return const LoadingScreen();
            }
            return const LoginScreen();
          },
        ));
  }
}
