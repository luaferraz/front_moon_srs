import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front_moon_srs/shared/themes/app_colors.dart';
import 'package:front_moon_srs/shared/themes/app_text_styles.dart';

class AppInput extends StatelessWidget {
  bool obscureText = false;
  String? value;
  String? hintText;
  String? errorText;
  TextEditingController? textEditingController;
  FormFieldValidator<String>? validator;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;
  FocusNode? focusNode;
  FocusNode? nextFocus;
  Function(dynamic) onChange;
  Function? onTap;
  List<TextInputFormatter>? inputFormatters;
  bool sulfixIcon = false;
  Function? onTapSulfixIcon;

  AppInput({
    Key? key,
    required this.onChange,
    this.onTap,
    this.hintText,
    this.value,
    this.errorText,
    this.obscureText = false,
    this.textEditingController,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
    this.inputFormatters,
    this.sulfixIcon = false,
    this.onTapSulfixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (textEditingController == null) {
      textEditingController = TextEditingController();

      if (value != null) {
        textEditingController!.text = value!;
        textEditingController!.selection = TextSelection.fromPosition(
            TextPosition(offset: textEditingController!.text.length));
      }
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: TextFormField(
        onTap: onTap != null ? () => onTap!() : () {},
        onChanged: (data) {
          onChange(data);
        },
        controller: textEditingController,
        obscureText: obscureText,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onFieldSubmitted: (String text) {
          if (nextFocus != null) FocusScope.of(context).requestFocus(nextFocus);
        },
        decoration: InputDecoration(
          suffixIcon: sulfixIcon
              ? obscureText
                  ? IconButton(
                      icon: Icon(
                        Icons.visibility_off,
                        color: AppColors.darkGrey,
                      ),
                      onPressed: onTapSulfixIcon != null
                          ? () => onTapSulfixIcon!()
                          : () {},
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.visibility,
                        color: AppColors.darkGrey,
                      ),
                      onPressed: onTapSulfixIcon != null
                          ? () => onTapSulfixIcon!()
                          : () {},
                    )
              : null,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.lightGrey, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
          hintText: hintText,
        ),
      ),
    );
  }
}
