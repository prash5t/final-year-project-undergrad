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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<String> professionList = [
    "Data Analysis",
    "Marketing",
    "Social Media Influencing",
    "Education Purpose",
    "News/Current Affairs",
    "Financial Analysis",
    "Others"
  ];
  final _registerKey = GlobalKey<FormState>();
  TextEditingController nameField = TextEditingController();
  TextEditingController emailField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  String?
      profession; //drop down menu don't have controller property so declaring string var

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) =>
            AuthBloc(LoadingState())..add(SessionCheckerEvent()),
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is LoggedOutState) {
            return Material(
              child: Scaffold(
                body: Stack(children: <Widget>[
                  const HeaderClipPath(times: 0.4),
                  SizedBox(
                    height: size.height * 0.4,
                    width: double.maxFinite,
                    //color: Colors.red,
                    child: Image.asset(
                      "lib/assets/icon.PNG",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Form(
                        key: _registerKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: size.height * 0.4,
                            ),
                            TextFormField(
                              controller: nameField,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                return TextFieldValidator.nameValidator(value);
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                  hintText: "Name",
                                  prefixIcon: Icon(
                                    CupertinoIcons.person,
                                  )),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.work_outline)),
                              hint: const Text("Intention of Use"),
                              isExpanded: true,
                              value: profession,
                              onChanged: (newValue) {
                                setState(() {
                                  profession = newValue as String?;
                                });
                              },
                              items: professionList.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList(),
                              validator: (value) =>
                                  value == null ? 'Select your purpose' : null,
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            TextFormField(
                              controller: emailField,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                return TextFieldValidator.emailValidator(value);
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
                            ButtonTheme(
                              minWidth: double.maxFinite,
                              height: 40,
                              child: RaisedButton(
                                  onPressed: () {
                                    if (_registerKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(
                                          RegisterClickedEvent(
                                              fullName: nameField.text,
                                              purpose: profession!,
                                              email: emailField.text,
                                              password: passwordField.text));
                                    }
                                  },
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text("Returning User?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.loginscreen);
                                },
                                child: const Text(
                                  "Login Instead",
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
          return const RegisterScreen();
        }));
  }
}
