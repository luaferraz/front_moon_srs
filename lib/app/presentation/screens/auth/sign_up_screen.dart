import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front_moon_srs/app/presentation/screens/auth/sign_up.store.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';
import 'package:front_moon_srs/app/shared/themes/app_dimens.dart';
import 'package:front_moon_srs/app/shared/widgets/app_button_text.dart';
import 'package:front_moon_srs/app/shared/widgets/app_dialog.dart';
import 'package:front_moon_srs/app/shared/widgets/app_input.dart';
import 'package:front_moon_srs/core/routes/routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpStore _signUpStore = SignUpStore();

  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPassword = FocusNode();
  final FocusNode _focusPasswordConfirm = FocusNode();

  final _formKey = GlobalKey<FormState>();

  bool isPasswordHidden = true;

  @override
  void initState() {
    fetchDataInit();

    super.initState();
  }

  Future<void> fetchDataInit() async {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      fetchDataChange();
    });
  }

  Future<void> fetchDataChange() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _signUpForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppInput(
              hintText: "username",
              onChange: (value) {
                _signUpStore.formSignUp.username = value;
              },
              validator: _validateUsername,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              nextFocus: _focusEmail,
            ),
            SizedBox(
              height: AppDimens.space * 2,
            ),
            AppInput(
              hintText: "email",
              onChange: (value) {
                _signUpStore.formSignUp.email = value;
              },
              validator: _validateEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              focusNode: _focusEmail,
              nextFocus: _focusPassword,
            ),
            SizedBox(
              height: AppDimens.space * 2,
            ),
            AppInput(
              hintText: "password",
              onChange: (value) {
                _signUpStore.formSignUp.password = value;
              },
              validator: _validatePassword,
              errorText: _validatePassword(_signUpStore.formSignUp.password),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              focusNode: _focusPassword,
              nextFocus: _focusPasswordConfirm,
            ),
            SizedBox(
              height: AppDimens.space * 2,
            ),
            AppInput(
              hintText: "password confirm",
              onChange: (value) {
                _signUpStore.formSignUp.passwordConfirm = value;
              },
              validator: _validateConfirmPassword,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              focusNode: _focusPasswordConfirm,
            ),
            SizedBox(
              height: AppDimens.space * 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButtonText(
                    content: "cancel",
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.login, (route) => false);
                    }),
                AppButtonText(
                  content: "sign up",
                  width: 115,
                  height: 41,
                  onPressed: () async {
                    bool formOk = _formKey.currentState!.validate();

                    if (!formOk) return;

                    bool ret = await _signUpStore.signUp();

                    if (ret) {
                      AppModal(
                        context: context,
                        title: "cadastrado com sucesso!",
                        actions: [
                          AppButtonText(
                            content: "ok",
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, Routes.login, (route) => false);
                            },
                          )
                        ],
                      );
                    } else {
                      AppModal(
                        context: context,
                        title: "ocorreu um erro ${_signUpStore.errorMessage}",
                        actions: [
                          AppButtonText(
                            content: "ok",
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _togglePasswordVisibility() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  String? _validateUsername(String? username) {
    if (username!.isEmpty) return "cannot be empty";
    if (username.contains(RegExp(r'[A-Z]'))) {
      return "username needs at least one letter in uppercase";
    }
    if (username.length < 2) {
      return "username needs to have at lest 3 characters";
    }

    return null;
  }

  String? _validatePassword(String? password) {
    if (password!.isEmpty) return "cannot be empty";
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return "at least one letter in uppercase";
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return "password needs at least one number";
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "password needs to have special character (@!#%)";
    }
    if (password.length < 3) {
      return "passwords needs to have at lest 3 characters";
    }

    return null;
  }

  String? _validateConfirmPassword(String? password) {
    if (password!.isEmpty) return "cannot be empty";
    if (password != _signUpStore.formSignUp.password)
      return "the password fields must be the same";

    return null;
  }

  String? _validateEmail(String? email) {
    if (email!.isEmpty) return "cannot be empty";
    if (!email.contains(RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))) {
      return "please enter an valid email";
    }

    return null;
  }
}
