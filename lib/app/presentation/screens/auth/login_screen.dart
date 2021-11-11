import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:front_moon_srs/app/authentication/data/sources/locar_storage.source.dart';
import 'package:front_moon_srs/app/presentation/screens/auth/login.store.dart';
import 'package:front_moon_srs/app/shared/themes/app_colors.dart';
import 'package:front_moon_srs/app/shared/themes/app_dimens.dart';
import 'package:front_moon_srs/app/shared/themes/app_text_styles.dart';
import 'package:front_moon_srs/app/shared/widgets/app_button_text.dart';
import 'package:front_moon_srs/app/shared/widgets/app_input.dart';
import 'package:front_moon_srs/core/app_config.dart';
import 'package:front_moon_srs/core/routes/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore _loginStore = LoginStore();
  final FocusNode _focusPassword = FocusNode();

  var username = "";
  var password = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchDataInit();
    });
  }

  Future<void> fetchDataInit() async {
    await _loginStore.init(context);
    username = await LocalStorageSource.getString('user_username');
    print(username);
    password = await LocalStorageSource.getString('user_password');
    print(password);

    setState(() {
      username;
      password;
    });
  }

  Future<void> fetchDataChange() async {}
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Observer(
        builder: (_) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppConfig.WHERE_AM_I != ""
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: AppColors.red,
                      ),
                      child: Text(
                        "${AppConfig.WHERE_AM_I}",
                        style: AppTextStyles.smallContentWhite,
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 100,
              ),
              _loginForm(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppInput(
              hintText: "username",
              value:
                  username != "" ? username : _loginStore.formSignIn.username,
              onChange: (value) {
                _loginStore.formSignIn.username = value;
              },
              errorText: _loginStore.errorMessage,
              validator: _loginStore.validateLogin,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              nextFocus: _focusPassword,
            ),
            SizedBox(
              height: AppDimens.space * 2,
            ),
            AppInput(
              errorText: _loginStore.errorMessage,
              hintText: "password",
              obscureText: _loginStore.isPasswordHidden,
              sulfixIcon: true,
              onTapSulfixIcon: () {
                setState(() {
                  _loginStore.togglePasswordVisibility();
                });
              },
              value:
                  password != "" ? password : _loginStore.formSignIn.password,
              onChange: (value) {
                _loginStore.formSignIn.password = value;
              },
              keyboardType: TextInputType.text,
              focusNode: _focusPassword,
            ),
            if (_loginStore.errorMessage != "")
              SizedBox(
                height: AppDimens.space,
              ),
            Text(
              _loginStore.errorMessage,
              style: AppTextStyles.textError,
            ),
            SizedBox(
              height: AppDimens.space * 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.signUp, (route) => false);
                  },
                  child: Text(
                    "Sign up",
                    style: AppTextStyles.textButtonUnderline,
                  ),
                ),
                AppButtonText(
                    content: "Login",
                    width: 115,
                    height: 41,
                    onPressed: () async {
                      if (_loginStore.formSignIn.username == "") {
                        _loginStore.formSignIn.username = username;
                      }
                      if (_loginStore.formSignIn.password == "") {
                        _loginStore.formSignIn.password = password;
                      }
                      final ret = await _loginStore.signIn();

                      if (ret) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.home, (route) => false);
                      } else {
                        print("${_loginStore.errorMessage}");
                      }
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
