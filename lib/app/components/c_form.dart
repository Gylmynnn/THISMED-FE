import 'package:flutter/material.dart';
import 'package:thismed/app/utils/themes/views/theme_view.dart';

class CsFormField extends StatelessWidget {
  const CsFormField(
      {super.key,
      this.controller,
      required this.placeholder,
      this.obsecureText,
      this.suffixIcon,
      this.textValidator,
      this.fullBorder = false});

  final TextEditingController? controller;
  final String placeholder;
  final bool? obsecureText;
  final bool? fullBorder;
  final String? textValidator;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obsecureText ?? false,
        style:
            greyTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
        validator: (value) => value == '' ? textValidator! : null,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          filled: true,
          fillColor: fullBorder == true
              ? Colors.transparent
              : secondaryTextColor.withAlpha(40),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: fullBorder == true
              ? const OutlineInputBorder(
                  gapPadding: 0.0,
                  borderRadius: BorderRadius.all(Radius.circular(12)))
              : const OutlineInputBorder(borderSide: BorderSide.none),
          labelText: placeholder,
          labelStyle: grey2TextStyle.copyWith(
              fontSize: 18, fontWeight: FontWeight.w600),
        ));
  }
}
