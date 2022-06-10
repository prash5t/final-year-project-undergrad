import 'package:flutter/material.dart';
import 'package:sentimento/api/mynetwork_requests.dart';
import 'package:sentimento/models/post_model.dart';
import 'package:sentimento/utilities/routes.dart';
import 'package:sentimento/utilities/validators.dart';

class PostFields extends StatefulWidget {
  const PostFields({Key? key, required this.isVacancy}) : super(key: key);
  final bool isVacancy;
  @override
  _PostFieldsState createState() => _PostFieldsState();
}

class _PostFieldsState extends State<PostFields> {
  final _postKey = GlobalKey<FormState>();
  TextEditingController emailField = TextEditingController();
  TextEditingController roleField = TextEditingController();
  TextEditingController phoneField = TextEditingController();
  TextEditingController descriptionField = TextEditingController();
  TextEditingController hourField = TextEditingController();
  TextEditingController wageField = TextEditingController();
  bool isNegotiable = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.2, left: 18, right: 18),
        child: Form(
          key: _postKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: roleField,
                keyboardType: TextInputType.text,
                validator: (value) {
                  return TextFieldValidator.roleValidator(value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                    labelText: "Role", prefixIcon: Icon(Icons.work_outline)),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: emailField,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  return TextFieldValidator.emailValidator(value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                    labelText: "Contact Email",
                    prefixIcon: Icon(Icons.email_outlined)),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                  controller: phoneField,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    return TextFieldValidator.phoneNumberValidator(value);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: "Contact Number",
                    prefixIcon: Icon(
                      Icons.phone_android_outlined,
                    ),
                  )),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                  controller: hourField,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return TextFieldValidator.workHrValidator(value);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: "Working Hours",
                    prefixIcon: Icon(
                      Icons.lock_clock_outlined,
                    ),
                  )),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                  controller: wageField,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    return TextFieldValidator.wageValidator(value);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: "Wage/hr",
                    prefixIcon: Icon(
                      Icons.attach_money,
                    ),
                  )),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                  maxLength: 500,
                  maxLines: 5,
                  minLines: 1,
                  controller: descriptionField,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    return TextFieldValidator.descriptionValidator(value);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: widget.isVacancy
                        ? "Vacancy Description"
                        : "Service Description",
                    prefixIcon: const Icon(Icons.description_outlined),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Negotiable",
                    style: TextStyle(fontSize: 17, color: Colors.black54),
                  ),
                  Checkbox(
                      //checkColor: Colors.greenAccent,
                      activeColor: Colors.teal,
                      value: isNegotiable,
                      onChanged: (bool? value) {
                        setState(() {
                          isNegotiable = value!;
                        });
                      }),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_postKey.currentState!.validate()) {
                      Vacancy post = Vacancy();
                      post.title = roleField.text;
                      post.contactEmail = emailField.text;
                      post.contactNumber = phoneField.text;
                      post.description = descriptionField.text;
                      post.workHr = int.parse(hourField.text);
                      post.wageHr = wageField.text;
                      post.isNegotiable = isNegotiable;
                      post.isVacancy = widget.isVacancy;

                      var resp = await addNewPost(post);
                      if (resp["success"] == "true") {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.homescreen, (route) => false);
                      }
                    }
                  },
                  child:
                      Text(widget.isVacancy ? "Post Vacancy" : "Post Service")),
              const SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
