import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:front_moon_srs/screens/auth/login.store.dart';
import 'package:front_moon_srs/shared/themes/app_colors.dart';
import 'package:front_moon_srs/shared/themes/app_dimens.dart';
import 'package:front_moon_srs/shared/themes/app_text_styles.dart';
import 'package:front_moon_srs/shared/widgets/app_button_text.dart';
import 'package:front_moon_srs/shared/widgets/app_input.dart';
import 'package:front_moon_srs/routes.dart' as route;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String route = "login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore _loginStore = LoginStore();
  final FocusNode _focusPassword = FocusNode();

  bool isPasswordHidden = true;

  @override
  void initState() {
    fetchDataInit();

    super.initState();
  }

  Future<void> fetchDataInit() async {
    await _loginStore.init(context);
  }

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
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Observer(
            builder: (_) => Column(
              children: [
                _loginForm(),
              ],
            ),
          ),
        ));
  }

  Widget _loginForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 310,
          ),
          AppInput(
            hintText: "username",
            value: _loginStore.formSignIn.username,
            onChange: (value) {
              _loginStore.formSignIn.username = value;
            },
            errorText: _loginStore.errorMessage,
            validator: _validateLogin,
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
            obscureText: isPasswordHidden,
            sulfixIcon: true,
            onTapSulfixIcon: () {
              _togglePasswordVisibility();
            },
            value: _loginStore.formSignIn.password,
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
                      context, route.signUp, (route) => false);
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
                    final ret = await _loginStore.signIn();

                    if (ret) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, route.home, (route) => false);
                    } else {
                      print("${_loginStore.errorMessage}");
                    }
                  })
            ],
          )
        ],
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  String? _validateLogin(String? text) {
    return _loginStore.authService.validateUsername(text ?? "");
  }

  String? _validatePassword(String? text) {
    if (text!.isEmpty) return "Campo Senha Vazio";

    return null;
  }
}
